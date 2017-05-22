//
//  SliderView.m
//  flowers
//
//  Created by iOS Developer on 16.05.17.
//  Copyright © 2017 Maksim Kis. All rights reserved.
//

#import "SliderView.h"


@interface SliderViewSource()
@property (nonatomic) CGFloat validValue;
@property (nonatomic) CGFloat appearanceValue;
@property (nonatomic, strong) UILabel* label;
@end


@implementation SliderViewSource

- (instancetype) initWithValidValue : (CGFloat) validValue  AppearanceValue  : (CGFloat) value Label : (UILabel*) label {
    if(self == [super init]) {
        self.validValue = validValue;
        self.appearanceValue = value;
        self.label = label;
        return self;
    }
    
    return nil;
}
@end


@implementation SliderView

- (void) commonInit {
    [super commonInit];
    self.backgroundColor = [UIColor whiteColor];
}


@end
