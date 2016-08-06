//
//  NSMutableString+appendURLRequest.m
//  ZQNetwork
//
//  Created by Zhou Qian on 16/8/6.
//  Copyright © 2016年 ZhouQian. All rights reserved.
//

#import "NSMutableString+appendURLRequest.h"

@implementation NSMutableString (appendURLRequest)

- (void)appendURLRequest:(NSURLRequest *)request {
    [self appendFormat:@"\n\nHTTP URL:\n\t%@", request.URL];
    [self appendFormat:@"\n\nHTTP Header:\n%@", request.allHTTPHeaderFields ? request.allHTTPHeaderFields : @"\t\t\t\t\tN/A"];
    [self appendFormat:@"\n\nHTTP Body:\n\t%@", [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding]];
}

@end
