//
//  AppDelegate.m
//  flowers
//
//  Created by Crazzy on 25.03.17.
//  Copyright © 2017 Maksim Kis. All rights reserved.
//

#import "AppDelegate.h"
#import <WAAppRouting/WAAppRouting.h>
#import "LeftMenuController.h"
#import <PPRevealSideViewController/PPRevealSideViewController.h>
#import "CollectFlowersViewController.h"

@interface AppDelegate ()
@property (nonatomic, strong) WAAppRouter *router;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    CollectFlowersViewController* collectFlowers = [[CollectFlowersViewController alloc] init];
    UINavigationController *navController    = [[UINavigationController alloc] initWithRootViewController:collectFlowers];
    PPRevealSideViewController *revealSideViewController = [[PPRevealSideViewController alloc] initWithRootViewController:navController];
   
    
    LeftMenuController *leftMenu = [[LeftMenuController alloc] init];
    [revealSideViewController preloadViewController:leftMenu forSide:PPRevealSideDirectionLeft];
    revealSideViewController.options = PPRevealSideOptionsNone;
    
   [revealSideViewController resetOption:PPRevealSideOptionsiOS7StatusBarFading];
[revealSideViewController setOption:PPRevealSideOptionsiOS7StatusBarFading];
     revealSideViewController.fakeiOS7StatusBarColor = [UIColor whiteColor];
    self.router = [WAAppRouter defaultRouter];
    [self.router.registrar registerAppRoutePath:@"collectFlowers{CollectFlowersViewController}" presentingController:revealSideViewController];
    [self.router.registrar registerAppRoutePath:@"left{LeftMenuController}" presentingController:revealSideViewController];
    
    self.window.rootViewController = revealSideViewController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
  
}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}


- (void)applicationWillTerminate:(UIApplication *)application {

}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)URL sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    NSLog(@"openURL: %@", URL);
    BOOL handleUrl = NO;
    
    if ([URL.scheme isEqualToString:@"flowers"]) {
        handleUrl = [self.router handleURL:URL];
    }
    
    if (!handleUrl && ([URL.scheme isEqualToString:@"flowers"])) {
        NSLog(@"Well, this one is not handled, consider displaying a 404");
    }
    
    return handleUrl;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    NSLog(@"openURL: %@", url);
    BOOL handleUrl = NO;
    
    if ([url.scheme isEqualToString:@"flowers"]) {
        handleUrl = [self.router handleURL:url];
    }
    
    if (!handleUrl && ([url.scheme isEqualToString:@"flowers"])) {
        NSLog(@"Well, this one is not handled, consider displaying a 404");
    }
    
    return handleUrl;
}


- (void)goTo:(NSString *)route, ... {
    va_list args;
    va_start(args, route);
    NSString *finalRoute = [[NSString alloc] initWithFormat:route arguments:args];
    va_end(args);
    
    [self application:(UIApplication *)self openURL:[NSURL URLWithString:finalRoute] options:[NSDictionary dictionary]];
}

@end
