//
//  TwitterClient.h
//  Twitter
//
//  Created by Pankaj Bedse on 9/23/15.
//  Copyright (c) 2015 Pankaj Bedse. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "User.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager
+(TwitterClient *)sharedInstance;
-(void)loginWithCompletion:(void (^)(User* user, NSError *error))completion;
-(void)openURL:(NSURL*)url;
-(void)homeTimelineWithParams:(NSDictionary *)params completion:(void(^)(NSArray *tweets, NSError *error))completion;
-(void)createTweetWithParams:(NSDictionary *)params completion:(void(^)(NSDictionary *reply, NSError *error))completion;
-(void)retweetPostWithId:(NSString *)tweetId completion:(void(^)(NSDictionary *tweet, NSError *error))completion;
-(void)favoritePostWithId:(NSString *)tweetId completion:(void (^)(NSDictionary *tweet, NSError *error)) completion;
@end
