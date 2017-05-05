//
//  WelcomeViewController.m
//  flowers
//
//  Created by iOS Developer on 25.04.17.
//  Copyright © 2017 Maksim Kis. All rights reserved.
//

#import "WelcomeViewController.h"
#import "WalkthroughViewController.h"
#import "WelcomeTourModel.h"
#import "RegisterViewController.h"

@interface WelcomeViewController () < UIPageViewControllerDataSource, UIPageViewControllerDelegate >
@property (nonatomic, strong) UIPageControl* pageControl;
@property (nonatomic, strong) UIPageViewController* pageViewController;
@property (nonatomic, strong) NSArray* dataSource;
@property (nonatomic, strong) NSArray* models;
@end

@implementation WelcomeViewController



- (void) setupUI {
    [super setupUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissController) name:@"authFinished" object:nil];
    
    if([AppConfigurator sharedInstance].isTourShowed == YES && [AppConfigurator sharedInstance].showOnlyRegister == YES) {
        [AppConfigurator sharedInstance].showOnlyRegister = NO;
        _dataSource = [NSArray arrayWithObjects:[RegisterViewController new], nil];
    }
    else {
        _dataSource = [NSArray arrayWithObjects:[WalkthroughViewController new], [WalkthroughViewController new], [WalkthroughViewController new], [WalkthroughViewController new], [RegisterViewController new], nil];
    }
    
    
    
    _models = @[ [[WelcomeTourModel alloc] initWithTitle:NSLS(@"БЫСТРАЯ ДОСТАВКА")
                                                   Image:@"welc1"
                                             Description:NSLS(@"Доставка Вашего заказа в течении\nчаса")],
                 
                 [[WelcomeTourModel alloc] initWithTitle:NSLS(@"БУКЕТЫ НА ВСЕ СОБЫТИЯ")
                                                   Image:@"welc2"
                                             Description:NSLS(@"У нас Вы сможете заказать букеты на\nвсе случаи жизни и подобрать букеты\nдля каждого")],
                 
                 [[WelcomeTourModel alloc] initWithTitle:NSLS(@"УДОБНЫЙ И БЫСТРЫЙ\nСПОСОБ ОПЛАТЫ")
                                                   Image:@"welc3"
                                             Description:NSLS(@"Оплатите заказ через ApplePay или с\nпомощью банковской карты. Все\nтранзакции защищены")],
                 
                 [[WelcomeTourModel alloc] initWithTitle:NSLS(@"ВОЗВРАТ ДЕНЕГ")
                                                   Image:@"welc4"
                                             Description:NSLS(@"Мы возвращаем деньги, если Вы не\nдовольны заказом")],
                 [[WelcomeTourModel alloc] initWithTitle:NSLS(@"")
                                                   Image:@"welc5"
                                             Description:NSLS(@"Авторизуйтесь, чтобы получить\nприятный подарок при первом заказе букета")]
                ];

    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:[NSDictionary dictionary]];
    _pageViewController.dataSource = self;
    _pageViewController.delegate = self;
  
    _pageControl = [UIPageControl new];
    
    _pageControl.currentPageIndicatorTintColor =  [UIColor colorWithRed:245.0f/255.0f green:193.0f/255.0f blue:191.0f/255.0f alpha:1.0f];
    _pageControl.pageIndicatorTintColor =  [UIColor colorWithRed:250.0f/255.0f green:228.0f/255.0f blue:229.0f/255.0f alpha:1.0f];
    
    [_pageViewController willMoveToParentViewController:self];
    [self.view addSubview:_pageViewController.view];
    [self addChildViewController:_pageViewController];
    [_pageViewController didMoveToParentViewController:self];
    
    _pageControl.numberOfPages = _dataSource.count;
    [_pageControl addTarget:self action:@selector(processChanged) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_pageControl];
    [_pageViewController setViewControllers:@[_dataSource.firstObject] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    NSInteger i = 0 ;
    
    for(WalkthroughViewController* controller in _dataSource) {
        if([controller isKindOfClass:[WalkthroughViewController class]]) {
            [controller setModel:_models[i]];
        }
        ++i;
    } 
}

- (void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _pageControl.frame = CGRectMake(0, self.view.bounds.size.height - 50, self.view.bounds.size.width, 50);
    _pageViewController.view.frame =CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - self.navigationController.navigationBar.frame.size.height);
    
//    _pageViewController.view.backgroundColor = [UIColor purpleColor];
    
    NSLog(@"%@ %@", NSStringFromCGRect(self.view.bounds), NSStringFromCGRect(self.view.frame));
//    printf(NSStringFromCGRect(self.view.bounds));

}

- (void) setupNavBar {
    [super setupNavBar];
    UIBarButtonItem *goToButton = [[UIBarButtonItem alloc] initWithTitle:NSLS(@"Пропустить")
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(dismissController)];
    
    
    NSUInteger fontSize = 14;
    UIFont *font = [UIFont boldSystemFontOfSize:fontSize];
    NSDictionary *attributes = @{NSFontAttributeName: font};
    
    [goToButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = goToButton;
}

- (void)dismissController {
    [self.pageViewController willMoveToParentViewController:nil];  // 1
    [self.pageViewController.view removeFromSuperview];
    [self.pageViewController removeFromParentViewController];
    self.pageViewController = nil;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
         [self dismissViewControllerAnimated:YES completion:nil];
    });
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController presentTransparentNavigationBar];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController hideTransparentNavigationBar];
}


- (void) processChanged {
    WalkthroughViewController* firstController = _pageViewController.viewControllers.firstObject;
    
    if([firstController isKindOfClass:[BaseViewController class]]) {
        NSInteger currentIndex = [_dataSource indexOfObject:firstController];
        
        UIPageViewControllerNavigationDirection direction =  _pageControl.currentPage >= currentIndex ? UIPageViewControllerNavigationDirectionForward : UIPageViewControllerNavigationDirectionReverse;
        
        WalkthroughViewController* nextViewController = _dataSource[_pageControl.currentPage];
        
        if([nextViewController isKindOfClass:[WalkthroughViewController class]]) {
            
            [_pageViewController setViewControllers:@[nextViewController] direction:direction animated:YES completion:nil];
        }
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [_dataSource indexOfObject:viewController];
    viewController.title = [NSString stringWithFormat:@"title %ld", (long)index];
    if(index != 0) {
        return _dataSource[index -1];
    }
    
    return nil;
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [_dataSource indexOfObject:viewController];
    viewController.title = [NSString stringWithFormat:@"title %ld", (long)index];
    if(index != _dataSource.count - 1) {
        return _dataSource[index + 1];
    }
    
  return nil;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if(pageViewController.viewControllers.count == 1) {
        if([pageViewController.viewControllers.firstObject isKindOfClass:[BaseViewController class]]) {
            NSInteger index = [_dataSource indexOfObject:pageViewController.viewControllers.firstObject];
            _pageControl.currentPage = index;

        }
    }
}
@end
