//
//  ViewController.m
//  RSKExample
//
//  Created by bob on 2020/5/7.
//  Copyright © 2020 rangers. All rights reserved.
//

#import "ViewController.h"
#import "BDDebugFeedModel.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<BDDebugFeedModel *> *feeds;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.feeds = [BDDebugFeedModel loadDebugHomeFeedList];
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                          style:(UITableViewStylePlain)];
    
    
    [tableView registerClass:[UITableViewCell class]
      forCellReuseIdentifier:@"forCellReuseIdentifier"];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView = tableView;
    [self.view addSubview:tableView];
}

- (BDDebugFeedModel *)modelForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.feeds objectAtIndex:indexPath.row];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.feeds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BDDebugFeedModel *model = [self modelForRowAtIndexPath:indexPath];
    model.index = indexPath.row + 1;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"forCellReuseIdentifier"];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd: %@",model.index, model.title];
    return cell;
}

#pragma mark - Table view delegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BDDebugFeedModel *model = [self modelForRowAtIndexPath:indexPath];
    
    return model.height;
}


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BDDebugFeedModel *model = [self modelForRowAtIndexPath:indexPath];
    
    return model.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BDDebugFeedModel *model = [self modelForRowAtIndexPath:indexPath];
    BDDebugFeedNavigateBlock navigateBlock = model.navigateBlock;
    if (navigateBlock) {
        navigateBlock(model, self.navigationController);
    }
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
}



@end
