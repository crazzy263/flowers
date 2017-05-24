//
//  SliderView.m
//  flowers
//
//  Created by iOS Developer on 16.05.17.
//  Copyright © 2017 Maksim Kis. All rights reserved.
//

#import "SliderView.h"
#import "SliderControl.h"
#import <ASValueTrackingSlider/ASValueTrackingSlider.h>
#define INSET_SIZE 35
#define TOP_INSET 15
#define TITLE_SIZE 25
#define DESCR_SIZE 13



@interface SliderView()
@property (nonatomic, strong) UIView* separator;
@property (nonatomic, strong) ASValueTrackingSlider* slider;
@property (nonatomic, strong) UILabel* labelTitle;
@property (nonatomic, strong) UILabel* labelSliderDescr;

@end

@implementation SliderView

- (void) commonInit {
    [super commonInit];
    self.backgroundColor = [UIColor whiteColor];
    
    self.separator = [UIView new];
    self.separator.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.separator];
    
    self.labelTitle = [UILabel new];
    self.labelTitle.text = NSLS(@"Выбери свой букет");
    self.labelTitle.font = [UIFont systemFontOfSize:TITLE_SIZE];
    [self addSubview:self.labelTitle];
    
    self.labelSliderDescr = [UILabel new];
    self.labelSliderDescr.text = NSLS(@"Стоимость и размер:");
    self.labelSliderDescr.font = [UIFont systemFontOfSize:DESCR_SIZE];
    [self addSubview:self.labelSliderDescr];
    
    self.slider = [ASValueTrackingSlider new];
    self.slider.maximumValue = 10000.0;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
//    formatter.locale = [NSLocale LOCAL];
    [self.slider setNumberFormatter:formatter];
    self.slider.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:14];
    self.slider.popUpViewAnimatedColors = @[UICOLOR_LIGHT_BLUE, [UIColor orangeColor]];
    self.slider.popUpViewArrowLength = 5.0;
    [self.slider showPopUpViewAnimated: YES];
    [self.slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.slider.popUpViewHeightPaddingFactor = 1.3;
    [self addSubview:self.slider];
//    [self.slider setThumbImage:[self generateHandleImageWithColor :UICOLOR_LIGHT_BLUE_HIGHLIGHTED] forState:UIControlStateNormal];
//    self.slider.thumbTintColor = UICOLOR_LIGHT_BLUE;
//    self.slider.minimumTrackTintColor = UICOLOR_LIGHT_BLUE;
    
}

- (UIImage *)generateHandleImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, self.bounds.size.height + 20.f, self.bounds.size.height + 20.f);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectInset(rect, 10.f, 10.f));
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)sliderValueChanged:(UISlider *)sender {
    NSLog(@"slider value = %f", sender.value);
    
    if(_sliderValueChangeHandler != nil) {
        _sliderValueChangeHandler(sender);
    }
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    self.separator.frame = CGRectMake(INSET_SIZE, self.frame.size.height + 1, self.frame.size.width - INSET_SIZE * 2, 0.5);
    
   
    [self.labelTitle sizeToFit];
    
    CGSize maxSize = CGSizeMake(self.labelTitle.frame.size.width, MAXFLOAT);
    
    CGRect titleRect = [self.labelTitle.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.labelTitle.font} context:nil];
    
    CGRect descrRect = [self.labelTitle.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.labelSliderDescr.font} context:nil];
    
    self.labelTitle.frame = CGRectMake(INSET_SIZE, TOP_INSET, self.frame.size.width, titleRect.size.height);
    self.labelSliderDescr.frame = CGRectMake(INSET_SIZE, CGRectGetMaxY(self.labelTitle.frame) + TOP_INSET, self.frame.size.width, descrRect.size.height);
    
    self.slider.frame = CGRectMake(INSET_SIZE, CGRectGetMaxY(self.labelSliderDescr.frame) + TOP_INSET *  2, self.frame.size.width - INSET_SIZE * 2, 31);
}


@end
