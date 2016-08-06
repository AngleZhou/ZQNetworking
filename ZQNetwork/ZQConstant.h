//
//  ZQConstant.h
//  ZQNetwork
//
//  Created by Zhou Qian on 16/8/6.
//  Copyright © 2016年 ZhouQian. All rights reserved.
//

#ifndef ZQConstant_h
#define ZQConstant_h


#define noteNetworkUnavailable @"noteNetworkUnavailable"



//weak strong
#define  __WS(weakSelf)     __weak __typeof(&*self) weakSelf = self
#define  ______WS()         __weak __typeof(&*self) wSelf = self
#define  ______SS()         __strong __typeof(&*wSelf) sSelf = wSelf
#define  ______WX(x,y)      __weak __typeof(&*x) y = x



#define IsStringValid(_str) (_str && [_str isKindOfClass:[NSString class]] && ([_str length] > 0))
#define IsArrayValid(_array) (_array && [_array isKindOfClass:[NSArray class]] && ([_array count] > 0))
#define IsDictionaryValid(__dic) (__dic && [__dic isKindOfClass:[NSDictionary class]] && ([__dic count] > 0))
#define IsDelegateValid(__aDelegate, __aSelector)   (__aDelegate && [__aDelegate respondsToSelector:__aSelector])



#define TOAST_PROCESS_SHOW_VIEW     [KVNProgress showWithStatus:nil onView:[[CTTools rootViewController] view]]
#define TOAST_PROCESS_SHOW_WINDOW   [KVNProgress show]
#define TOAST_PROCESS_DISMISS       [KVNProgress dismiss]

#define TOAST_SUCCESS(x)        [KVNProgress showSuccessWithStatus:x]
#define TOAST_SUCCESS_Blok(x,y) [KVNProgress showSuccessWithStatus:x completion:y]
#define TOAST_FAILURE(x)        [KVNProgress showErrorWithStatus:x]
#define TOAST_ERROR(this,x)     [KVNProgress showErrorWithStatus:[NSString stringWithFormat:@"%@",x.userInfo[NSLocalizedDescriptionKey]]]

#define __notify(x)             [[NSNotificationCenter defaultCenter]postNotificationName:x object:nil]
#define __notifyObject(x,y)     [[NSNotificationCenter defaultCenter]postNotificationName:x object:y]
#define __observeNotify(x,y)    [[NSNotificationCenter defaultCenter] addObserver:self selector:x name:y object:nil]
#define __removeNotifyObserver  [[NSNotificationCenter defaultCenter] removeObserver:self]



#endif /* ZQConstant_h */
