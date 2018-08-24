//
//  TestTableViewCell.m
//  test
//
//  Created by baiyi on 2018/7/30.
//  Copyright © 2018年 dong. All rights reserved.
//

#import "TestTableViewCell.h"
#import "TestDataModel.h"
#import "TestModel.h"
#import "UIImageView+WebCache.h"

@interface TestTableViewCell ()

/** bgview */
@property(nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIImageView * iconImageView;
@property (nonatomic,strong) UILabel * nameLabel;
@property (nonatomic,strong) UILabel * timeLabel;
@property (nonatomic,strong) UIButton * reportBtn;
/** 顶部背景 */
@property(nonatomic,strong) UIView *topBgView;
//中间部分
@property (nonatomic,strong) UILabel * contentLabel;
/** 副标题 */
@property(nonatomic,strong) UILabel *desLabel;
/** 图片 */
@property(nonatomic,strong) UIImageView *oneImageView;
/** 多图 */
@property(nonatomic,strong) UIView *imageViews;


@end

@implementation TestTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createBase];
    }
    return self;
}

- (void)createBase{
    
    self.backgroundColor = RGB_Same(249);
    
    //底部白色背景
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake((10), 0, SCREEN_WIDTH-2*(10), 0)];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.bgView];
    
    //头像所在view
    self.topBgView = [[UIView alloc] initWithFrame:CGRectZero];
    self.topBgView.backgroundColor = [UIColor clearColor];
    [self.bgView addSubview:self.topBgView];
    
    //头像
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake((10), 0, 25, 25)];
    self.iconImageView.image = [UIImage imageNamed:@"photo_xiaoxi"];
    self.iconImageView.userInteractionEnabled = YES;
    [self.topBgView addSubview:self.iconImageView];
    
    UITapGestureRecognizer * iconTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(iconTapClick)];
    [self.topBgView addGestureRecognizer:iconTap];
    
    //通知类型
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = RGB(61, 61, 61);
    self.nameLabel.font = CommonFontWithSize(14);
    self.nameLabel.text = @"通知类型";
    self.nameLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer * iconTapName = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(iconTapClick)];
    [self.nameLabel addGestureRecognizer:iconTapName];
    [self.topBgView addSubview:self.nameLabel];
    
    //时间
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.textColor = RGBA(143, 143, 143, 0.74);
    self.timeLabel.font = CommonFontWithSize(9);
    self.timeLabel.text = @"通知时间";
    [self.topBgView addSubview:self.timeLabel];
    
    //倒三角
    self.reportBtn = [[UIButton alloc] init];
    [self.reportBtn setImage:[UIImage imageNamed:@"home_new_content_cell_arrow"] forState:UIControlStateNormal];
    [self.reportBtn addTarget:self action:@selector(reportBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.topBgView addSubview:self.reportBtn];
    
    
    //文字/主标题
    self.contentLabel = [[UILabel alloc]init];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.font = CommonFontWithSize(14);
    [self.bgView addSubview:self.contentLabel];
    
    //副标题
    self.desLabel = [[UILabel alloc]init];
    self.desLabel.numberOfLines = 0;
    self.desLabel.font = CommonFontWithSize(11);
    self.desLabel.textColor = RGB_Same(143);
    [self.bgView addSubview:self.desLabel];
    
    //长图/右图
    self.oneImageView = [[UIImageView alloc] init];
    [self.bgView addSubview:self.oneImageView];
    
    //三张图
    self.imageViews = [[UIView alloc] init];
    [self.bgView addSubview:self.imageViews];
    for (NSInteger i = 0; i < 3; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.hidden = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.imageViews addSubview:imageView];
        
    }
    
}

//举报
- (void)reportBtnClick{
    
}

// 头像点击
- (void)iconTapClick{
    
}


- (void)setDataModel:(TestDataModel *)dataModel {
    
    _dataModel = dataModel;
    TestModel *model = dataModel.model;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.cc_icon]];
    self.iconImageView.frame = dataModel.iconFrame;
    
    self.nameLabel.text = model.uname;
    self.nameLabel.frame = dataModel.nameLabelFrame;
    
    self.timeLabel.text = model.addTime;
    self.timeLabel.frame = dataModel.timeLabelFrame;
    
    self.reportBtn.frame = dataModel.arrowFrame;
    
    self.topBgView.frame = dataModel.topBgFrame;
    
    self.topBgView.hidden = !dataModel.isShowTopIcon;
    
    if (dataModel.isShowContent) {
        
        self.contentLabel.attributedText = dataModel.contentAttributed;
        self.contentLabel.frame = dataModel.contentFrame;
        self.contentLabel.hidden = NO;
    }else {
        self.contentLabel.hidden = YES;
    }
    
    if (dataModel.isShowDesc) {
        
        self.desLabel.text = dataModel.model.desc;
        self.desLabel.frame = dataModel.descFrame;
        self.desLabel.hidden = NO;
    }else {
        self.desLabel.hidden = YES;
    }

    NSArray *imageUrls = dataModel.imageArray;

    if (dataModel.isShowOneImage) {
        
        [self.oneImageView sd_setImageWithURL:[NSURL URLWithString:imageUrls[0]] placeholderImage:[UIImage imageNamed:@"home_new_cell_img_moren"]];
        self.oneImageView.frame = dataModel.imageFrame;
        self.oneImageView.hidden = NO;
    }else {
        self.oneImageView.hidden = YES;
    }
    
    if (dataModel.isShowMoreImage) {
        self.imageViews.frame = dataModel.imageFrame;
        
        for (NSInteger i = 0; i < imageUrls.count ; i++) {
            
            UIImageView *imageView = (UIImageView *)self.imageViews.subviews[i];
            imageView.hidden = NO;
            NSString *url = imageUrls[i];
            [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"home_new_cell_img_moren"]];
            NSValue *value = dataModel.imageFrameArray[i];
            imageView.frame = [value CGRectValue];
        }
        
        self.imageViews.hidden = NO;
    }else {
        
        self.imageViews.hidden = YES;
    }
    
    self.bgView.frame = dataModel.bgViewFrame;
}


@end
