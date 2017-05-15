//
//  LeftMenuProfileCell.m
//  flowers
//
//  Created by Crazzy on 25.04.17.
//  Copyright © 2017 Maksim Kis. All rights reserved.
//

#import "LeftMenuProfileView.h"
//#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>
#import <SDWebImage/UIView+WebCache.h>

#define IMAGE_BUTTON_INSET 20
#define IMAGE_BUTTON_SIZE 70
#define LABEL_NAME_HEIGHT 15
@interface LeftMenuProfileView () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UILabel* textName;
@property (nonatomic, strong) UILabel* textEmail;
@property (nonatomic, strong) UIButton* textNeedAuthorize;
@property (nonatomic, strong) UIButton* imageAvatar;
@end

@implementation LeftMenuProfileView



- (void) commonInit {
    [super commonInit];
    self.backgroundColor  = UICOLOR_LIGHT_BLUE;
    _textName = [UILabel new];
    _textEmail = [UILabel new];
    _textNeedAuthorize = [UIButton new];
    _imageAvatar = [UIButton new];
    
    [self addSubview:_textName];
    [self addSubview:_textEmail];
    [self addSubview:_textNeedAuthorize];
    [self addSubview:_imageAvatar];
    
    _imageAvatar.layer.masksToBounds = YES;
    _imageAvatar.layer.cornerRadius = IMAGE_BUTTON_SIZE / 2;
    _imageAvatar.layer.borderColor = [UIColor blackColor].CGColor;
    _imageAvatar.layer.borderWidth =  0.5;
    _imageAvatar.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    _textName.hidden = YES;
    _textEmail.hidden = YES;
    _textNeedAuthorize.hidden = YES;
    _imageAvatar.hidden = YES;
      [_imageAvatar addTarget:self action:@selector(chooseAvatar) forControlEvents:UIControlEventTouchUpInside];
    [_textNeedAuthorize setTitle:NSLS(@"Пожалуйста авторизуйтесь") forState:UIControlStateNormal];
    
    [_textNeedAuthorize addTarget:self action:@selector(openAuth) forControlEvents:UIControlEventTouchUpInside];
    
    _textName.font = [UIFont systemFontOfSize:15];
    _textName.textColor = [UIColor whiteColor];

    _textEmail.font = [UIFont systemFontOfSize:12];
    _textEmail.textColor = [UIColor whiteColor];
   
    
    _textNeedAuthorize.titleLabel.font = [UIFont systemFontOfSize:17];
    
    [_textNeedAuthorize setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self authorized];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(authorized) name:@"authFinished" object:nil];
}

- (void)openAuth {
    [AppConfigurator sharedInstance].showOnlyRegister = YES;
    RouterNavigate(URL_NAVIGATE_WELCOME);
}

- (void)chooseAvatar {
    __weak typeof(self) welf = self;
    UIAlertController *ctl = [UIAlertController alertControllerWithTitle:nil
                                                                 message:nil
                                                          preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *selfieAction = [UIAlertAction actionWithTitle:NSLS(@"Сделать фото")
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action)
                                   {
                                       [welf showImagePickerWithType:UIImagePickerControllerSourceTypeCamera];
                                   }];
    [ctl addAction:selfieAction];
    
    UIAlertAction *galleryAction = [UIAlertAction actionWithTitle:NSLS(@"Выбрать из галереи")
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action)
                                    {
                                        [welf showImagePickerWithType:UIImagePickerControllerSourceTypePhotoLibrary];
                                    }];
    [ctl addAction:galleryAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLS(@"Отмена")
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [ctl addAction:cancelAction];
    [self.parentControllerDelegate presentViewController:ctl
                                                animated:YES
                                              completion:nil];

}

- (void)showImagePickerWithType:(UIImagePickerControllerSourceType)type
{
    UIImagePickerController *picker = [UIImagePickerController new];
    picker.delegate      = self;
    picker.allowsEditing = YES;
    picker.sourceType    = type;
    [self.parentControllerDelegate presentViewController:picker
                                                animated:YES
                                              completion:NULL];
}

-(void) authorized {
    if([AppConfigurator sharedInstance].loggedIn == YES) {
        _textName.hidden = NO;
        _textEmail.hidden = NO;
        _imageAvatar.hidden = NO;
        _textNeedAuthorize.hidden = YES;
        
        if( [AppConfigurator sharedInstance].loggedType == 1) {//vk
            _textName.text = [AppConfigurator sharedInstance].vkUserName;
            _textEmail.text = [AppConfigurator sharedInstance].vkEmail;
            [_imageAvatar sd_setImageWithURL:[NSURL URLWithString:[AppConfigurator sharedInstance].vkPhoto] forState:UIControlStateNormal];
            [_imageAvatar sd_setShowActivityIndicatorView:YES];
            [_imageAvatar sd_setIndicatorStyle:UIActivityIndicatorViewStyleGray];
        }
    }
    else {
        _textName.hidden = YES;
        _textEmail.hidden = YES;
        _imageAvatar.hidden = YES;
        _textNeedAuthorize.hidden = NO;
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    [self.imageAvatar setImage:chosenImage forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES
                               completion:NULL];
    
//    [self.parentControllerDelegate.serviceLocator.apiManager updateAvatar:chosenImage completion:^(BOOL result) {
//        [self.parentControllerDelegate requestUser];
//    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES
                               completion:NULL];
}

- (void) layoutSubviews {
    [super layoutSubviews];
    [_imageAvatar setFrame:CGRectMake(IMAGE_BUTTON_INSET, self.frame.size.height / 2 - IMAGE_BUTTON_SIZE / 2 + IMAGE_BUTTON_INSET / 2, IMAGE_BUTTON_SIZE, IMAGE_BUTTON_SIZE)];
    
       [_textName setFrame:CGRectMake(IMAGE_BUTTON_INSET * 2 + IMAGE_BUTTON_SIZE, self.frame.size.height / 2 - LABEL_NAME_HEIGHT + IMAGE_BUTTON_INSET/ 2 , self.frame.size.width - IMAGE_BUTTON_INSET * 2 + IMAGE_BUTTON_SIZE, LABEL_NAME_HEIGHT)];
    
       [_textEmail setFrame:CGRectMake(IMAGE_BUTTON_INSET * 2 + IMAGE_BUTTON_SIZE, self.frame.size.height / 2 + IMAGE_BUTTON_INSET / 2 , self.frame.size.width - IMAGE_BUTTON_INSET * 2 + IMAGE_BUTTON_SIZE, LABEL_NAME_HEIGHT)];
    
        [_textNeedAuthorize setFrame:CGRectMake(IMAGE_BUTTON_INSET, 0, self.frame.size.width* 0.7, self.frame.size.height)];
}
@end
