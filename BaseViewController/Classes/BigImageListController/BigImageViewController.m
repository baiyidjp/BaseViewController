//
//  BigImageViewController.m
//  BaseViewController
//
//  Created by Keep丶Dream on 17/2/17.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "BigImageViewController.h"

//定义一个block
typedef BOOL(^RunloopBlock)(void);

@interface BigImageViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 时钟事件 */
@property(nonatomic,strong) NSTimer *timer;
/** 数组任务 */
@property(nonatomic,strong) NSMutableArray *tasks;
/** 最大任务数 */
@property(nonatomic,assign) NSUInteger maxQueueLength;
/** tableview */
@property(nonatomic,strong) UITableView *tableView;
@end

@implementation BigImageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timerMethod) userInfo:nil repeats:YES];
    
    _maxQueueLength = 20;
    
    self.tasks = [NSMutableArray array];
    
    self.title = @"加载大图-优化";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavHeight, self.view.bounds.size.width, self.view.bounds.size.height-NavHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    //添加Runloop监听
    [self addRunLoopObserver];
}

/** timerMethod */
- (void)timerMethod {
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell.contentView.subviews.count) {
        [cell.contentView jp_removeAllSubViews];
    }
    
    [self addLabel:cell];
    
    __weak typeof(self) weakself = self;
    [self addNewTask:^BOOL{
        
        [weakself addImage1:cell];
        return YES;
    }];
    
    [self addNewTask:^BOOL{
        
        [weakself addImage2:cell];
        return YES;
    }];
    
    [self addNewTask:^BOOL{
        
        [weakself addImage3:cell];
        return YES;
    }];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 110;
}

- (void)addLabel:(UITableViewCell *)cell {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, 300, 30)];
    label.text = @"优化体验顺畅";
    [cell.contentView addSubview:label];
}

/** addimage */
- (void)addImage1:(UITableViewCell *)cell {
    
    UIImageView *imv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 120, 60)];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"曼巴谢幕" ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    imv.contentMode = UIViewContentModeScaleAspectFit;
    imv.image = image;
    
    [cell.contentView addSubview:imv];
}
- (void)addImage2:(UITableViewCell *)cell {
    
    UIImageView *imv = [[UIImageView alloc] initWithFrame:CGRectMake(125, 40, 120, 60)];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"曼巴谢幕" ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    imv.contentMode = UIViewContentModeScaleAspectFit;
    imv.image = image;
    [cell.contentView addSubview:imv];
}
- (void)addImage3:(UITableViewCell *)cell {
    
    UIImageView *imv = [[UIImageView alloc] initWithFrame:CGRectMake(250, 40, 120, 60)];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"曼巴谢幕" ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    imv.contentMode = UIViewContentModeScaleAspectFit;
    imv.image = image;
    [cell.contentView addSubview:imv];
}

/** 添加新任务 */
- (void)addNewTask:(RunloopBlock)unit {
    
    //添加进数组
    [self.tasks addObject:unit];
    //保证数组不超出最大任务数
    if (self.tasks.count > _maxQueueLength) {
        [self.tasks removeObjectAtIndex:0];
    }
}


//定义一个回调函数
static void callBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    
    //拿到的info就是自己
    BigImageViewController *vc = (__bridge BigImageViewController *) info;
    
    //
    if (vc.tasks.count == 0) {
        return;
    }
    
    BOOL result = NO;
    
    while (result == NO) {
        
        //取出第一个执行
        RunloopBlock unit = vc.tasks.firstObject;
        result = unit();
        [vc.tasks removeObjectAtIndex:0];
    }
}

/** RunLoop的方法 都是C语言的 */
- (void)addRunLoopObserver {
    
    //拿到当前的RunLoop 子线程的Runloop默认只执行一次便关闭
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    
    //定义上下文
    /*
     CFIndex	version;
     void *	info;
     const void *(*retain)(const void *info);
     void	(*release)(const void *info);
     CFStringRef	(*copyDescription)(const void *info);

     */
    CFRunLoopObserverContext context = {
        0,
        (__bridge void *)(self),
        &CFRetain,
        &CFRelease,
        NULL
    };
    //定义一个观察者
    CFRunLoopObserverRef defaultModeObsever;
    //创建一个观察者
    defaultModeObsever = CFRunLoopObserverCreate(NULL, kCFRunLoopBeforeWaiting, YES, NSIntegerMax-99, &callBack, &context);
    //添加当前runloop的观察者
    CFRunLoopAddObserver(runloop, defaultModeObsever, kCFRunLoopDefaultMode);
    //C语言中出现 creat/copy/new 需要relese
    CFRelease(defaultModeObsever);
}


@end
