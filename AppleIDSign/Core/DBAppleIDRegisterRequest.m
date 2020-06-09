//
//  DBAppleIDRegisterRequest.m
//  AppleIDSign
//
//  Created by bob on 2020/6/8.
//

#import "DBAppleIDRegisterRequest.h"
#import <AuthenticationServices/AuthenticationServices.h>


API_AVAILABLE(ios(13.0))
@interface DBAppleIDRegisterRequest ()

@property (nonatomic, strong) ASAuthorizationAppleIDProvider *provider;

@end

@implementation DBAppleIDRegisterRequest


- (instancetype)init {
    self = [super init];
    if (self) {
        self.provider = [ASAuthorizationAppleIDProvider new];
    }
    
    return self;
}

- (NSArray<ASAuthorizationRequest *> *)createRequests {
    ASAuthorizationAppleIDRequest *request = self.provider.createRequest;
    NSArray<ASAuthorizationScope> *scopes = @[ASAuthorizationScopeFullName,
                                              ASAuthorizationScopeEmail];
    [request setRequestedScopes:scopes];
    
    return @[request];
}

@end
