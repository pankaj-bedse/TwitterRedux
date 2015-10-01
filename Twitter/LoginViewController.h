//
//  LoginViewController.h
//  Twitter
//
//  Created by Pankaj Bedse on 9/23/15.
//  Copyright (c) 2015 Pankaj Bedse. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginDelegate <NSObject>

-(void)showLoggedinState;

@end

@interface LoginViewController : UIViewController

@property (unsafe_unretained) id<LoginDelegate> delegate;

@end
