//
//  Tweet.m
//  Twitter
//
//  Created by Pankaj Bedse on 9/23/15.
//  Copyright (c) 2015 Pankaj Bedse. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet
-(id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.user = [[User alloc] initWithDictionary:dictionary[@"user"]];
        self.text = dictionary[@"text"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"EEE MMM d HH:mm:ss Z y";
        self.createdAt = [formatter dateFromString:dictionary[@"created_at"]];
        self.favouritesCount = dictionary[@"favorite_count"];
        self.retweetedCount = dictionary[@"retweet_count"];
        self.tweetId = dictionary[@"id"];
        NSNumber *fav = dictionary[@"favorited"];
        self.favorited = [fav boolValue];
    }
    return self;
}

+(NSArray *)tweetsWithArray:(NSArray*)array
{
    NSMutableArray *tweets = [NSMutableArray array];
    for (NSDictionary *dictionary in array) {
        [tweets addObject:[[Tweet alloc]initWithDictionary:dictionary]];
    }
    return tweets;
}
@end
