//
//  LeftMenuViewController.h
//  Twitter
//
//  Created by Pankaj Bedse on 9/29/15.
//  Copyright (c) 2015 Pankaj Bedse. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LeftMenuDelegate <NSObject>

-(void)showMenu:(NSString *)menu;

@end

@interface LeftMenuViewController : UIViewController
@property (unsafe_unretained) id <LeftMenuDelegate> delegate;
@end
