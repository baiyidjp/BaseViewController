//
//  TestViewController.m
//  BaseViewController
//
//  Created by Keep丶Dream on 17/1/4.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "TestViewController.h"
#import "JPLoadingHUD.h"
#import "UIBarButtonItem+Extension.h"
#import "BigImageTest.h"
#import "SVProgressHUD.h"

@interface TestViewController ()

@end

@implementation TestViewController
{
    NSMutableArray *_dataArray;
    NSOperationQueue *_queue;
}

//在导航控制器的子控制器中 改变状态栏的背景颜色
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Test";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.baseNavigationBar.barTintColor = [UIColor redColor];
    
    [self setupTableViewWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, self.view.bounds.size.width, self.view.bounds.size.height-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT)];
    
    
    
    _dataArray = [NSMutableArray array];
    for (int i = 0; i < 20; i++) {
        NSString *str = [NSString stringWithFormat:@"死数据--%d",i];
        [_dataArray addObject:str];
    }
    

    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"大图" fontSize:16 target:self action:@selector(clickBtn) isBack:NO];
    self.baseNavigationItem.rightBarButtonItem = rightItem;
    
}

- (void)clickBtn {
    
    [self.navigationController pushViewController:[[BigImageTest alloc] init] animated:YES];
}

- (void)setupTableViewWithFrame:(CGRect)frame {
    
    [super setupTableViewWithFrame:frame];
    
    [self.baseTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"点击--%zd",indexPath.row);
     [JPLoadingHUD showLoadingHUD];
//    [SVProgressHUD show];
    //测试同步执行异步请求
    [self syncExecuteAsyncRequest];
}

- (void)loadNewData {
    
    [_dataArray insertObject:@"下拉--新数据" atIndex:0];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.baseTableView reloadData];
        [self loadNewEndRefresh];
        if (_dataArray.count > 25) {
            [self noMoreData];
        }
    });
}

- (void)loadMoreData {
    
    [_dataArray addObject:@"上拉--新数据"];
    NSLog(@"1");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.baseTableView reloadData];
        if (_dataArray.count > 25) {
            [self noMoreData];
        }else {
            [self loadMoreEndRefresh];
        }
    });

}

#pragma mark - 测试同步执行异步请求
- (void)syncExecuteAsyncRequest {
    
    
    //1.任务一：
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        [self request:@"A"];
    }];
    
    //2.任务二：
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        [self request:@"B"];
    }];
    
    //3.任务三：
    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
        [self request:@"C"];
    }];
    
    //4.任务六：
    NSBlockOperation *operation4 = [NSBlockOperation blockOperationWithBlock:^{
        [self request:@"D"];
    }];
    
    //5.任务五：
    NSBlockOperation *operation5 = [NSBlockOperation blockOperationWithBlock:^{
        [self request:@"E"];
    }];
    
    //6.任务六：
    NSBlockOperation *operation6 = [NSBlockOperation blockOperationWithBlock:^{
        [self request:@"F"];
    }];
    
    //4.设置依赖
    [operation2 addDependency:operation1];      //任务二依赖任务一
    [operation3 addDependency:operation2];      //任务三依赖任务二
    [operation4 addDependency:operation3];
    [operation5 addDependency:operation4];
    [operation6 addDependency:operation5];
    //5.创建队列并加入任务
    _queue = [[NSOperationQueue alloc] init];
    //添加监听 监听队列是否全部执行完毕
    [_queue addObserver:self forKeyPath:@"operationCount" options:0 context:nil];
    [_queue addOperations:@[operation6,operation5,operation4,operation3, operation2, operation1] waitUntilFinished:NO];
   
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"operationCount"]) {
        NSOperationQueue *queue = (NSOperationQueue *)object;
        if (queue.operationCount == 0) {
            NSLog(@"全部完成");
//            [SVProgressHUD dismiss];
            //异步中执行的动画 需要改到主线程结束
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [JPLoadingHUD dismissLoadingHUD];
            });
        }
    }
}

- (void)request:(NSString *)index {
    
    NSString *strURL = @"openapi/onlineservices/querybyclassifyid.json";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@1 forKey:@"state"];
    [params setObject:[NSNumber numberWithInteger:20] forKey:@"shownum"];
    [params setObject:[NSNumber numberWithInteger:1] forKey:@"pageno"];
    
    /*
     借助GCD中的信号量dispatch_semaphore进行实现，即营造线程同步情况。
     
     dispatch_semaphore信号量为基于计数器的一种多线程同步机制。用于解决在多个线程访问共有资源时候，会因为多线程的特性而引发数据出错的问题。
     
     如果semaphore计数大于等于1，计数-1，返回，程序继续运行。如果计数为0，则等待。
     
     dispatch_semaphore_signal(semaphore)为计数+1操作。dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER)为设置等待时间，这里设置的等待时间是一直等待。我们可以通俗的理解为单柜台排队点餐，计数默认为0，每当有顾客点餐，计数+1，点餐结束-1归零继续等待下一位顾客。比较类似于NSLock。
     */
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    [[NetworkManager shared] RequestWithMethod:HttpMethod_POST Url:strURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",index);
        dispatch_semaphore_signal(semaphore);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@ failed",index);
        dispatch_semaphore_signal(semaphore);
    }];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}

- (void)dealloc {
    
    [_queue removeObserver:self forKeyPath:@"operationCount"];
}

@end
