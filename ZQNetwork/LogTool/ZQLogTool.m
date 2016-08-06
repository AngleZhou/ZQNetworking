//
//  ZQLogTool.m
//  ZQNetwork
//
//  Created by Zhou Qian on 16/8/6.
//  Copyright © 2016年 ZhouQian. All rights reserved.
//

#import "ZQLogTool.h"
#import "NSMutableString+appendURLRequest.h"

@implementation ZQLogTool

+ (void)logDebugInfoWithRequest:(NSURLRequest *)request requestParams:(id)requestParams httpMethod:(NSString *)httpMethod {
#ifdef DEBUG
    NSMutableString *logString = [NSMutableString stringWithString:@"\n\n**************************************************************\n*                       Request Start                        *\n**************************************************************\n\n"];
    [logString appendURLRequest:request];
    [logString appendFormat:@"Method:\t\t\t%@\n", httpMethod];
    [logString appendFormat:@"Params:\n%@", requestParams];
    
    NSLog(@"%@", logString);
#endif
}

+ (void)logDebugInfoWithResponse:(NSHTTPURLResponse *)response error:(NSError *)error withRequest:(NSURLRequest *)request {
#ifdef DEBUG
    BOOL shouldLogError = error ? YES : NO;
    
    NSMutableString *logString = [NSMutableString stringWithString:@"\n\n==============================================================\n=                        API Response                        =\n==============================================================\n\n"];
    
    [logString appendFormat:@"Status:\t%ld\t(%@)\n\n", (long)response.statusCode, [NSHTTPURLResponse localizedStringForStatusCode:response.statusCode]];
    if (shouldLogError) {
        [logString appendFormat:@"Error Domain:\t\t\t\t\t\t\t%@\n", error.domain];
        [logString appendFormat:@"Error Domain Code:\t\t\t\t\t\t%ld\n", (long)error.code];
        [logString appendFormat:@"Error Localized Description:\t\t\t%@\n", error.localizedDescription];
        [logString appendFormat:@"Error Localized Failure Reason:\t\t\t%@\n", error.localizedFailureReason];
        [logString appendFormat:@"Error Localized Recovery Suggestion:\t%@\n\n", error.localizedRecoverySuggestion];
    }
    
    [logString appendString:@"\n---------------  Related Request Content  --------------\n"];
    
    [logString appendURLRequest:request];
    
    [logString appendFormat:@"\n\n==============================================================\n=                        Response End                        =\n==============================================================\n\n\n\n"];
    
    NSLog(@"%@", logString);
#endif
}
@end
