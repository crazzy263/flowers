//
//  LeftMenuModel.m
//  flowers
//
//  Created by iOS Developer on 27.03.17.
//  Copyright © 2017 Maksim Kis. All rights reserved.
//

#import "LeftMenuItemModel.h"

@implementation LeftMenuItemModel

- (instancetype) initWithText : (NSString*) text Image : (NSString*) image RoutePath : (NSString*) route {
    self = [super init];
    if (self) {
        self.rowLabelText = text;
        self.rowImage = image;
        self.rowRoute = route;
    }
    return self;
}
@end
