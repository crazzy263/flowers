//
//  WelcomeTourModel.m
//  flowers
//
//  Created by iOS Developer on 28.04.17.
//  Copyright © 2017 Maksim Kis. All rights reserved.
//

#import "WelcomeTourModel.h"

@implementation WelcomeTourModel

- (instancetype) initWithTitle : (NSString*) text Image : (NSString*) image Description : (NSString*) description  {
    self = [super init];
    if (self) {
        self.titleHolder = text;
        self.imageHolder = image;
        self.descriptionHolder = description;
    }
    return self;
}
@end
