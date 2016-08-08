//
//  CTApiRequest.h
//  ZQNetwork
//
//  Created by ZhouQian on 16/8/2.
//  Copyright © 2016年 ZhouQian. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZQURLResponse;

typedef void (^networkCallback)(ZQURLResponse *response);

@interface ZQApiRequest : NSObject

+ (instancetype)sharedInstance;

- (void)callGETWithParam:(NSDictionary *)param urlString:(NSString *)url success:(networkCallback)success failure:(networkCallback)failure;
- (void)callPOSTWithParam:(NSDictionary *)param urlString:(NSString *)url success:(networkCallback)success failure:(networkCallback)failure;
- (void)callPUTWithParam:(NSDictionary *)param urlString:(NSString *)url success:(networkCallback)success failure:(networkCallback)failure;
- (void)callDELETEWithParam:(NSDictionary *)param urlString:(NSString *)url success:(networkCallback)success failure:(networkCallback)failure;

- (void)cancelRequestWithRequestID:(NSNumber *)requestID;
@end
