//
//  LeftIconButton.m
//  flowers
//
//  Created by iOS Developer on 05.05.17.
//  Copyright © 2017 Maksim Kis. All rights reserved.
//

#import "LeftIconButton.h"

@implementation LeftIconButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) layoutSubviews {
    [super layoutSubviews];
    
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    CGRect availableSpace = UIEdgeInsetsInsetRect(self.bounds, self.contentEdgeInsets);
    CGFloat availableWidth = availableSpace.size.width - self.imageEdgeInsets.right - ( self.imageView == nil ? 0 : self.imageView.frame.size.width) - (self.titleLabel == nil ? 0 : self.titleLabel.frame.size.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, availableWidth / 2, 0, 0);
}

@end
