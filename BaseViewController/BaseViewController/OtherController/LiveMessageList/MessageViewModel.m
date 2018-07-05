//
//  MessageViewModel.m
//  BaseViewController
//
//  Created by baiyi on 2018/7/5.
//  Copyright © 2018年 dong. All rights reserved.
//

#import "MessageViewModel.h"
#import "MessageModel.h"
#import "YYText/YYText.h"

@implementation MessageViewModel

- (void)setModel:(MessageModel *)model {
    
    _model = model;
    
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    
    NSString *rankStr = [NSString stringWithFormat:@"Lv.%@",model.rank];
    NSString *rankImageName = @"LiveRoom_lv0";
    UIColor *rankColor = [UIColor whiteColor];
    NSInteger rank = [model.rank integerValue];
    if (rank == 0) {
        rankStr = @"路人";
        rankColor = [UIColor grayColor];
    }else if (rank > 0 && rank <= 3) {
        rankImageName = @"LiveRoom_lv1_3";
    }else if (rank > 3 && rank <= 7) {
        rankImageName = @"LiveRoom_lv4_7";
    }else if (rank > 7 && rank <= 10) {
        rankImageName = @"LiveRoom_lv8_10";
    }else if (rank > 10) {
        rankStr = @"钻石";
        rankImageName = @"LiveRoom_zuanshi";
    }else if (rank == -1) {
        //-1是主播
        rankImageName = @"LiveRoom_zhubo";
        rankStr = @"";
    }
    
    UIImage *rankImage = [UIImage imageNamed:rankImageName];
    UIButton *rankBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42, 20)];
    [rankBtn setBackgroundImage:rankImage forState:UIControlStateNormal];
    [rankBtn setTitle:rankStr forState:UIControlStateNormal];
    [rankBtn setTitleColor:rankColor forState:UIControlStateNormal];
    [rankBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [rankBtn addTarget:self action:@selector(p_ClickRank) forControlEvents:UIControlEventTouchUpInside];
    
    NSMutableAttributedString *rankImageAtt = [NSMutableAttributedString yy_attachmentStringWithContent:rankBtn contentMode:UIViewContentModeCenter attachmentSize:CGSizeMake(42, 20) alignToFont:[UIFont systemFontOfSize:13] alignment:YYTextVerticalAlignmentCenter];
    [text appendAttributedString:rankImageAtt];
    
    NSString *nameStr = [NSString stringWithFormat:@"%@:",model.name];
    CGSize nameSize = [nameStr boundingRectWithSize:CGSizeMake(KScreenWidth, 20) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    
    UIButton *nameBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, nameSize.width+10, 20)];
    [nameBtn setTitle:nameStr forState:UIControlStateNormal];
    [nameBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [nameBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [nameBtn addTarget:self action:@selector(p_ClickName) forControlEvents:UIControlEventTouchUpInside];
    NSMutableAttributedString *nameAtt = [NSMutableAttributedString yy_attachmentStringWithContent:nameBtn contentMode:UIViewContentModeCenter attachmentSize:CGSizeMake(nameSize.width+10, 20) alignToFont:[UIFont systemFontOfSize:15] alignment:YYTextVerticalAlignmentCenter];
    [text appendAttributedString:nameAtt];
    
    NSMutableAttributedString *contentAtt = [[NSMutableAttributedString alloc] initWithString:model.content];
    [contentAtt setYy_font:[UIFont systemFontOfSize:15]];
    [text appendAttributedString:contentAtt];
    
    text.yy_lineSpacing = 5;
    
    CGSize size = CGSizeMake(KScreenWidth-30, CGFLOAT_MAX);
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:size text:text];
    
    self.attributedText = text;
    
    self.contentFrame = CGRectMake(15, 15, KScreenWidth-30, layout.textBoundingSize.height);
    
    self.bgViewFrame = CGRectMake(10, 10, KScreenWidth-20, layout.textBoundingSize.height+10);
    
    self.cellHeight = CGRectGetMaxY(self.bgViewFrame);

}

#pragma mark -点击BTN
- (void)p_ClickRank {
    
    if ([self.delegate respondsToSelector:@selector(viewModelDidSelectedRankWithModel:)]) {
        [self.delegate viewModelDidSelectedRankWithModel:self.model];
    }
}

#pragma mark -点击BTN
- (void)p_ClickName {
    
    if ([self.delegate respondsToSelector:@selector(viewModelDidSelectedNameWithModel:)]) {
        [self.delegate viewModelDidSelectedNameWithModel:self.model];
    }
}


@end
