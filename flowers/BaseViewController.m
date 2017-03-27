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
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Left" style:UIBarButtonItemStyleDone target:self action:@selector(pushLeft)];
}

- (void)pushLeft {
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] goTo:@"flowers://left"];
}

@end
