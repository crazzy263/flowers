//
//  LeftMenuProfileCell.m
//  flowers
//
//  Created by Crazzy on 25.04.17.
//  Copyright © 2017 Maksim Kis. All rights reserved.
//

#import "LeftMenuProfileView.h"

@interface LeftMenuProfileView ()

@property (nonatomic, strong) UILabel* textName;
@property (nonatomic, strong) UILabel* textEmail;
@end

@implementation LeftMenuProfileView



- (void) commonInit {
    [super commonInit];
    self.backgroundColor  = [UIColor colorWithRed:245.0f/255.0f green:218.0f/255.0f blue:218.0f/255.0f alpha:1.0f];
    _textName = [UILabel new];
    _textEmail = [UILabel new];
    
    [self addSubview:_textName];
    [self addSubview:_textEmail];
}



- (void) layoutSubviews {
    [super layoutSubviews];
    
}
@end
