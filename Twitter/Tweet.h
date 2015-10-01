//
//  Tweet.h
//  Twitter
//
//  Created by Pankaj Bedse on 9/23/15.
//  Copyright (c) 2015 Pankaj Bedse. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject
@property (nonatomic, strong) User *user;
@property (nonatomic ,strong) NSDate *createdAt;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *favouritesCount;
@property (nonatomic, strong) NSString *retweetedCount;
@property (nonatomic, strong) NSString *tweetId;
@property (nonatomic,assign) BOOL favorited;

-(id)initWithDictionary:(NSDictionary *)dictionary;
+(NSArray *)tweetsWithArray:(NSArray*)array;
@end
