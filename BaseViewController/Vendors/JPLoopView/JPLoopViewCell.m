//
//  JPLoopViewCell.m
//  JPLoopViewDemo
//
//  Created by tztddong on 2016/10/31.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import "JPLoopViewCell.h"
#import "UIImageView+JPWebImage.h"
#import "JPLoopCellModel.h"

@interface JPLoopViewCell ()
/** imageView */
@property(nonatomic,strong) UIImageView *loopImageView;
/** label */
@property(nonatomic,strong) UILabel *loopTitleLabel;
/** bgView */
@property(nonatomic,strong) UIView *loopTitleBgView;

@end

@implementation JPLoopViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = frame;
        self.loopImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        [self.contentView addSubview:self.loopImageView];
        
        self.loopTitleBgView = [[UIView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:self.loopTitleBgView];
        
        self.loopTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:self.loopTitleLabel];
    }
    return self;
}

- (void)setCellModel:(JPLoopCellModel *)cellModel {
    
    _cellModel = cellModel;
    //如项目中用到成熟的第三方:SDWebImage 等 可替换
    [self.loopImageView jp_setImageWithURL:[NSURL URLWithString:cellModel.imageUrlStr] placeholderImage:cellModel.placeholderImage];
    
    BOOL isShowTitle = cellModel.isShowTitle;
    if (isShowTitle) {
        
        self.loopTitleLabel.text = cellModel.imageTitleStr;
        self.loopTitleLabel.font = cellModel.titleFont;
        self.loopTitleLabel.textColor = cellModel.titleColor;
        
        self.loopTitleBgView.backgroundColor = cellModel.bgViewColor;
        self.loopTitleBgView.frame = CGRectMake(cellModel.bgViewLeftOffset, self.frame.size.height-cellModel.bgViewHeight-cellModel.bgViewBottomOffset, self.frame.size.width-cellModel.bgViewLeftOffset-cellModel.bgViewRightOffset, cellModel.bgViewHeight);
        self.loopTitleLabel.frame = CGRectMake(CGRectGetMinX(self.loopTitleBgView.frame)+cellModel.titleLeftOffset, CGRectGetMinY(self.loopTitleBgView.frame), CGRectGetWidth(self.loopTitleBgView.frame)-cellModel.titleLeftOffset-cellModel.titleRightOffset, CGRectGetHeight(self.loopTitleBgView.frame));

        switch (cellModel.titleAliment) {
            case JPLoopViewTitleAlimentNone:
            {
                self.loopTitleLabel.hidden = self.loopTitleBgView.hidden = YES;
            }
                break;
            case JPLoopViewTitleAlimentLeft:
            {
                self.loopTitleLabel.hidden = self.loopTitleBgView.hidden = NO;
                self.loopTitleLabel.textAlignment = NSTextAlignmentLeft;
            }
                break;
            case JPLoopViewTitleAlimentCenter:
            {
                self.loopTitleLabel.hidden = self.loopTitleBgView.hidden = NO;
                self.loopTitleLabel.textAlignment = NSTextAlignmentCenter;
            }
                break;
            case JPLoopViewTitleAlimentRight:
            {
                self.loopTitleLabel.hidden = self.loopTitleBgView.hidden = NO;
                self.loopTitleLabel.textAlignment = NSTextAlignmentRight;
                
            }
                break;
        }
    }else {
        self.loopTitleLabel.hidden = self.loopTitleBgView.hidden = YES;
    }

}

@end
