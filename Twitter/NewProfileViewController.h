//
//  NewProfileViewController.h
//  Twitter
//
//  Created by Pankaj Bedse on 10/1/15.
//  Copyright (c) 2015 Pankaj Bedse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface NewProfileViewController : UIViewController
-(void)initializeWithUser:(User *)user;
@property (nonatomic, assign) BOOL modalDialog;
@end
