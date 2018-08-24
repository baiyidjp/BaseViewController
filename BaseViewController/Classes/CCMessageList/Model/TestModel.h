//
//  TestModel.h
//  test
//
//  Created by baiyi on 2018/7/30.
//  Copyright © 2018年 dong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestModel : NSObject

@property (nonatomic,strong) NSString * uname;
@property (nonatomic,strong) NSString * cc_icon;
@property (nonatomic,strong) NSString * img_url;
@property (nonatomic,strong) NSString * time;
@property (nonatomic,strong) NSString * addTime;
@property (nonatomic,strong) NSString * text;
@property (nonatomic,strong) NSString * type;
@property (nonatomic,strong) NSString * click_txt;
@property (nonatomic,strong) NSString * desc;//图片底部描述
@property (nonatomic,strong) NSArray  * img_urls;
/** isshow */
@property(nonatomic,strong) NSString *isshow;

@end
