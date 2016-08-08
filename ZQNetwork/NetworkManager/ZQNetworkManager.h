//
//  ZQNetworkManager.h
//  ZQNetwork
//
//  Created by Zhou Qian on 16/8/7.
//  Copyright © 2016年 ZhouQian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZQURLResponse.h"

@class ZQNetworkManager;


typedef NS_ENUM (NSUInteger, CTAPIManagerRequestType){
    CTAPIManagerRequestTypeGet,
    CTAPIManagerRequestTypePost,
    CTAPIManagerRequestTypePut,
    CTAPIManagerRequestTypeDelete
};

@protocol ZQNetworkManagerParamSource <NSObject>

@optional
- (NSDictionary *)params;
- (CTAPIManagerRequestType)requestType;
- (NSString *)urlString;
@end



@protocol ZQNetworkManagerCallbackDelegate <NSObject>

@required
- (void)ZQNetworkManagerDidSuccess:(ZQURLResponse *)response;
- (void)ZQNetworkManagerDidfail:(ZQURLResponse *)response;

@end



@interface ZQNetworkManager : NSObject

@property (nonatomic, weak) id<ZQNetworkManagerCallbackDelegate> delegate;
@property (nonatomic, weak) id<ZQNetworkManagerParamSource> paramSource;

+ (instancetype)manager;
@end
