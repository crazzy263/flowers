//
//  WelcomeTourModel.h
//  flowers
//
//  Created by iOS Developer on 28.04.17.
//  Copyright © 2017 Maksim Kis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WelcomeTourModel : NSObject


@property (nonatomic, copy) NSString* imageHolder;
@property (nonatomic, copy) NSString* titleHolder;
@property (nonatomic, copy) NSString* descriptionHolder;

- (instancetype) initWithTitle : (NSString*) text Image : (NSString*) image Description : (NSString*) description;
                                                                                                                  
@end
