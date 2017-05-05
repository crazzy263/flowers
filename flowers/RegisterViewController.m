//
//  RegisterViewController.m
//  flowers
//
//  Created by iOS Developer on 28.04.17.
//  Copyright © 2017 Maksim Kis. All rights reserved.
//

#import "RegisterViewController.h"
#import "WelcomeTourModel.h"
#import "LeftIconButton.h"
#import "AppConfigurator.h"
#import <VK-ios-sdk/VKSdk.h>

#define BUTTON_INSET 30
@interface RegisterViewController() <VKSdkUIDelegate, VKSdkDelegate>
@property (nonatomic, strong) UILabel* titleLabelTop;
@property (nonatomic, strong) UILabel* titleLabelTopDescr;

@property (nonatomic, strong) LeftIconButton* facebookBtn;
@property (nonatomic, strong) LeftIconButton* vkontakteBtn;
@property (nonatomic, strong) LeftIconButton* smsBtn;

@property (nonatomic, strong) UIImageView* imageView;

@property (nonatomic, strong) UILabel* descriptionLabel;

@end

@implementation RegisterViewController

- (void) setupUI {
    _titleLabelTop = [UILabel new];
    _titleLabelTop.font = [UIFont boldSystemFontOfSize:20];
    _titleLabelTop.textColor = [UIColor blackColor];
    _titleLabelTop.textAlignment = NSTextAlignmentCenter;
    _titleLabelTop.numberOfLines = 0;
    _titleLabelTop.text = NSLS(@"ВХОД/ РЕГИСТРАЦИЯ");
    [self.view addSubview:_titleLabelTop];
    [[VKSdk instance] setUiDelegate:self];
    [[VKSdk instance] registerDelegate:self];
    _titleLabelTopDescr = [UILabel new];
    _titleLabelTopDescr.font = [UIFont boldSystemFontOfSize:16];
    _titleLabelTopDescr.textColor = [UIColor lightGrayColor];
    _titleLabelTopDescr.textAlignment = NSTextAlignmentCenter;
    _titleLabelTopDescr.numberOfLines = 0;
    _titleLabelTopDescr.text = NSLS(@"через");
    [self.view addSubview:_titleLabelTopDescr];
    
    
   
    _facebookBtn = [LeftIconButton new];
    [_facebookBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 12, 0, 12)];
    [_facebookBtn setImage:[UIImage imageNamed:@"facebook-logo"] forState:UIControlStateNormal];
    [_facebookBtn setTitle:@"Facebook" forState:UIControlStateNormal];
    _facebookBtn.backgroundColor = [UIColor colorWithRed:59.0f/255.0f green:89.0f/255.0f blue:152/255.0f alpha:1.0f];
     [_facebookBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_facebookBtn addTarget:self action:@selector(fbTapInSide:) forControlEvents:UIControlEventTouchUpInside];
    [_facebookBtn addTarget:self action:@selector(fbTapDown:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_facebookBtn];

    _vkontakteBtn = [LeftIconButton new];
    [_vkontakteBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 12, 0, 12)];
    [_vkontakteBtn setImage:[UIImage imageNamed:@"vk-social-network-logo"] forState:UIControlStateNormal];
    [_vkontakteBtn setTitle:@"Vkontakte" forState:UIControlStateNormal];
   _vkontakteBtn.backgroundColor = [UIColor colorWithRed:104.0f/255.0f green:137.0f/255.0f blue:182/255.0f alpha:1.0f];
    [_vkontakteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_vkontakteBtn addTarget:self action:@selector(vkTapInSide:) forControlEvents:UIControlEventTouchUpInside];
    [_vkontakteBtn addTarget:self action:@selector(vkTapDown:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_vkontakteBtn];

    _smsBtn = [LeftIconButton new];
    [_smsBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 12, 0, 12)];
    [_smsBtn setImage:[UIImage imageNamed:@"phone-receiver"] forState:UIControlStateNormal];
    [_smsBtn setTitle:NSLS(@"Телефонный номер") forState:UIControlStateNormal];
     _smsBtn.backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:193.0f/255.0f blue:191.0f/255.0f alpha:1.0f];
    [_smsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_smsBtn addTarget:self action:@selector(smsTapInSide:) forControlEvents:UIControlEventTouchUpInside];
    [_smsBtn addTarget:self action:@selector(smsTapDown:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_smsBtn];
    
    
    _descriptionLabel = [UILabel new];
    _descriptionLabel.font = [UIFont boldSystemFontOfSize:17];
    _descriptionLabel.textColor = [UIColor grayColor];
    _descriptionLabel.numberOfLines = 0;
    _descriptionLabel.textAlignment = NSTextAlignmentCenter;
    _descriptionLabel.text = NSLS(@"Авторизуйтесь, чтобы получить\nприятный подарок при первом заказе букета");
    
    _imageView = [UIImageView new];
    _imageView.contentMode = UIViewContentModeCenter;
    [self.view addSubview:_descriptionLabel];
    [self.view addSubview:_imageView];
 
    _imageView.image = [UIImage imageNamed:@"gift_reg"];
    
}

