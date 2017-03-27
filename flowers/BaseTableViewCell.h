//
//  BaseTableViewCell.h
//  flowers
//
//  Created by Crazzy on 26.03.17.
//  Copyright © 2017 Maksim Kis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell

- (void)commonInit;
+ (NSString *)cellIdentifier;

@end
