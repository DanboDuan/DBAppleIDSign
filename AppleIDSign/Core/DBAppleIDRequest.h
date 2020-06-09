//
//  DBAppleIDRequest.h
//  AppleIDSign
//
//  Created by bob on 2020/6/8.
//

#import "DBAppleIDSignDefine.h"
#import <AuthenticationServices/AuthenticationServices.h>

NS_ASSUME_NONNULL_BEGIN


API_AVAILABLE(ios(13.0))
@interface DBAppleIDRequest : NSObject<ASAuthorizationControllerDelegate>

@property (nonatomic, strong, nullable) DBAppleIDSignRequestCallback callback;

- (NSArray<ASAuthorizationRequest *> *)createRequests;

@end

NS_ASSUME_NONNULL_END
