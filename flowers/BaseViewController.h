//
//  BaseViewController.h
//  flowers
//
//  Created by Crazzy on 26.03.17.
//  Copyright © 2017 Maksim Kis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WAAppRouting/WAAppRouting.h>
#import <PPRevealSideViewController/PPRevealSideViewController.h>
#import "AppDelegate.h"

@interface BaseViewController : UIViewController  <WAAppRouterTargetControllerProtocol>

@property (nonatomic, strong) id commonObject;
- (void) showMessage:(NSString*)message withTitle:(NSString *)title;

- (void) setupNavBar;

- (void) setupUI;

- (void) addSideMenuButton;
@end
