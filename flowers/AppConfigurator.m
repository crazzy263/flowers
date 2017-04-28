//
//  AppConfigurator.m
//  flowers
//
//  Created by iOS Developer on 25.04.17.
//  Copyright © 2017 Maksim Kis. All rights reserved.
//

#import "AppConfigurator.h"
#import "AppDelegate.h"
#import <WAAppRouting/WAAppRouting.h>
#import "LeftMenuController.h"
#import "CollectFlowersViewController.h"
#import "SideViewController.h"

@implementation AppConfigurator

#pragma mark - Object lifecycle

+ (instancetype)sharedInstance {
    static dispatch_once_t predicate;
    static AppConfigurator *instance = nil;
    dispatch_once(&predicate, ^{instance = [[self alloc] init];});
    return instance;
}

- (instancetype)init {
    if(self == [super init]) {
        _isTourShowed = [[NSUserDefaults standardUserDefaults] boolForKey:@"istourshowed"];
        return self;
    }
    
    return nil;
}

#pragma mark - Configuration

- (void)configure:(AppDelegate *)application {
    application.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    CollectFlowersViewController* collectFlowers = [[CollectFlowersViewController alloc] init];
    UINavigationController *navController    = [[UINavigationController alloc] initWithRootViewController:collectFlowers];
    SideViewController *revealSideViewController = [[SideViewController alloc] initWithRootViewController:navController];
    
    LeftMenuController *leftMenu = [[LeftMenuController alloc] init];
    [revealSideViewController preloadViewController:leftMenu forSide:PPRevealSideDirectionLeft];
    
    
    
    self.mainRouter = [WAAppRouter defaultRouter];
    [self.mainRouter.registrar registerAppRoutePath:@"collectFlowers{CollectFlowersViewController}" presentingController:revealSideViewController];
    [self.mainRouter.registrar registerAppRoutePath:@"left{LeftMenuController}" presentingController:revealSideViewController];
    
    [self.mainRouter.registrar registerBlockRouteHandler:^(WAAppLink *appLink) {
//        if(_isTourShowed == NO) {
//            [self setIsTourShowed:YES];
//            RouterNavigate(URL_NAVIGATE_WELCOME);
//        }
    } forRoute:@"*"];
    
    [self.mainRouter.routeHandler setShouldHandleAppLinkBlock:^BOOL(WAAppRouteEntity *entity) {
        // Could return NO if not logged in for example
        BOOL bResult = [AppConfigurator sharedInstance].isTourShowed;
        
        if(bResult == NO) {
            bResult = YES;
            [[AppConfigurator sharedInstance] setIsTourShowed:bResult];
            RouterNavigate(URL_NAVIGATE_WELCOME);
        }
        
        return bResult;
    }];
    
    [self.mainRouter.registrar registerAppRoutePath:@"modalWelcome{WelcomeViewController}!"
                           presentingController:nil];
    
    
    [revealSideViewController resetOption:PPRevealSideOptionsiOS7StatusBarFading];
    [revealSideViewController setOption:PPRevealSideOptionsNoStatusBar];
    [revealSideViewController resetOption:PPRevealSideOptionsShowShadows];
    
    application.window.rootViewController = revealSideViewController;
    [application.window makeKeyAndVisible];
    
    application.window.tintColor = [UIColor colorWithRed:245.0f/255.0f green:193.0f/255.0f blue:191.0f/255.0f alpha:1.0f];
    
    RouterNavigate(URL_NAVIGATE_COLLECTFLOWERS);
}

- (BOOL) processUrlScheme : (NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    NSLog(@"openURL: %@", url);
    BOOL handleUrl = NO;
    
    if ([url.scheme isEqualToString:@"flowers"]) {
        handleUrl = [self.mainRouter handleURL:url];
    }
    
    if (!handleUrl && ([url.scheme isEqualToString:@"flowers"])) {
        NSLog(@"Well, this one is not handled, consider displaying a 404");
    }
    
    return handleUrl;
}

- (void) openAppUrl : (NSString*) url {
     [(AppDelegate *)[[UIApplication sharedApplication] delegate] goTo:url];
}

- (void) setIsTourShowed:(BOOL)isTourShowed {
    _isTourShowed = isTourShowed;
    [[NSUserDefaults standardUserDefaults] setBool:isTourShowed forKey:@"istourshowed"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



@end
