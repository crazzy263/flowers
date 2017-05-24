//
//  SliderControl.h
//  flowers
//
//  Created by iOS Developer on 24.05.17.
//  Copyright © 2017 Maksim Kis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SliderControl : UISlider
@property (nonatomic) UIColor *markColor;
@property (nonatomic) CGFloat markWidth;
@property (nonatomic) NSArray *markPositions;
@property (nonatomic) UIColor *selectedBarColor;
@property (nonatomic) UIColor *unselectedBarColor;
@property (nonatomic) UIImage *handlerImage;
@property (nonatomic) UIColor *handlerColor;
@end
