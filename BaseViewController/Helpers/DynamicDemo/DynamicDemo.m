//
//  DynamicDemo.m
//  BaseViewController
//
//  Created by Keep丶Dream on 17/2/20.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "DynamicDemo.h"
#import <objc/runtime.h>

@interface DynamicDemo ()

/** dict */
@property(nonatomic,strong) NSMutableDictionary *dictM;

@end

@implementation DynamicDemo

//dynamic 会告诉编译器 不要自动创建实现属性所用的实例变量,也不要为其创建存取方法(get/set)
@dynamic string,number,date,objc;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dictM = [NSMutableDictionary new];
    }
    return self;
}

// 动态解析 找不到的方法
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    
    NSString *selectorString = NSStringFromSelector(sel);
    //判断是设置方法还是获取方法
    //class_addMethod 动态添加方法
    if ([selectorString hasPrefix:@"set"]) {
        class_addMethod(self,
                        sel,
                        (IMP)dynamicDemoSetter,
                        "v@:@");
    }else {
        class_addMethod(self,
                        sel,
                        (IMP)dynamicDemoGetter,
                        "@@:");
    }
    return YES;
}

id dynamicDemoGetter(id self, SEL _cmd) {
    
    DynamicDemo *typeSelf = (DynamicDemo *)self;
    //获取字典
    NSMutableDictionary *dictM = typeSelf.dictM;
    
    NSString *selectorString = NSStringFromSelector(_cmd);
    
    return [dictM objectForKey:selectorString];
}

void dynamicDemoSetter(id self, SEL _cmd,id value) {
    
    DynamicDemo *typeSelf = (DynamicDemo *)self;
    //获取字典
    NSMutableDictionary *dictM = typeSelf.dictM;
    //获取方法名 并分解方法名作为Key
    NSString *selectorString = NSStringFromSelector(_cmd);
    //实际获取的应该是 以string为例 setString:
    //我们取值时使用的get方法名是 string
    //所以此时存值的时候应该 以string为key 去掉 : 和 set ,并且将大写 S 改为小写 s
    NSMutableString *key = [selectorString mutableCopy];
    //: 所在的范围和 set所在的范围
    NSRange lastRange = NSMakeRange(key.length-1, 1);
    NSRange setRange = NSMakeRange(0, 3);
    //移除
    [key deleteCharactersInRange:lastRange];
    [key deleteCharactersInRange:setRange];
    //大写变小写
    NSString *lowerStr = [[key substringToIndex:1] lowercaseString];
    [key replaceCharactersInRange:NSMakeRange(0, 1) withString:lowerStr];
    if (value) {
        [dictM setObject:value forKey:key];
    }else {
        [dictM removeObjectForKey:key];
    }
}

@end
