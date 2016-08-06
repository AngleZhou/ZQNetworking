//
//  ZQURLResponse.m
//  ZQNetwork
//
//  Created by Zhou Qian on 16/8/6.
//  Copyright © 2016年 ZhouQian. All rights reserved.
//

#import "ZQURLResponse.h"

@implementation ZQURLResponse



- (instancetype)initWithResponse:(NSData *)responseData error:(NSError *)error {
    if (self = [super init]) {
        if (responseData) {
            id content = [NSJSONSerialization JSONObjectWithData:responseData options:(NSJSONReadingMutableContainers) error:nil];
            _responseDic = (NSDictionary*)content;
        }
        _status = [self statusWithError:error];
        _responseData = responseData;
        _error = error;
    }
    return self;
}

- (CTURLResponseStatus)statusWithError:(NSError *)error {
    if (error) {
        if (error.code == NSURLErrorTimedOut) {
            return CTURLResponseStatusErrorTimeout;
        }
        else {
            return CTURLResponseStatusErrorError;
        }
        //TODO: CTURLResponseStatusErrorNoNetwork
    }
    else {
        return CTURLResponseStatusSuccess;
    }
}
@end
