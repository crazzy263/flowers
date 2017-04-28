//
//  LeftMenuModel.h
//  flowers
//
//  Created by iOS Developer on 27.03.17.
//  Copyright © 2017 Maksim Kis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LeftMenuItemStyle) {
    LeftMenuItemStyleNone = 0,
    LeftMenuItemStyleBottomSeparator,
    LeftMenuItemStyleExit
};

typedef void (^ItemTapHandler)();

@interface LeftMenuItemModel : NSObject

@property (nonatomic, copy) NSString* rowImage;
@property (nonatomic, copy) NSString* rowLabelText;
@property (nonatomic, copy) NSString* rowRoute;
@property (nonatomic) LeftMenuItemStyle rowStyle;
@property (nonatomic, copy) ItemTapHandler itemTapHandler;
- (instancetype) initWithText : (NSString*) text Image : (NSString*) image RoutePath : (NSString*) route Style : (LeftMenuItemStyle) style  TapHandler : (ItemTapHandler) handler;
@end
