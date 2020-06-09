//
//  DBAppleIDRequest.m
//  AppleIDSign
//
//  Created by bob on 2020/6/8.
//

#import "DBAppleIDRequest.h"

API_AVAILABLE(ios(13.0))
@interface DBAppleIDRequest ()


@end

@implementation DBAppleIDRequest

- (NSArray<ASAuthorizationRequest *> *)createRequests {
    return @[];
}

/// ASAuthorizationControllerDelegate
- (void)authorizationController:(ASAuthorizationController *)controller
   didCompleteWithAuthorization:(ASAuthorization *)authorization {
    
    if ([authorization.provider isKindOfClass:[ASAuthorizationAppleIDProvider class]])  {
        ASAuthorizationAppleIDCredential *credential = authorization.credential;
        if ([credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]) {
            NSString *identityToken = [[NSString alloc] initWithData:credential.identityToken encoding:NSUTF8StringEncoding];
            
            NSString *authorizationCode = [[NSString alloc] initWithData:credential.authorizationCode encoding:NSUTF8StringEncoding];
            NSString *user = credential.user;
            NSString *email = credential.email;
//            ASUserDetectionStatus realUserStatus = credential.realUserStatus;
            DBAppleIDSignRequestCallback callback = self.callback;
            if (callback != nil) {
                callback(0, user, email, identityToken, authorizationCode, nil);
            }
        }
    }
    
    if ([authorization.provider isKindOfClass:[ASAuthorizationPasswordProvider class]]) {
        ASPasswordCredential *passwordCredential = authorization.credential;
        if ([passwordCredential isKindOfClass:[ASPasswordCredential class]]) {
            NSString *user = passwordCredential.user;
            NSString *password = passwordCredential.password;
            DBAppleIDSignRequestCallback callback = self.callback;
            if (callback != nil) {
                callback(0, user, nil, nil, nil, password);
            }
        }
    }
}

- (void)authorizationController:(ASAuthorizationController *)controller
           didCompleteWithError:(NSError *)error  {
    ASAuthorizationError code = error.code;
    switch (code) {
        case ASAuthorizationErrorCanceled:
            break;
        case ASAuthorizationErrorInvalidResponse:
            break;
        case ASAuthorizationErrorNotHandled:
            break;
        case ASAuthorizationErrorFailed:
            break;
        default:
            break;
    }
    DBAppleIDSignRequestCallback callback = self.callback;
    if (callback != nil) {
        callback(code, nil, nil, nil, nil, nil);
    }
}

@end
