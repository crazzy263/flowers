//
//  AppDelegate.h
//  flowers
//
//  Created by Crazzy on 25.03.17.
//  Copyright © 2017 Maksim Kis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)goTo:(NSString *)route, ... ;

@end

