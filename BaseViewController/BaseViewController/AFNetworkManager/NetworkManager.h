//
//  NetworkManager.h
//  AFNetworkManager
//
//  Created by Keep丶Dream on 16/12/18.
//  Copyright © 2016年 dong. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 请求类型枚举
typedef enum : NSUInteger {
    HttpMethod_GET,
    HttpMethod_POST,
} HttpMethod;

/** 成功回调 */
typedef void(^successBlock)(NSURLSessionDataTask *task, id responseObject);
/** 失败回调 */
typedef void(^failureBlock)(NSURLSessionDataTask *task, NSError *error);


@interface NetworkManager : NSObject


/** 网络管理单例 */
+ (NetworkManager *)shared;

/** 取消全部网络请求 */
- (void)cancelAllRequest;

/**
 封装AFN请求
 
 @param httpMethod 请求类型  get/post
 @param urlStr 请求地址
 @param params 请求参数
 @param success 成功回调
 @param failure 失败回调
 */
- (void)RequestWithMethod:(HttpMethod)httpMethod
                      Url:(NSString *)urlStr
                   params:(NSDictionary *)params
                  success:(successBlock)success
                  failure:(failureBlock)failure;

/**
 封装AFN请求(已登录 无需传入登陆标识)
 
 @param httpMethod 请求类型  get/post
 @param urlStr 请求地址
 @param params 请求参数
 @param success 成功回调
 @param failure 失败回调
 */
- (void)LoginRequestWithMethod:(HttpMethod)httpMethod
                      Url:(NSString *)urlStr
                   params:(NSDictionary *)params
                  success:(successBlock)success
                  failure:(failureBlock)failure;

/**
 封装AFN请求(已登录 无需传入登陆标识 / 上传数据)
 
 @param httpMethod 请求类型  get/post
 @param urlStr 请求地址
 @param params 请求参数
 @param datas  二进制数据集合 [字典数据]->[name:@"xxx",data:xxx]
 @param success 成功回调
 @param failure 失败回调
 */
- (void)LoginUploadRequestWithMethod:(HttpMethod)httpMethod
                           Url:(NSString *)urlStr
                        params:(NSDictionary *)params
                         datas:(NSArray<NSDictionary *>*)datas
                        success:(successBlock)success
                        failure:(failureBlock)failure;

/**
 封装AFN上传数据请求(未登录 必须是POST请求)

 @param urlStr 请求地址
 @param params 请求参数
 @param datas  二进制数据集合 [字典数据]->[name:@"xxx",data:xxx] / [name:@"xxx",fileName:@"xxx"]
 @param success 成功回调
 @param failure 失败回调
 */
- (void)UploadRequestWithUrl:(NSString *)urlStr
                         params:(NSDictionary *)params
                          datas:(NSArray<NSDictionary *>*)datas
                        success:(successBlock)success
                        failure:(failureBlock)failure;

/**
 封装AFN下载

 @param urlStr 下载地址
 @param isResumeData 是否是断点续传
 @param progressBlock 进度回调
 @param downloadBlock 完成回调
 */
- (void)DownLoadDataRequestWithUrl:(NSString *)urlStr
                      isResumeData:(BOOL)isResumeData
                          progress:(void (^)(double downloadProgress))progressBlock
                   downloadSuccess:(void(^)(NSURL *filePath,BOOL isSuccess)) downloadBlock;

@end
