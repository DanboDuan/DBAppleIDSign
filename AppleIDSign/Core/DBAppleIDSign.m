//
//  DBAppleIDSign.m
//  AppleIDSign
//
//  Created by bob on 2020/6/7.
//

#import "DBAppleIDSign.h"
#import <AuthenticationServices/AuthenticationServices.h>

#import "DBAppleIDRegisterRequest.h"
#import "DBAppleIDLoginRequest.h"
#import "DBAppleIDRequest.h"

API_AVAILABLE(ios(13.0))
@interface DBAppleIDSign ()<ASAuthorizationControllerPresentationContextProviding>

@property (nonatomic, strong) DBAppleIDRequest *request;
@property (nonatomic, strong) NSMutableDictionary<NSString *, dispatch_block_t> *revokeCallbacks;

@end


@implementation DBAppleIDSign

+ (instancetype)sharedInstance {
    static DBAppleIDSign *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        sharedInstance = [self new];
    });

    return sharedInstance;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.revokeCallbacks = [NSMutableDictionary new];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onAppleIDProviderCredentialRevoked)
                                                     name:ASAuthorizationAppleIDProviderCredentialRevokedNotification
                                                   object:nil];
        
    }
    
    return self;
}

- (void)onAppleIDProviderCredentialRevoked {
    NSArray<dispatch_block_t> *blocks = [self.revokeCallbacks.allValues copy];
    [blocks enumerateObjectsUsingBlock:^(dispatch_block_t obj, NSUInteger idx, BOOL *stop) {
        obj();
    }];
}

- (void)registerRevokedBlock:(dispatch_block_t)block forKey:(NSString *)key {
    if (key == nil) {
        return;
    }
    
    [self.revokeCallbacks setValue:block forKey:key];
}

- (void)unregisterRevokedBlock:(dispatch_block_t)block forKey:(NSString *)key {
    if (key == nil) {
        return;
    }
    
    [self.revokeCallbacks removeObjectForKey:key];
}

- (void)checkAppleIDSignWithUser:(NSString *)user callback:(DBAppleIDSignCheckCallback)callback {
    ASAuthorizationAppleIDProvider *provider = [ASAuthorizationAppleIDProvider new];
    [provider getCredentialStateForUserID:user completion:^(ASAuthorizationAppleIDProviderCredentialState credentialState, NSError * error) {
        if (callback) callback(credentialState, error);
        
        switch (credentialState) {
            case ASAuthorizationAppleIDProviderCredentialRevoked:
                //用户重新登录了其他的apple id
                break;
            case ASAuthorizationAppleIDProviderCredentialAuthorized:
                //该userid apple id 登录状态良好
                break;
            case ASAuthorizationAppleIDProviderCredentialNotFound:
                //该userid apple id 登录找不到
                //用户在设置-appleid header-密码与安全性-使用您 Apple ID的App 中将网易新闻的禁止掉了
                break;
            case ASAuthorizationAppleIDProviderCredentialTransferred:
                break;
            default:
                break;
        }
    }];
}

/// ASAuthorizationControllerPresentationContextProviding
- (ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller {
    return [UIApplication sharedApplication].keyWindow;
}

- (void)performRegisterRequestWithCallback:(DBAppleIDSignRequestCallback)callback {
    self.request = [DBAppleIDRegisterRequest new];
    self.request.callback = callback;
    [self performRequest];
}

- (void)performLoginRequestWithCallback:(DBAppleIDSignRequestCallback)callback {
    self.request = [DBAppleIDLoginRequest new];
    self.request.callback = callback;
    [self performRequest];
}

- (void)performRequest {
    NSArray<ASAuthorizationRequest *> *requests = [self.request createRequests];
    ASAuthorizationController *controller = [[ASAuthorizationController alloc] initWithAuthorizationRequests:requests];
    controller.delegate = self.request;
    controller.presentationContextProvider = self;
    [controller performRequests];
}

@end
