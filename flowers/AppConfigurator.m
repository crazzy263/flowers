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
#import <VK-ios-sdk/VKSdk.h>

static NSArray *SCOPE = nil;

@interface AppConfigurator ()  <UIAlertViewDelegate, VKSdkDelegate>

@property (nonatomic, strong) AppDelegate* application;

@property (nonatomic, weak) UIViewController* currentController;
@end

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
        _loggedType = [[NSUserDefaults standardUserDefaults] integerForKey:@"loggedType"];
         SCOPE = @[VK_PER_NOHTTPS, VK_PER_EMAIL, VK_PER_PHOTOS];
        _loggedIn = NO;
        _vkEmail = [[NSUserDefaults standardUserDefaults] stringForKey:@"emailVk"];
        
        _vkUserName = [[NSUserDefaults standardUserDefaults] stringForKey:@"vkUsername"];
        
        _vkPhoto= [[NSUserDefaults standardUserDefaults] stringForKey:@"vkPhoto"];
        _showOnlyRegister = NO;
        return self;
    }
    
    return nil;
}

#pragma mark - Configuration

- (void)configure:(AppDelegate *)application {
    self.application = application;
    [[VKSdk initializeWithAppId:@"3974615"] registerDelegate:self];
    [[VKSdk instance] setUiDelegate:self];
    
    if(_loggedType == 1) {// vk
        [VKSdk wakeUpSession:SCOPE completeBlock:^(VKAuthorizationState state, NSError *error) {
            if (state == VKAuthorizationAuthorized) {
                _loggedIn = YES;
            } else if (error) {
                [[[UIAlertView alloc] initWithTitle:nil message:[error description] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
            }
        }];
    }
    
    
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
    
      [revealSideViewController setPanInteractionsWhenClosed:PPRevealSideInteractionContentView | PPRevealSideInteractionNavigationBar];
    
    application.window.rootViewController = revealSideViewController;
    [application.window makeKeyAndVisible];
    
//    application.window.tintColor = [UIColor colorWithRed:245.0f/255.0f green:193.0f/255.0f blue:191.0f/255.0f alpha:1.0f];
    UIView* view = [UIView new];
    view.backgroundColor = UICOLOR_LIGHT_BLUE_HIGHLIGHTED;
    [UITableViewCell appearance].selectedBackgroundView = view;
//    for (NSString *familyName in [UIFont familyNames]) {
//        for (NSString *fontName in [UIFont fontNamesForFamilyName:familyName]) {
//            NSLog(@"%@", fontName);
//        }
//    }
    
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

- (void) setLoggedType:(NSInteger)loggedType {
    _loggedType = loggedType;
    [[NSUserDefaults standardUserDefaults] setInteger:loggedType forKey:@"loggedType"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) setVkEmail:(NSString *)vkEmail {
    _vkEmail = vkEmail;
    [[NSUserDefaults standardUserDefaults] setObject:vkEmail forKey:@"emailVk"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (void) setVkPhoto:(NSString *)vkPhoto {
    _vkPhoto = vkPhoto;
    [[NSUserDefaults standardUserDefaults] setObject:vkPhoto forKey:@"vkPhoto"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) setVkUserName:(NSString *)vkUserName {
    _vkUserName = vkUserName;
    [[NSUserDefaults standardUserDefaults] setObject:vkUserName forKey:@"vkUsername"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark VK DELEGATES




- (void)vkSdkTokenHasExpired:(VKAccessToken *)expiredToken {
    [self authorize:1];
}

//- (void)vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result {
//    if (result.token) {
//        self.loggedIn = YES;
//        self.loggedType = 1;
//        self.vkEmail = result.token.email;
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"authFinished" object:nil];
//    } else if (result.error) {
//        [[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:NSLS(@"Ошибка доступа\n%@"), result.error] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
//        self.loggedIn = NO;
//        self.loggedType = 0;
//    }
//}

- (void)vkSdkAuthorizationStateUpdatedWithResult:(VKAuthorizationResult *)result {
    if (result.token) {
        

        self.loggedIn = YES;
        self.loggedType = 1;
        self.vkEmail = result.token.email;
        self.vkPhoto = result.user.photo_200;
        NSString* userName = @"";
        
        if(result.user.first_name != nil ) {
            userName = [NSString stringWithFormat:@"%@ ", result.user.first_name];
        }
        
        if(result.user.last_name != nil ) {
            userName =  [NSString stringWithFormat:@"%@%@",userName, result.user.last_name];
        }

        
        self.vkUserName = userName;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"authFinished" object:nil];
    } else if (result.error) {
        [[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:NSLS(@"Ошибка доступа\n%@"), result.error] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        self.loggedIn = NO;
        self.loggedType = 0;
    }

}

- (void)vkSdkUserAuthorizationFailed {
    [[[UIAlertView alloc] initWithTitle:nil message:NSLS(@"Ошибка доступа") delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
}

- (void)vkSdkShouldPresentViewController:(UIViewController *)controller {

}


- (void)authorize:(NSInteger)type {
    if(type == 1) {
        [VKSdk authorize:SCOPE];
    }
    else if(type == 2) {
            [[[UIAlertView alloc] initWithTitle:nil message:NSLS(@"Требуется Facebook appId") delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
    else if(type == 3) {
            [[[UIAlertView alloc] initWithTitle:nil message:NSLS(@"Данный функционал в разработке") delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
}

- (void)logout {
    _vkUserName = @"";
    _vkPhoto = @"";
    _vkEmail = @"";
    _loggedIn = NO;
    _loggedType = 0;
    [VKSdk forceLogout];
     [[NSNotificationCenter defaultCenter] postNotificationName:@"authFinished" object:nil];
}

@end
