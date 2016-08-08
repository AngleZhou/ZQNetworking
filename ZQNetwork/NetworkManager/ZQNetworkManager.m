//
//  ZQNetworkManager.m
//  ZQNetwork
//
//  Created by Zhou Qian on 16/8/7.
//  Copyright © 2016年 ZhouQian. All rights reserved.
//

#import "ZQNetworkManager.h"
#import "ZQApiRequest.h"
#import "ZQConstant.h"

#define ZQCallAPI(requestMethod, params, urlString)  \
{   \
    ______WS(); \
    ______SS(); \
    [[ZQApiRequest sharedInstance] call##requestMethod##WithParam:params urlString:urlString success:^(ZQURLResponse *response) { \
        [sSelf successedOnCallingAPI:response]; \
    } failure:^(ZQURLResponse *response) {  \
        [sSelf failedOnCallingAPI:response]; \
    }]; \
}


@implementation ZQNetworkManager


+ (instancetype)manager {
    static ZQNetworkManager *mana;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mana = [[self alloc] initPrivate];
    });
    return mana;
}

- (instancetype)initPrivate {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)loadDataWithParams:(NSDictionary *)param {
    NSString *urlString = [self.paramSource urlString];
    switch ([self.paramSource requestType]) {
        case CTAPIManagerRequestTypeGet:
            ZQCallAPI(GET, param, urlString);
            break;
        case CTAPIManagerRequestTypePost:
            ZQCallAPI(POST, param, urlString);
            break;
        case CTAPIManagerRequestTypePut:
            ZQCallAPI(PUT, param, urlString);
            break;
        case CTAPIManagerRequestTypeDelete:
            ZQCallAPI(DELETE, param, urlString);
            break;
        default:
            break;
    }
}

- (void)successedOnCallingAPI:(ZQURLResponse *)response {
    [self.delegate ZQNetworkManagerDidSuccess:response];
}
- (void)failedOnCallingAPI:(ZQURLResponse *)response {
    [self.delegate ZQNetworkManagerDidfail:response];
}
@end
