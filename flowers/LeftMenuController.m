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
    UIView * statusBarView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, UI_STATUSBAR_HEIGHT)];
    statusBarView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:statusBarView];
    
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
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void) setupNavBar {
    [super setupNavBar];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.sections objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.textLabel.text = [self.sections[indexPath.section][indexPath.row] rowLabelText];
}

@end
