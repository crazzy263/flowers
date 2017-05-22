//
//  CollectFlowersViewController.m
//  flowers
//
//  Created by iOS Developer on 27.03.17.
//  Copyright © 2017 Maksim Kis. All rights reserved.
//

#import "CollectFlowersViewController.h"
#import "UINavigationController+TransparentNavigationController.h"

#define BOT_BUTTON_HEIGHT 50
#define SLIDER_VIEW_HEIGHT 140

@interface CollectFlowersViewController ()
@property (nonatomic, strong) UIScrollView* scrollView;
@property (nonatomic, strong) UIImageView* imageFlowerTop;
@property (nonatomic, strong) UIView* sliderView;
@property (nonatomic, strong) UIView* toneSelectView;
@property (nonatomic, strong) UIButton* buttonNext;
@end

@implementation CollectFlowersViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        UIImage *image = [UIImage imageNamed:@"flowers-logo"];
        self.navigationItem.titleView = [[UIImageView alloc] initWithImage:image];
        self.view.backgroundColor =  [UIColor colorWithRed:248.0f/255.0f green:248.0f/255.0f blue:248.0f/255.0f alpha:1.0f];
       
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageFromColor:self.view.backgroundColor]
                                          forBarPosition:UIBarPositionAny
                                              barMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController presentTransparentNavigationBar];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [self.navigationController hideTransparentNavigationBar];
}



- (void)setupUI {
    self.view.backgroundColor = [UIColor grayColor];
    [self addSideMenuButton];
    
    _scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:_scrollView];
    
    _imageFlowerTop = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"2k"]];
    [self.scrollView addSubview:_imageFlowerTop];
    
    _buttonNext = [[UIButton alloc] init];
    [_buttonNext addTarget:self action:@selector(segueNext: ) forControlEvents:UIControlEventTouchDown];
    [_buttonNext setTitle:NSLS(@"ДАЛЕЕ") forState:UIControlStateNormal];
    [_buttonNext setBackgroundColor:UICOLOR_LIGHT_BLUE];
    [self.view addSubview:_buttonNext];
    
}

- (void) segueNext : (id) sender {
    
}

- (void) setupNavBar {

}

- (void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width,self.view.frame.size.height - BOT_BUTTON_HEIGHT + 1);
    _scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height - BOT_BUTTON_HEIGHT );
    _buttonNext.frame = CGRectMake(0, self.view.frame.size.height - BOT_BUTTON_HEIGHT, self.view.frame.size.width, BOT_BUTTON_HEIGHT);
}

@end
