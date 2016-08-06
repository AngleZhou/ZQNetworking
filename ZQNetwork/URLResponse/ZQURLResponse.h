//
//  ZQURLResponse.h
//  ZQNetwork
//
//  Created by Zhou Qian on 16/8/6.
//  Copyright © 2016年 ZhouQian. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CTURLResponseStatus)
{
    CTURLResponseStatusSuccess, //作为底层，请求是否成功只考虑是否成功收到服务器反馈。至于签名是否正确，返回的数据是否完整，由上层的CTAPIBaseManager来决定。
    CTURLResponseStatusErrorTimeout,
    CTURLResponseStatusErrorNoNetwork, // 无网络错误。
    CTURLResponseStatusErrorError
};


@interface ZQURLResponse : NSObject
@property (nonatomic, assign) CTURLResponseStatus status;
@property (nonatomic, strong) NSData *responseData;
@property (nonatomic, strong) NSDictionary *responseDic;
@property (nonatomic, strong) NSError *error;

- (instancetype)initWithResponse:(NSData *)responseData error:(NSError *)error;
@end
