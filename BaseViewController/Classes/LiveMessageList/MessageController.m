//
//  MessageController.m
//  BaseViewController
//
//  Created by baiyi on 2018/7/5.
//  Copyright © 2018年 dong. All rights reserved.
//

#import "MessageController.h"

#import "MessageTableViewCell.h"
#import "MessageModel.h"
#import "MessageViewModel.h"
#import "NSObject+runtime.h"

@interface MessageController()<UITableViewDelegate,UITableViewDataSource,MessageViewModelDelegate>
/** tableview */
@property(nonatomic,strong) UITableView *tableView;
/** rank */
@property(nonatomic,strong) NSArray *ranks;
/** name */
@property(nonatomic,strong) NSArray *names;
/** text */
@property(nonatomic,strong) NSArray *contents;
/** data */
@property(nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation MessageController

- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"YYTextMessageListDemo";

    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavHeight, KScreenWidth, KScreenHeight-NavHeight) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[MessageTableViewCell class] forCellReuseIdentifier:@"MessageTableViewCell"];
    tableView.tableFooterView = [UIView new];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    self.ranks = @[@"-1",@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",];
    self.names = @[@"白衣哥",
                   @"青衣姐姐",
                   @"我是骚猪的骚",
                   @"小驴",
                   @"大队长",
                   @"白胖子牛逼",
                   @"直播间匿名用户",
                   @"暗含销魂",
                   @"默",
                   @"直播间的一根毒瘤这么长",
                   @"薄荷味的盛夏~",
                   @"我那是随意",
                   @"多余"];
    self.contents = @[@"来到了直播间",
                      @"高高兴兴的来到了直播间,欢迎欢迎我!",
                      @"习近平总书记近日在山东考察时，专程来到甲午海战故地刘公岛，来到古代海上丝绸之路起点的蓬莱市，冒雨登临蓬莱阁，推开历史厚重的大门，倾听岁月无声的启迪。",
                      @"一个大党大国的最高领导人，为什么要把历史摆在如此高的位置？从历史之中，他汲取着怎样的人生智慧和治国之道？",
                      @"八字中我是NB的么?",
                      @"爱读历史的习近平，对于历史典故常常信手拈来。2011年9月，在中央党校秋季学期开学典礼上的讲话中，他引用了许多历史典故",
                      @"在谈及即将举行的第七次中国－中东欧国家领导人会晤时，李克强指出，中国坚定支持欧洲一体化进程，支持一个团结、稳定、发展的欧盟。“16+1合作”是开放、透明、包容的跨区域合作平台，是中欧关系的重要组成部分和有益补充。我们始终坚持按照国际规则和欧盟法律法规同中东欧国家开展合作，这有利于促进欧洲平衡发展和一体化进程。欢迎欧洲企业积极参与“16+1合作”，实现互利多赢。",
                      @"如上海要求，自7月3日起，企业在上海市购买商品住房必须同时满足设立年限已满5年，在上海市累计缴纳税款金额已达100万元人民币，职工人数10名及以上且按照规定在该企业缴纳社保和公积金满5年等条件。西安、长沙和杭州则直接暂停企事业单位及其他机构在其限购区域内购房。",
                      @"这个消息比较短",
                      @"主播,我爱你",
                      @"主播我要给你生猴子主播我要给你生猴子主播我要给你生猴子主播我要给你生猴子主播我要给你生猴子",
                      @"啦啦啦啦啦啦",
                      @"啊哈哈哈哈"];
    
    
    [self p_Send];
    
    [MessageModel getAllIvarList];
    [MessageModel jp_getPropertis];
}

#pragma mark -发言
- (void)p_Send {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        MessageModel *model = [[MessageModel alloc] init];
        model.rank = self.ranks[arc4random_uniform(13)];
        model.name = self.names[arc4random_uniform(13)];
        model.content = self.contents[arc4random_uniform(13)];
        
        MessageViewModel *viewModel = [[MessageViewModel alloc] init];
        viewModel.model = model;
        
        [self.dataArray addObject:viewModel];
        
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.dataArray.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        [self p_Send];
    });
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageTableViewCell"];
    
    MessageViewModel *viewModel = self.dataArray[indexPath.row];
    cell.viewModel = viewModel;
    viewModel.delegate = self;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MessageViewModel *viewModel = self.dataArray[indexPath.row];
    return viewModel.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)viewModelDidSelectedRankWithModel:(MessageModel *)model {
    
    NSLog(@"当前 %@ 的等级是 %@ 级",model.name,model.rank);
}

- (void)viewModelDidSelectedNameWithModel:(MessageModel *)model {
    
    NSLog(@"点击了 %@ 的名字",model.name);
}

@end
