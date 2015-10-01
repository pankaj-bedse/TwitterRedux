//
//  User.m
//  Twitter
//
//  Created by Pankaj Bedse on 9/23/15.
//  Copyright (c) 2015 Pankaj Bedse. All rights reserved.
//

#import "User.h"
#import "TwitterClient.h"

NSString * const UserDidLoginNotification = @"UserDidLoginNotification";
NSString * const UserDidLogoutNotification = @"UserDidLogoutNotification";
@interface User()
@property (nonatomic,strong) NSDictionary *dictionary;
@end

@implementation User
-(id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.dictionary = dictionary;
        self.name = dictionary[@"name"];
        self.profileImageUrl = dictionary[@"profile_image_url"];
        self.screenName = dictionary[@"screen_name"];
        self.tagline = dictionary[@"description"];
        self.tweetsCount = [dictionary[@"statuses_count"] integerValue];
        self.followingCount = [dictionary[@"friends_count"] integerValue];
        self.follwersCount = [dictionary[@"followers_count"] integerValue];
        self.profileBackgroundImageUrl = dictionary[@"profile_background_image_url"];
    }
    return self;
}

static User *_currentUser = nil;
NSString const *kCurrentUserKey = @"kCurrentUserKey";

+(User*)currentUser
{
    if (_currentUser == nil) {
        NSData *data = [[NSUserDefaults standardUserDefaults]objectForKey:kCurrentUserKey];
        if (data != nil) {
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            _currentUser = [[User alloc]initWithDictionary:dictionary];
        }
    }
    return _currentUser;
}
+(void)setCurrentUser:(User*)currentUser
{
    _currentUser = currentUser;
    if (_currentUser != nil) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:currentUser.dictionary options:0 error:NULL];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:kCurrentUserKey];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kCurrentUserKey];
    }
    [[NSUserDefaults standardUserDefaults]synchronize];
}
+(void)logout
{
    [User setCurrentUser:nil];
    [[TwitterClient sharedInstance].requestSerializer removeAccessToken];
    [[NSNotificationCenter defaultCenter] postNotificationName:UserDidLogoutNotification object:nil];
}
@end
