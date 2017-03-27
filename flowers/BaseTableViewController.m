//
//  BaseTableViewController.m
//  flowers
//
//  Created by Crazzy on 26.03.17.
//  Copyright © 2017 Maksim Kis. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)loadView {
    [super loadView];
    
    // Allocate table view
    UITableView *tableView    = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.delegate        = self;
    tableView.dataSource      = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // We are not using UITableViewController because we don't want the view to be the tableview
    [self.view addSubview:tableView];
    
    // Setup constraints as seen https://developer.apple.com/library/ios/featuredarticles/ViewControllerPGforiPhoneOS/ViewLoadingandUnloading/ViewLoadingandUnloading.html#//apple_ref/doc/uid/TP40007457-CH10-SW36

    
    self.tableView = tableView;
}

- (void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end
