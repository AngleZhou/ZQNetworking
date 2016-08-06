//
//  CTApiRequest.m
//  ZQNetwork
//
//  Created by ZhouQian on 16/8/2.
//  Copyright © 2016年 ZhouQian. All rights reserved.
//

#import "ZQApiRequest.h"
#import "ZQURLResponse.h"
#import "ZQLogTool.h"
#import "ZQCommonParamGenerator.h"

#import <AFNetworking.h>
#import <AFURLSessionManager.h>
#import <AFHTTPSessionManager.h>
#import "ZQConstant.h"




@interface ZQApiRequest ()
@property (nonatomic, strong) AFHTTPSessionManager *httpSessionManager;
@property (nonatomic, strong) NSMutableDictionary *dispatchTable;
@end
@implementation ZQApiRequest


+ (instancetype)manager {
    static ZQApiRequest *apir;
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
- (NSMutableDictionary *)dispatchTable {
    if (!_dispatchTable) {
        _dispatchTable = [[NSMutableDictionary alloc] init];
    }
    return _dispatchTable;
}

- (AFHTTPSessionManager *)httpSessionManager {
    if (!_httpSessionManager) {
        _httpSessionManager = [AFHTTPSessionManager manager];
    }
    return _httpSessionManager;
}

- (void)callGetWithParam:(NSDictionary *)param urlString:(NSString *)url success:(networkCallback)success failure:(networkCallback)failure {
    [self requestWithMethod:@"GET" URLString:url param:param success:success failure:failure];
}
- (void)callPostWithParam:(NSDictionary *)param urlString:(NSString *)url success:(networkCallback)success failure:(networkCallback)failure {
    [self requestWithMethod:@"POST" URLString:url param:param success:success failure:failure];
}
- (void)callPutWithParam:(NSDictionary *)param urlString:(NSString *)url success:(networkCallback)success failure:(networkCallback)failure {
    [self requestWithMethod:@"PUT" URLString:url param:param success:success failure:failure];
}
- (void)callDeleteWithParam:(NSDictionary *)param urlString:(NSString *)url success:(networkCallback)success failure:(networkCallback)failure {
    [self requestWithMethod:@"DELETE" URLString:url param:param success:success failure:failure];
}

- (void)cancelRequestWithRequestID:(NSNumber *)requestID
{
    NSURLSessionDataTask *requestOperation = self.dispatchTable[requestID];
    [requestOperation cancel];
    [self.dispatchTable removeObjectForKey:requestID];
}

//可以在这边统一添加和处理网络连接
- (void)requestWithMethod:(NSString *)method
                URLString:(NSString *)URLString
                    param:(NSDictionary *)params
                  success:(networkCallback)success
                  failure:(networkCallback)failure {
    
    ______WS();
    
    NSDictionary *commonParam = [ZQCommonParamGenerator commonParamsDictionary];
    NSMutableDictionary *finalParam = [params mutableCopy];
    [finalParam addEntriesFromDictionary:commonParam];
    
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.httpSessionManager.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:URLString relativeToURL:self.httpSessionManager.baseURL] absoluteString] parameters:finalParam error:&serializationError];
    if (serializationError) {
        NSLog(@"network request serialize error:%@", [serializationError localizedDescription]);
    }
    
    //检查网络连接状态
    if ([[AFNetworkReachabilityManager sharedManager] isReachable]) {
        
        NSLog(@"\n==================================\n\nRequest Start: \n\n %@\n\n==================================", request.URL);
        
        __block NSURLSessionDataTask *dataTask = nil;
        dataTask = [self.httpSessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            [wSelf.dispatchTable removeObjectForKey:@([dataTask taskIdentifier])];
            
            NSData *responseData = responseObject;
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            ZQURLResponse *zqResponse = [[ZQURLResponse alloc] initWithResponse:responseData error:error];
            [ZQLogTool logDebugInfoWithResponse:httpResponse error:error withRequest:request];
            if (error) {
                failure ? failure(zqResponse) : nil;
            }
            else {
                success ? success(zqResponse) : nil;
            }
        }];
        
        
        self.dispatchTable[@([dataTask taskIdentifier])] = dataTask;
        
        [dataTask resume];
    }
    else {
        __notify(noteNetworkUnavailable);
    }
    
    
}
@end
