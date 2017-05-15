//
//  LeftMenuItemCell.m
//  flowers
//
//  Created by Crazzy on 25.04.17.
//  Copyright © 2017 Maksim Kis. All rights reserved.
//

#import "LeftMenuItemCell.h"
#import "LeftMenuItemModel.h"

#define LEFT_MENU_ITEM_ICON_SIZE 25
#define LEFT_MENU_ITEM_TEXT_HEIGHT 25
#define LEFT_MENU_ITEM_TEXT_INSET 25
#define LEFT_MENU_ITEM_ICON_INSET 35

#define LEFT_MENU_ITEM_EXIT_STYLE_INSET_WIDTH_BOTTOM 75

@interface LeftMenuItemCell ()
    @property (nonatomic, strong) UIImageView* imageIcon;
    @property (nonatomic, strong) UILabel* textView;
    @property (nonatomic, strong) UIView* separatorView;
@end

@implementation LeftMenuItemCell

- (void) prepareForReuse {
    [super prepareForReuse];
    _imageIcon.image = nil;
    _textView.text = nil;

}

- (void) commonInit {
    [super commonInit];
    
    _imageIcon = [UIImageView new];
    _textView = [UILabel new];
    _textView.font = [UIFont systemFontOfSize:15];
    _textView.textColor = [UIColor blackColor];
    _separatorView = [[UIView alloc] init];
    _separatorView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_imageIcon];
    [self.contentView addSubview:_textView];
    [self.contentView addSubview:_separatorView];
}

- (void) setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    if(!highlighted) {
        _textView.textColor = [UIColor darkGrayColor];
        _imageIcon.tintColor = [UIColor darkGrayColor];
    }
    else {
        _textView.textColor = [UIColor whiteColor];
        _imageIcon.tintColor = [UIColor whiteColor];
    }
}
- (void) setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if(selected) {
        _textView.textColor = [UIColor whiteColor];
        _imageIcon.tintColor = [UIColor whiteColor];
    }
    else {
         _textView.textColor = [UIColor darkGrayColor];
        _imageIcon.tintColor = [UIColor darkGrayColor];
    }
}


- (void) layoutSubviews {
    [super layoutSubviews];
    
    if(_model.rowStyle == LeftMenuItemStyleNone || _model.rowStyle == LeftMenuItemStyleBottomSeparator) {
        [_imageIcon setFrame:CGRectMake(LEFT_MENU_ITEM_ICON_INSET, self.bounds.size.height / 2 - LEFT_MENU_ITEM_ICON_SIZE / 2, LEFT_MENU_ITEM_ICON_SIZE, LEFT_MENU_ITEM_ICON_SIZE)];
        
        
        [_textView setFrame:CGRectMake(_imageIcon.frame.origin.x + LEFT_MENU_ITEM_ICON_SIZE + LEFT_MENU_ITEM_TEXT_INSET ,
                                       self.bounds.size.height / 2 - LEFT_MENU_ITEM_TEXT_HEIGHT / 2, self.bounds.size.width - _imageIcon.frame.origin.x + LEFT_MENU_ITEM_ICON_SIZE + LEFT_MENU_ITEM_TEXT_INSET , LEFT_MENU_ITEM_TEXT_HEIGHT)];
        
        if(_model.rowStyle == LeftMenuItemStyleBottomSeparator) {
            [_separatorView setFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, 1.0f / 2.0f)];
        }
    }
    else {
        [_imageIcon setFrame:CGRectMake(LEFT_MENU_ITEM_ICON_INSET, self.bounds.size.height - LEFT_MENU_ITEM_EXIT_STYLE_INSET_WIDTH_BOTTOM / 2 - LEFT_MENU_ITEM_ICON_SIZE / 2, LEFT_MENU_ITEM_ICON_SIZE, LEFT_MENU_ITEM_ICON_SIZE)];
        
        
        [_textView setFrame:CGRectMake(_imageIcon.frame.origin.x + LEFT_MENU_ITEM_ICON_SIZE + LEFT_MENU_ITEM_TEXT_INSET ,
                                       self.bounds.size.height - LEFT_MENU_ITEM_EXIT_STYLE_INSET_WIDTH_BOTTOM / 2 - LEFT_MENU_ITEM_TEXT_HEIGHT / 2, self.bounds.size.width - _imageIcon.frame.origin.x + LEFT_MENU_ITEM_ICON_SIZE + LEFT_MENU_ITEM_TEXT_INSET , LEFT_MENU_ITEM_TEXT_HEIGHT)];
    }
}

- (void) setModel:(LeftMenuItemModel *)model {
    _model = model;
    _imageIcon.image = [[UIImage imageNamed:model.rowImage] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];;
    _textView.text = model.rowLabelText;
}


@end
