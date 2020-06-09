//
//  AppDelegate.m
//  RSKExample
//
//  Created by bob on 2020/5/7.
//  Copyright © 2020 rangers. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
    self.window.rootViewController = navi;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
