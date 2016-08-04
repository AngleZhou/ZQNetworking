//
//  CTApiRequest.h
//  ZQNetwork
//
//  Created by ZhouQian on 16/8/2.
//  Copyright © 2016年 ZhouQian. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^successBlock)(NSURLSessionDataTask *dataTask, id);
typedef void (^failBlock)(NSURLSessionDataTask *dataTask, NSError *error);

@interface CTApiRequest : NSObject
-
@end
