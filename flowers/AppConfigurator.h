//
//  AppConfigurator.h
//  flowers
//
//  Created by iOS Developer on 25.04.17.
//  Copyright © 2017 Maksim Kis. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RouterNavigate(x) [[AppConfigurator sharedInstance] openAppUrl : x]

#define URL_NAVIGATE_MENU @"flowers://left"
#define URL_NAVIGATE_WELCOME @"flowers://modalWelcome"
#define URL_NAVIGATE_COLLECTFLOWERS @"flowers://collectFlowers"
@class AppDelegate;
@class WAAppRouter;

@interface AppConfigurator : NSObject

@property (nonatomic, strong) WAAppRouter *mainRouter;

@property (nonatomic, assign) BOOL isTourShowed;

@property (nonatomic) NSInteger loggedType; // 0none -  1vk  - 2fb -  3sms
@property (nonatomic, assign) BOOL loggedIn;

@property (nonatomic ,assign) BOOL showOnlyRegister;
@property (nonatomic, strong) NSString* vkEmail;
@property (nonatomic, strong) NSString* vkUserName;
@property (nonatomic, strong) NSString* vkPhoto;
+ (instancetype)sharedInstance;

- (void)configure:(AppDelegate *)application;

- (BOOL) processUrlScheme : (NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options;

- (void) openAppUrl : (NSString*) url ;

- (void)authorize:(NSInteger)type;
- (void)logout;
@end
