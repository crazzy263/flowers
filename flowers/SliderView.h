//
//  SliderView.h
//  flowers
//
//  Created by iOS Developer on 16.05.17.
//  Copyright © 2017 Maksim Kis. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SliderView;

@protocol SliderViewDelegate <NSObject>
- (void) confirmValue : (SliderView*) slider ValidValue : (CGFloat) value;
@end






@interface SliderView : BaseView

@property(nonatomic, copy) void (^sliderValueChangeHandler)(UISlider *slider);

@property (nonatomic, strong) NSString* titleText;
@property (nonatomic, strong) NSString* descrText;

@end
