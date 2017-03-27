//
//  View.h
//  flowers
//
//  Created by iOS Developer on 27.03.17.
//  Copyright © 2017 Maksim Kis. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ViewProtocol <NSObject>
- (void)commonInit;
@end

@interface BaseView : UIView <ViewProtocol>

@end
