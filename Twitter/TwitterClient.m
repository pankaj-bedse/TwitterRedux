//
//  TwitterClient.m
//  Twitter
//
//  Created by Pankaj Bedse on 9/23/15.
//  Copyright (c) 2015 Pankaj Bedse. All rights reserved.
//

#import "TwitterClient.h"
#import "Tweet.h"
#import "User.h"

NSString * const kTwitterConsumerKey = @"TAOaBk3dDCXryjerQ2n2IdnbZ";
NSString * const kTwitterSecretKey = @"atuMWZyVYli7kXmKetKdMROTMVcFBkUpv270YEt6FOnmiq1cgm";
NSString * const kTwitterBaseUrl = @"https://api.twitter.com";

@interface TwitterClient()
@property (nonatomic, strong) void (^loginCompletion)(User* user, NSError *error);
@property (nonatomic, strong) User *user;
@end
@implementation TwitterClient
+(TwitterClient *)sharedInstance
{
    static TwitterClient *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:kTwitterBaseUrl] consumerKey:kTwitterConsumerKey consumerSecret:kTwitterSecretKey];
        }
    });
    return instance;
}
-(void)loginWithCompletion:(void (^)(User* user, NSError *error))completion
{
    self.loginCompletion = completion;
    [self.requestSerializer removeAccessToken];
    [self fetchRequestTokenWithPath:@"oauth/request_token" method:@"GET" callbackURL:[NSURL URLWithString:@"cptwitterdemo://oauth"] scope:nil success:^(BDBOAuth1Credential *requestToken) {
        NSLog(@"Got request token");
        NSURL *authUrl = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token]];
        [[UIApplication sharedApplication] openURL:authUrl];
    } failure:^(NSError *error) {
        NSLog(@"filed to get request token");
        self.loginCompletion(nil, error);
    }];
}

-(void)openURL:(NSURL *)url
{
    
    [self fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:[[BDBOAuth1Credential alloc] initWithQueryString:url.query] success:^(BDBOAuth1Credential *accessToken) {
        NSLog(@"Got access token");
        [self.requestSerializer saveAccessToken:accessToken];
        [self GET:@"1.1/account/verify_credentials.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            User *user = [[User alloc] initWithDictionary:responseObject];
            NSLog(@"User %@", responseObject);
            [User setCurrentUser:user];
            self.loginCompletion(user, nil);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Failed to get user verified");
            self.loginCompletion(nil, error);
        }];
//        [self GET:@"1.1/statuses/home_timeline.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            //NSLog(@"Twitts:%@", responseObject);
//            NSArray *tweets = [Tweet tweetsWithArray:responseObject];
//            for (Tweet *tweet in tweets) {
//                NSLog(@"Tweets text : %@ created At: %@", tweet.text, tweet.createdAt);
//            }
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            NSLog(@"Failed to get Twitts");
//        }];
    } failure:^(NSError *error) {
        NSLog(@"failed to get access token");
    }];

}

-(void)homeTimelineWithParams:(NSDictionary *)params completion:(void(^)(NSArray *tweets, NSError *error))completion
{
    [self GET:@"1.1/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *tweets = [Tweet tweetsWithArray:responseObject];
        completion(tweets, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
}

+(void)logout
{
    
}
-(void)createTweetWithParams:(NSDictionary *)params completion:(void (^)(NSDictionary *, NSError *))completion
{
    [self POST:@"1.1/statuses/update.json" parameters:params constructingBodyWithBlock:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completion(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
}
-(void)retweetPostWithId:(NSString *)tweetId completion:(void (^)(NSDictionary *, NSError *))completion
{
    NSString *postUrl = [NSString stringWithFormat:@"1.1/statuses/retweet/%@.json", tweetId];
    [self POST:postUrl parameters:nil constructingBodyWithBlock:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completion(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
}
-(void)favoritePostWithId:(NSString *)tweetId completion:(void (^)(NSDictionary *, NSError *))completion
{
    NSString *postUrl = [ NSString stringWithFormat:@"1.1/favorites/create.json?id=%@", tweetId];
    [self POST:postUrl parameters:nil constructingBodyWithBlock:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completion(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
}
@end
