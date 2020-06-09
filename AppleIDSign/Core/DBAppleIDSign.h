//
//  DBAppleIDSign.h
//  AppleIDSign
//
//  Created by bob on 2020/6/7.
//

#import <Foundation/Foundation.h>
#import "DBAppleIDSignDefine.h"

NS_ASSUME_NONNULL_BEGIN

API_AVAILABLE(ios(13.0))
@interface DBAppleIDSign : NSObject

+ (instancetype)sharedInstance;

- (void)checkAppleIDSignWithUser:(NSString *)user callback:(nullable DBAppleIDSignCheckCallback)callback;
- (void)registerRevokedBlock:(dispatch_block_t)block forKey:(NSString *)key;
- (void)unregisterRevokedBlock:(dispatch_block_t)block forKey:(NSString *)key;

- (void)performRegisterRequestWithCallback:(nullable DBAppleIDSignRequestCallback)callback;
- (void)performLoginRequestWithCallback:(nullable DBAppleIDSignRequestCallback)callback;

@end

NS_ASSUME_NONNULL_END
