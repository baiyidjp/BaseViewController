//
//  NSObject+runtime.h
//  runtime
//
//  Created by tztddong on 2016/11/1.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (runtime)

/** 单个字典转模型 */
+ (instancetype)jp_objcWithDict:(NSDictionary *)dict;

/** 字典数组的字典转模型 */
+ (NSArray *)jp_objcWithDictArray:(NSArray *)array;

/** 获取当前类的属性列表 */
+ (NSArray *)jp_getPropertis;

@end
