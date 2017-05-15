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

#define LEFT_MENU_ITEMS 7
#define LEFT_MENU_SECTION_HEIGHT 100// ([UIScreen mainScreen].bounds.size.height  - (LEFT_MENU_ITEM_HEIGHT * 6)) / 2

#define LEFT_MENU_ITEM_HEIGHT ([UIScreen mainScreen].bounds.size.height - (LEFT_MENU_SECTION_HEIGHT * 2)) / (LEFT_MENU_ITEMS )



@interface LeftMenuController () < UIScrollViewDelegate>

@property (nonatomic, strong) NSArray<NSArray*> *sections;
@property (nonatomic, strong) LeftMenuProfileView* profile;
@end

@implementation LeftMenuController

- (void) setupUI {
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(authorized) name:@"authFinished" object:nil];
    [super setupUI];
    
    
    LeftMenuProfileView* view = [[LeftMenuProfileView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, LEFT_MENU_SECTION_HEIGHT)];
    [self.view addSubview:view];
    view.parentControllerDelegate = self;
    self.profile = view;
    
    self.tableView.backgroundColor = [UIColor whiteColor];

    self.sections = @[  @[

                             
                             [[LeftMenuItemModel alloc] initWithText: NSLS(@"Собрать букет")
                                                               Image:@"getflower"
                                                           RoutePath: @"getflower"
                                                               Style:LeftMenuItemStyleNone
                                                          TapHandler:^{
                                                              RouterNavigate(URL_NAVIGATE_COLLECTFLOWERS);
                                                          }],
                            [[LeftMenuItemModel alloc] initWithText: NSLS(@"Примеры букетов")
                                                              Image:@"exampleflower"
                                                          RoutePath: @"exampleflower"
                                                              Style:LeftMenuItemStyleNone
                                                         TapHandler:^{
                                                             
                                                         }],
                         
                            
                            [[LeftMenuItemModel alloc] initWithText: NSLS(@"Профиль")
                                                              Image:@"profile"
                                                          RoutePath: @"profile"
                                                              Style:LeftMenuItemStyleNone
                                                         TapHandler:^{
                                                             
                                                         }],
                             
                             [[LeftMenuItemModel alloc] initWithText: NSLS(@"Пригласить друзей")
                                                               Image:@""
                                                           RoutePath: @"profile"
                                                               Style:LeftMenuItemStyleNone
                                                          TapHandler:^{
                                                              
                                                          }],
                             
                            
                            [[LeftMenuItemModel alloc] initWithText: NSLS(@"Настройки")
                                                              Image:@"settings"
                                                          RoutePath: @"settings"
                                                              Style:LeftMenuItemStyleBottomSeparator
                                                         TapHandler:^{
                                                             
                                                         }],
                            
                            [[LeftMenuItemModel alloc] initWithText: NSLS(@"Как это работает?")
                                                              Image:@"info"
                                                          RoutePath: @"info"
                                                              Style:LeftMenuItemStyleNone
                                                         TapHandler:^{
                                                             RouterNavigate(URL_NAVIGATE_WELCOME);
                                                         }],
                            
                            [[LeftMenuItemModel alloc] initWithText: NSLS(@"Поддержка")
                                                              Image:@"support"
                                                          RoutePath: @"support"
                                                              Style:LeftMenuItemStyleNone
                                                         TapHandler:^{
                                                             
                                                         }],
                            
                            [[LeftMenuItemModel alloc] initWithText: NSLS(@"Выход")
                                                              Image:@"logout"
                                                          RoutePath: @"logout"
                                                              Style:LeftMenuItemStyleExit
                                                         TapHandler:^{
                                                             [[AppConfigurator sharedInstance] logout];
                                                             
                                                         }],
                            ]
                        ];
    
    [self.tableView registerClass:[LeftMenuItemCell class] forCellReuseIdentifier:[LeftMenuItemCell cellIdentifier]];
}

-(void) authorized {
    [self.tableView reloadData];
}

- (void) setupNavBar {
    [super setupNavBar];
}

- (void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    _profile.frame =  CGRectMake(0, 0, self.view.bounds.size.width, LEFT_MENU_SECTION_HEIGHT);
    self.tableView.frame = CGRectMake(0, LEFT_MENU_SECTION_HEIGHT, self.view.bounds.size.width, self.view.bounds.size.height - LEFT_MENU_SECTION_HEIGHT);
     
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([AppConfigurator sharedInstance].loggedIn) {
          return [[self.sections objectAtIndex:section] count];
    }
    return [[self.sections objectAtIndex:section] count] - 1 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:[LeftMenuItemCell cellIdentifier] forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [((LeftMenuItemCell*)cell) setModel:self.sections[indexPath.section][indexPath.row]];
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    LeftMenuProfileView* view = [[LeftMenuProfileView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, LEFT_MENU_SECTION_HEIGHT)];
//    view.parentControllerDelegate = self;
//    return view;
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return LEFT_MENU_SECTION_HEIGHT;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == self.sections[indexPath.section].count - 1) {
        return LEFT_MENU_SECTION_HEIGHT;
    }
    
    return LEFT_MENU_ITEM_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LeftMenuItemCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if(cell.model.itemTapHandler != nil) {
        cell.model.itemTapHandler();
    }
}
@end
