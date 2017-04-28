//
//  WalkthroughViewController.m
//  flowers
//
//  Created by iOS Developer on 28.04.17.
//  Copyright © 2017 Maksim Kis. All rights reserved.
//

#import "WalkthroughViewController.h"
#import "WelcomeTourModel.h"
@interface WalkthroughViewController ()
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* descriptionLabel;
@property (nonatomic, strong) UIImageView* imageView;
@end

@implementation WalkthroughViewController

- (void) setupUI {

}


- (void) setModel:(WelcomeTourModel *)model {
    _model = model;
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont boldSystemFontOfSize:20];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.numberOfLines = 0;
    
    _descriptionLabel = [UILabel new];
    _descriptionLabel.font = [UIFont boldSystemFontOfSize:17];
    _descriptionLabel.textColor = [UIColor grayColor];
    _descriptionLabel.numberOfLines = 0;
    _descriptionLabel.textAlignment = NSTextAlignmentCenter;
    
    _imageView = [UIImageView new];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:_titleLabel];
    [self.view addSubview:_descriptionLabel];
    [self.view addSubview:_imageView];
    _titleLabel.text = model.titleHolder;
    _descriptionLabel.text = model.descriptionHolder;
    _imageView.image = [UIImage imageNamed:model.imageHolder];
    
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

    [self.imageView setFrame:CGRectMake(0, self.view.bounds.size.height * 0.1, self.view.bounds.size.width, self.view.bounds.size.height * 0.65)];
    [self.titleLabel setFrame:CGRectMake(0, self.view.bounds.size.height * 0.76, self.view.bounds.size.width, self.view.bounds.size.height * 0.08 )];
    [self.descriptionLabel setFrame:CGRectMake(0, self.view.bounds.size.height * 0.85, self.view.bounds.size.width, self.view.bounds.size.height * 0.15)];
    
}

@end
