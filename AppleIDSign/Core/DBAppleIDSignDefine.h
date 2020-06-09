//
//  DBAppleIDSignDefine.h
//  AppleIDSign
//
//  Created by bob on 2020/6/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^DBAppleIDSignRequestCallback)(NSInteger code,
                                             NSString * _Nullable user,
                                             NSString * _Nullable email,
                                             NSString * _Nullable identityToken,
                                             NSString * _Nullable authorizationCode,
                                             NSString * _Nullable password);

typedef void (^DBAppleIDSignCheckCallback)(NSInteger credentialState, NSError * _Nullable error);

NS_ASSUME_NONNULL_END
