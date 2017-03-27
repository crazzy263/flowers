//
//  BaseTableViewController.h
//  flowers
//
//  Created by Crazzy on 26.03.17.
//  Copyright © 2017 Maksim Kis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewController : UITableViewController

- (void) showMessage:(NSString*)message withTitle:(NSString *)title;

- (void) setupNavBar;

- (void) setupUI;
    
@end
