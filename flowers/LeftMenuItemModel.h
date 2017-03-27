//
//  LeftMenuModel.h
//  flowers
//
//  Created by iOS Developer on 27.03.17.
//  Copyright © 2017 Maksim Kis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LeftMenuItemModel : NSObject

@property (nonatomic, copy) NSString* rowImage;
@property (nonatomic, copy) NSString* rowLabelText;
@property (nonatomic, copy) NSString* rowRoute;

@property (nonatomic, strong) void (^itemTapHandler)(LeftMenuItemModel* menuItem);

- (instancetype) initWithText : (NSString*) text Image : (NSString*) image RoutePath : (NSString*) route;
@end
