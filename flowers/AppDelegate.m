//
//  AppDelegate.m
//  flowers
//
//  Created by Crazzy on 25.03.17.
//  Copyright © 2017 Maksim Kis. All rights reserved.
//

#import "AppDelegate.h"
#import "AppConfigurator.h"

@interface AppDelegate ()
@property (nonatomic, strong) WAAppRouter *router;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[AppConfigurator sharedInstance] configure:self];
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

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return [[AppConfigurator sharedInstance] processUrlScheme:url options:options];
}


- (void)goTo:(NSString *)route, ... {
    va_list args;
    va_start(args, route);
    NSString *finalRoute = [[NSString alloc] initWithFormat:route arguments:args];
    va_end(args);
    
    [self application:(UIApplication *)self openURL:[NSURL URLWithString:finalRoute] options:[NSDictionary dictionary]];
}

@end
