//
//  AppDelegate.m
//  flowers
//
//  Created by Crazzy on 25.03.17.
//  Copyright © 2017 Maksim Kis. All rights reserved.
//

#import "AppDelegate.h"
#import <WAAppRouting/WAAppRouting.h>

@interface AppDelegate ()
@property (nonatomic, strong) WAAppRouter *router;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.router = [WAAppRouter defaultRouter];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
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


@end
