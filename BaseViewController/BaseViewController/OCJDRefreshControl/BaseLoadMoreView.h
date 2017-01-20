//
//  BaseLoadMoreView.h
//  BaseViewController
//
//  Created by Keep丶Dream on 17/1/4.
//  Copyright © 2017年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^loadMoreDataBlock)();

typedef enum : NSUInteger {
    LoadMoreState_Normal,
    LoadMoreState_Pulling,
    LoadMoreState_Refreshing,
    LoadMoreState_NoData,
} LoadMoreState;

@interface BaseLoadMoreView : UICollectionReusableView

- (void)startAnimation;
- (void)stopAnimation;

/** LoadMoreState */
@property(nonatomic,assign) LoadMoreState state;

/** block */
@property(nonatomic,copy) loadMoreDataBlock loadMoreDataBlock;

@end
