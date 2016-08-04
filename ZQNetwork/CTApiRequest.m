//
//  CTApiRequest.m
//  ZQNetwork
//
//  Created by ZhouQian on 16/8/2.
//  Copyright © 2016年 ZhouQian. All rights reserved.
//

#import "CTApiRequest.h"
#import <AFNetworking.h>
#import <AFURLSessionManager.h>
#import <AFHTTPSessionManager.h>


@interface CTApiRequest ()
@property (nonatomic, strong) AFHTTPSessionManager *httpSessionManager;
@end
@implementation CTApiRequest


+ (instancetype)manager {
    static CTApiRequest *apir;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        apir = [[self alloc] initPrivate];
    });
    return apir;
}
- (instancetype)initPrivate {
    if (self = [super init]) {
        
    }
    return self;
}

- (AFHTTPSessionManager *)httpSessionManager {
    if (!_httpSessionManager) {
        _httpSessionManager = [AFHTTPSessionManager manager];
    }
    return _httpSessionManager;
}

- (void)callGetWithParam:(NSDictionary *)param urlString:(NSString *)url success:(successBlock)success failure:(failBlock)failure {
    [self requestWithMethod:@"GET" URLString:url param:param success:success failure:failure];
}
- (void)callPostWithParam:(NSDictionary *)param urlString:(NSString *)url success:(successBlock)success failure:(failBlock)failure {
    [self requestWithMethod:@"POST" URLString:url param:param success:success failure:failure];
}
- (void)callPutWithParam:(NSDictionary *)param urlString:(NSString *)url success:(successBlock)success failure:(failBlock)failure {
    [self requestWithMethod:@"PUT" URLString:url param:param success:success failure:failure];
}
- (void)callDeleteWithParam:(NSDictionary *)param urlString:(NSString *)url success:(successBlock)success failure:(failBlock)failure {
    [self requestWithMethod:@"DELETE" URLString:url param:param success:success failure:failure];
}

//可以在这边统一添加和处理网络连接
- (void)requestWithMethod:(NSString *)method
                URLString:(NSString *)URLString
                    param:(NSDictionary *)params
                  success:(void (^)(NSURLSessionDataTask *, id))success
                  failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    
   
    
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.httpSessionManager.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:URLString relativeToURL:self.httpSessionManager.baseURL] absoluteString] parameters:params error:&serializationError];
    if (serializationError) {
        NSLog(@"network request serialize error:%@", [serializationError localizedDescription]);
    }
    
     NSLog(@"\n==================================\n\nRequest Start: \n\n %@\n\n==================================", request.URL);
    
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [self.httpSessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            if (failure) {
                failure(dataTask, error);
            }
            
        }
        else {
            if (success) {
                success(dataTask, response);
            }
            
        }
    }];
   
    [dataTask resume];
}
@end
