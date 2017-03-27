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
    
    self.sections = @[  @[
                            [[LeftMenuItemModel alloc] initWithText: @"Собрать букет" Image:@"" RoutePath: @""],
                            [[LeftMenuItemModel alloc] initWithText: @"Примеры букетов" Image:@"" RoutePath: @""], // Перва секция (хидер с логином)
                            [[LeftMenuItemModel alloc] initWithText: @"Профиль" Image:@"" RoutePath: @""],
                            [[LeftMenuItemModel alloc] initWithText: @"Настройки" Image:@"" RoutePath: @""],
                        ],
                        @[
                            [[LeftMenuItemModel alloc] initWithText: @"Как это работает?" Image:@"" RoutePath: @""],
                            [[LeftMenuItemModel alloc] initWithText: @"Поддержка" Image:@"" RoutePath: @""],
                        ],
                        @[
                            [[LeftMenuItemModel alloc] initWithText: @"Выход" Image:@"" RoutePath: @""],
                        ]
                         
                    ];
}

- (void) setupNavBar {
    [super setupNavBar];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


@end
