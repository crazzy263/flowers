//
//  LeftMenuController.m
//  flowers
//
//  Created by Crazzy on 26.03.17.
//  Copyright © 2017 Maksim Kis. All rights reserved.
//

#import "LeftMenuController.h"
#import "LeftMenuItemModel.h"
#import "LeftMenuItemCell.h"
#import "LeftMenuProfileView.h"

#define LEFT_MENU_ITEM_HEIGHT 75

#define LEFT_MENU_SECTION_HEIGHT ([UIScreen mainScreen].bounds.size.height  - (LEFT_MENU_ITEM_HEIGHT * 6)) / 2

@interface LeftMenuController () < UIScrollViewDelegate>

@property (nonatomic, strong) NSArray<NSArray*> *sections;
@property (nonatomic, strong) UIView* statusBarView;
@end

@implementation LeftMenuController

- (void) setupUI {
    [super setupUI];
//    _statusBarView = [UIView new];
//    _statusBarView.backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:218.0f/255.0f blue:218.0f/255.0f alpha:1.0f];
    self.tableView.backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:218.0f/255.0f blue:218.0f/255.0f alpha:1.0f];
    self.sections = @[  @[
                            [[LeftMenuItemModel alloc] initWithText: NSLS(@"Собрать букет")
                                                              Image:@"getflower"
                                                          RoutePath: @"getflower"
                                                              Style:LeftMenuItemStyleNone],
                            
                            [[LeftMenuItemModel alloc] initWithText: NSLS(@"Примеры букетов")
                                                              Image:@"exampleflower"
                                                          RoutePath: @"exampleflower"
                                                              Style:LeftMenuItemStyleNone],
                            
                            [[LeftMenuItemModel alloc] initWithText: NSLS(@"Профиль")
                                                              Image:@"profile"
                                                          RoutePath: @"profile"
                                                              Style:LeftMenuItemStyleNone],
                            
                            [[LeftMenuItemModel alloc] initWithText: NSLS(@"Настройки")
                                                              Image:@"settings"
                                                          RoutePath: @"settings"
                                                              Style:LeftMenuItemStyleBottomSeparator],
                            
                            [[LeftMenuItemModel alloc] initWithText: NSLS(@"Как это работает?")
                                                              Image:@"info"
                                                          RoutePath: @"info"
                                                              Style:LeftMenuItemStyleNone],
                            
                            [[LeftMenuItemModel alloc] initWithText: NSLS(@"Поддержка")
                                                              Image:@"support"
                                                          RoutePath: @"support"
                                                              Style:LeftMenuItemStyleNone],
                            
                            [[LeftMenuItemModel alloc] initWithText: NSLS(@"Выход")
                                                              Image:@"logout"
                                                          RoutePath: @"logout"
                                                              Style:LeftMenuItemStyleExit],
                            ]
                        ];
    
    [self.tableView registerClass:[LeftMenuItemCell class] forCellReuseIdentifier:[LeftMenuItemCell cellIdentifier]];
}

- (void) setupNavBar {
    [super setupNavBar];
}

- (void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
//    [_statusBarView setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height / 2)]; // TODO : trick
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.sections objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:[LeftMenuItemCell cellIdentifier] forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [((LeftMenuItemCell*)cell) setModel:self.sections[indexPath.section][indexPath.row]];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[LeftMenuProfileView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, LEFT_MENU_SECTION_HEIGHT)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return LEFT_MENU_SECTION_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == self.sections[indexPath.section].count - 1) {
        return LEFT_MENU_SECTION_HEIGHT;
    }
    
    return LEFT_MENU_ITEM_HEIGHT;
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat sectionHeaderHeight = LEFT_MENU_SECTION_HEIGHT;
//    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//    }
//}

@end
