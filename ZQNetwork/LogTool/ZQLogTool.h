//
//  ZQLogTool.h
//  ZQNetwork
//
//  Created by Zhou Qian on 16/8/6.
//  Copyright © 2016年 ZhouQian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZQLogTool : NSObject

+ (void)logDebugInfoWithRequest:(NSURLRequest *)request requestParams:(id)requestParams httpMethod:(NSString *)httpMethod;
+ (void)logDebugInfoWithResponse:(NSHTTPURLResponse *)response error:(NSError *)error withRequest:(NSURLRequest *)request;

@end
