//
//  BDDebugFeedModel.m
//  RSKExample
//
//  Created by bob on 2020/6/8.
//  Copyright © 2020 rangers. All rights reserved.
//

#import "BDDebugFeedModel.h"
#import <UIKit/UIKit.h>
#import <DBAppleIDSign/DBAppleIDSign.h>

@implementation BDDebugFeedModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.navigateBlock = nil;
    }
    
    return self;
}

- (NSInteger)height {
    return 44;
}

+ (NSArray<BDDebugFeedModel *> *)loadDebugHomeFeedList {
    NSMutableArray<BDDebugFeedModel *> *feeds =  [NSMutableArray new];
    [feeds addObject:({
        BDDebugFeedModel *model = [BDDebugFeedModel new];
        model.title = @"AppleID register";
        model.navigateBlock = ^(BDDebugFeedModel *feed, UINavigationController *navigate) {
            [[DBAppleIDSign sharedInstance] performRegisterRequestWithCallback:^(NSInteger code, NSString * _Nullable user, NSString * _Nullable email, NSString * _Nullable identityToken, NSString * _Nullable authorizationCode, NSString * _Nullable password) {
                
            }];
        };
       model;
    })];
    
    [feeds addObject:({
        BDDebugFeedModel *model = [BDDebugFeedModel new];
        model.title = @"AppleID login";
        model.navigateBlock = ^(BDDebugFeedModel *feed, UINavigationController *navigate) {
            [[DBAppleIDSign sharedInstance] performLoginRequestWithCallback:^(NSInteger code, NSString * _Nullable user, NSString * _Nullable email, NSString * _Nullable identityToken, NSString * _Nullable authorizationCode, NSString * _Nullable password) {
                
            }];
        };
       model;
    })];
    
    return feeds;
}

@end
