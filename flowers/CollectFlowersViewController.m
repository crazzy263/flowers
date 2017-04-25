//
//  CollectFlowersViewController.m
//  flowers
//
//  Created by iOS Developer on 27.03.17.
//  Copyright © 2017 Maksim Kis. All rights reserved.
//

#import "CollectFlowersViewController.h"

@interface CollectFlowersViewController ()

@end

@implementation CollectFlowersViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"Collect Flowers";
    }
    return self;
}


- (void)setupUI {
    self.view.backgroundColor = [UIColor grayColor];
    [self addSideMenuButton];
}

- (void) setupNavBar {
    
}

@end
