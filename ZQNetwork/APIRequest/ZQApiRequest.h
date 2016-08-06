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
- (void)callGetWithParam:(NSDictionary *)param urlString:(NSString *)url success:(networkCallback)success failure:(networkCallback)failure;
- (void)callPostWithParam:(NSDictionary *)param urlString:(NSString *)url success:(networkCallback)success failure:(networkCallback)failure;
- (void)callPutWithParam:(NSDictionary *)param urlString:(NSString *)url success:(networkCallback)success failure:(networkCallback)failure;
- (void)callDeleteWithParam:(NSDictionary *)param urlString:(NSString *)url success:(networkCallback)success failure:(networkCallback)failure;
@end
