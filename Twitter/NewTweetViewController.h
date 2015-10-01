//
//  NewTweetViewController.h
//  Twitter
//
//  Created by Pankaj Bedse on 9/25/15.
//  Copyright (c) 2015 Pankaj Bedse. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewTweetDelegate <NSObject>

-(void)newTweet:(NSString *)tweetText;

@end

@interface NewTweetViewController : UIViewController
@property (unsafe_unretained) id <NewTweetDelegate> delegate;

@end
