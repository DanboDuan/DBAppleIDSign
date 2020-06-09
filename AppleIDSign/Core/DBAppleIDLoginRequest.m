//
//  DBAppleIDLoginRequest.m
//  AppleIDSign
//
//  Created by bob on 2020/6/8.
//

#import "DBAppleIDLoginRequest.h"
#import <AuthenticationServices/AuthenticationServices.h>

API_AVAILABLE(ios(13.0))
@interface DBAppleIDLoginRequest ()

@property (nonatomic, strong) ASAuthorizationAppleIDProvider *appleIDProvider;
@property (nonatomic, strong) ASAuthorizationPasswordProvider *passwordProvider;

@end

@implementation DBAppleIDLoginRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        self.appleIDProvider = [ASAuthorizationAppleIDProvider new];
        self.passwordProvider = [ASAuthorizationPasswordProvider new];
    }
    
    return self;
}

- (NSArray<ASAuthorizationRequest *> *)createRequests {
    ASAuthorizationAppleIDRequest *request = self.appleIDProvider.createRequest;
    NSArray<ASAuthorizationScope> *scopes = @[ASAuthorizationScopeFullName,
                                              ASAuthorizationScopeEmail];
    [request setRequestedScopes:scopes];
    
    ASAuthorizationPasswordRequest *passwordRequest = self.passwordProvider.createRequest;
    
    return @[request, passwordRequest];
}

@end
