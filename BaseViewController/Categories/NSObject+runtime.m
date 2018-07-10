//
//  NSObject+runtime.m
//  runtime
//
//  Created by tztddong on 2016/11/1.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import "NSObject+runtime.h"
#import <objc/runtime.h>

const char * kPropertykey = "kPropertykey";

@implementation NSObject (runtime)


+ (NSArray *)jp_objcWithDictArray:(NSArray *)array{
    
    NSMutableArray *arrM = [NSMutableArray array];
    
    for (NSDictionary *dict in array) {
        
        id object = [self jp_objcWithDict:dict];
        
        [arrM addObject:object];
    }
    return arrM.copy;
}

+ (instancetype)jp_objcWithDict:(NSDictionary *)dict {
    
    //实例化当前类
    id object = [[self alloc] init];
    
    NSArray *prolist = [self jp_getPropertis];
    
    //遍历字典
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        if ([prolist containsObject:key]) {
            //判断字典对应的key是否在类中存在这个key
            //使用KVC赋值
            [object setValue:obj forKey:key];
        }
    }];
    
    return object;
}



+ (NSArray *)jp_getPropertis{
    
    //设置关联对象提高效率
    //取出关联对象 所关联的值
    NSArray *properlist = objc_getAssociatedObject(self, kPropertykey);
    if (properlist != nil) {
        return properlist;
    }
    
    unsigned int outCount = 0;
    objc_property_t *prolist = class_copyPropertyList([self class], &outCount);
    NSMutableArray *arrM = [NSMutableArray array];
    for (unsigned int i = 0 ; i < outCount ; i++) {
        objc_property_t property = prolist[i];
        const char* cName = property_getName(property);
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        [arrM addObject:name];
    }
    free(prolist);
    
    //此处设置关联对象
    objc_setAssociatedObject(self, kPropertykey, arrM.copy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return arrM.copy;
}

@end
