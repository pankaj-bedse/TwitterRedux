//
//  User.h
//  Twitter
//
//  Created by Pankaj Bedse on 9/23/15.
//  Copyright (c) 2015 Pankaj Bedse. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const UserDidLoginNotification;
extern NSString * const UserDidLogoutNotification;

@interface User : NSObject
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *profileImageUrl;
@property (nonatomic, strong) NSString *profileBackgroundImageUrl;
@property (nonatomic, strong) NSString *tagline;
@property (nonatomic, assign) NSInteger tweetsCount;
@property (nonatomic, assign) NSInteger follwersCount;
@property (nonatomic, assign) NSInteger followingCount;

-(id)initWithDictionary:(NSDictionary*)dictionary;

+(User*)currentUser;
+(void)setCurrentUser:(User*)currentUser;
+(void)logout;
@end