-(void) fbTapInSide : (id) sender {
    _facebookBtn.backgroundColor = [UIColor colorWithRed:59.0f/255.0f green:89.0f/255.0f blue:152/255.0f alpha:1.0f];
     [[AppConfigurator sharedInstance] authorize:2];
}

-(void) fbTapDown : (id) sender {
    _facebookBtn.backgroundColor = [UIColor colorWithRed:139.0f/255.0f green:157.0f/255.0f blue:195/255.0f alpha:1.0f];
}


-(void) vkTapInSide : (id) sender {
    _vkontakteBtn.backgroundColor = [UIColor colorWithRed:92.0f/255.0f green:128.0f/255.0f blue:169/255.0f alpha:1.0f];
    [[AppConfigurator sharedInstance] authorize:1];
}

-(void) vkTapDown : (id) sender {
    _vkontakteBtn.backgroundColor = [UIColor colorWithRed:104.0f/255.0f green:137.0f/255.0f blue:182/255.0f alpha:1.0f];
}

-(void) smsTapInSide : (id) sender {
      _smsBtn.backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:193.0f/255.0f blue:191.0f/255.0f alpha:1.0f];
         [[AppConfigurator sharedInstance] authorize:3];
}

-(void) smsTapDown : (id) sender {
     _smsBtn.backgroundColor = [UIColor colorWithRed:220.0f/255.0f green:170.0f/255.0f blue:160.0f/255.0f alpha:1.0f];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
   
    [self.titleLabelTop setFrame:CGRectMake(0, self.view.bounds.size.height * 0.18, self.view.bounds.size.width, self.view.bounds.size.height * 0.04 )];
    [self.titleLabelTopDescr setFrame:CGRectMake(0, self.view.bounds.size.height * 0.22, self.view.bounds.size.width, self.view.bounds.size.height * 0.03 )];
    
     [self.facebookBtn setFrame:CGRectMake(BUTTON_INSET, self.view.bounds.size.height * 0.36, self.view.bounds.size.width - BUTTON_INSET * 2, self.view.bounds.size.height * 0.08 )];
    
    [self.vkontakteBtn setFrame:CGRectMake(BUTTON_INSET, self.view.bounds.size.height * 0.48, self.view.bounds.size.width - BUTTON_INSET * 2, self.view.bounds.size.height * 0.08 )];
    
    [self.smsBtn setFrame:CGRectMake(BUTTON_INSET, self.view.bounds.size.height * 0.60, self.view.bounds.size.width - BUTTON_INSET * 2, self.view.bounds.size.height * 0.08 )];
    
    
     [self.imageView setFrame:CGRectMake(0, self.view.bounds.size.height * 0.72, self.view.bounds.size.width, self.view.bounds.size.height * 0.08)];
    
    [self.descriptionLabel setFrame:CGRectMake(0, self.view.bounds.size.height * 0.85, self.view.bounds.size.width, self.view.bounds.size.height * 0.15)];
    
}





- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError {
    VKCaptchaViewController *vc = [VKCaptchaViewController captchaControllerWithError:captchaError];
    [vc presentIn: self];
}


- (void)vkSdkUserAuthorizationFailed {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)vkSdkShouldPresentViewController:(UIViewController *)controller {
    [self presentViewController:controller animated:YES completion:nil];
}

@end
