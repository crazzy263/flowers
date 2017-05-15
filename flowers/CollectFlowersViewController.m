//
//  CollectFlowersViewController.m
//  flowers
//
//  Created by iOS Developer on 27.03.17.
//  Copyright © 2017 Maksim Kis. All rights reserved.
//

#import "CollectFlowersViewController.h"
#import "UINavigationController+TransparentNavigationController.h"

@interface CollectFlowersViewController ()

@end

@implementation CollectFlowersViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        UIImage *image = [UIImage imageNamed:@"flowers-logo"];
        self.navigationItem.titleView = [[UIImageView alloc] initWithImage:image];
        self.view.backgroundColor = [UIColor colorWithRed:248.0f/255.0f green:248.0f/255.0f blue:248.0f/255.0f alpha:1.0f];;
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
