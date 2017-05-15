//
//  BaseViewController.m
//  flowers
//
//  Created by Crazzy on 26.03.17.
//  Copyright © 2017 Maksim Kis. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    [self setupUI];
    
}

- (void) setupNavBar {
    
}

- (void) setupUI  {
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)showMessage:(NSString*)message withTitle:(NSString *)title {
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ок" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        //do something when click button
    }];
    [alert addAction:okAction];
    UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    [vc presentViewController:alert animated:YES completion:nil];
}

- (void)reloadFromAppLinkRefresh {
    
}

- (void)addSideMenuButton {
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[[UIImage imageNamed:@"menu"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 20.0, 20.0);
    UIBarButtonItem* barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    button.tintColor = [UIColor blackColor];
    [button addTarget:self action:@selector(pushLeft) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.navigationItem.leftBarButtonItem = barButton;

}

- (void)pushLeft {
    RouterNavigate(URL_NAVIGATE_MENU);
}

@end
