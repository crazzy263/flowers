//
//  LeftMenuController.m
//  flowers
//
//  Created by Crazzy on 26.03.17.
//  Copyright © 2017 Maksim Kis. All rights reserved.
//

#import "LeftMenuController.h"
#import "LeftMenuItemModel.h"

@interface LeftMenuController ()
@property (nonatomic, strong) NSArray<NSArray*> *sections;
@end

@implementation LeftMenuController


- (void) setupUI {
    [super setupUI];
    self.view.backgroundColor = [UIColor whiteColor];
    self.sections = @[  @[
                            [[LeftMenuItemModel alloc] initWithText: NSLS(@"Собрать букет") Image:@"" RoutePath: @""],
                            [[LeftMenuItemModel alloc] initWithText: NSLS(@"Примеры букетов") Image:@"" RoutePath: @""], // Перва секция (хидер с логином)
                            [[LeftMenuItemModel alloc] initWithText: NSLS(@"Профиль") Image:@"" RoutePath: @""],
                            [[LeftMenuItemModel alloc] initWithText: NSLS(@"Настройки") Image:@"" RoutePath: @""],
                        ],
                        @[
                            [[LeftMenuItemModel alloc] initWithText: NSLS(@"Как это работает?") Image:@"" RoutePath: @""],
                            [[LeftMenuItemModel alloc] initWithText: NSLS(@"Поддержка") Image:@"" RoutePath: @""],
                        ],
                        @[
                            [[LeftMenuItemModel alloc] initWithText: NSLS(@"Выход") Image:@"" RoutePath: @""],
                        ]
                         
                    ];
}

- (void) setupNavBar {
    [super setupNavBar];
}



-  (UIStatusBarStyle)preferredStatusBarStyle {
    return  UIStatusBarStyleDefault;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


@end
