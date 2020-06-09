//
//  BDDebugFeedModel.h
//  RSKExample
//
//  Created by bob on 2020/6/8.
//  Copyright © 2020 rangers. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@class BDDebugFeedModel, UINavigationController;

typedef void (^BDDebugFeedNavigateBlock)(BDDebugFeedModel *feed, UINavigationController *navigate);

@interface BDDebugFeedModel : NSObject

@property (nonatomic, assign) NSUInteger index;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy, nullable) BDDebugFeedNavigateBlock navigateBlock;
- (NSInteger)height;

+ (NSArray<BDDebugFeedModel *> *)loadDebugHomeFeedList;

@end

NS_ASSUME_NONNULL_END
