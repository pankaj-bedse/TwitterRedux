//
//  TweetDetailViewController.m
//  Twitter
//
//  Created by Pankaj Bedse on 9/25/15.
//  Copyright (c) 2015 Pankaj Bedse. All rights reserved.
//

#import "TweetDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"

@interface TweetDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *userId;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (nonatomic, strong) Tweet *tweet;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountLable;
@property (weak, nonatomic) IBOutlet UILabel *favoritiesCountLable;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@end

@implementation TweetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Tweet";
    UIBarButtonItem *reply = [[UIBarButtonItem alloc]initWithTitle:@"Reply" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.rightBarButtonItem = reply;
    [self setupView];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;

}

-(void) setupView
{
    self.name.text = self.tweet.user.name;
    self.tweetText.text = self.tweet.text;
    self.userId.text = [NSString stringWithFormat:@"@%@", self.tweet.user.screenName];
    self.time.text = self.tweet.createdAt.description;
    [self.profileImage setImageWithURL:[NSURL URLWithString:self.tweet.user.profileImageUrl]];
    self.retweetCountLable.text = [NSString stringWithFormat:@"%@" , self.tweet.retweetedCount];
    self.favoritiesCountLable.text = [NSString stringWithFormat:@"%@" , self.tweet.favouritesCount];
    [self setFavoriteButtonBackground:self.tweet.favorited];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initializeTweet:(Tweet *)tweet
{
    self.tweet = tweet;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)addToFavorite:(id)sender {
    [[TwitterClient sharedInstance] favoritePostWithId:self.tweet.tweetId completion:^(NSDictionary *tweet, NSError *error) {
        if (tweet != nil) {
            // set image
            [self setFavoriteButtonBackground:tweet[@"favorited"]];
            self.favoritiesCountLable.text = [NSString stringWithFormat:@"%@" , tweet[@"favorite_count"]];
        } else {
            [self showAlertBoxWithTitle:@"Favorite status" msg:@"Failed to update favorite status"];
        }
    }];
}


- (IBAction)reTweet:(id)sender {
    [[TwitterClient sharedInstance] retweetPostWithId:self.tweet.tweetId completion:^(NSDictionary *tweet, NSError *error) {
        NSString *msg = @"";
        // show completion here
        if (tweet != nil) {
           msg = @"Successfully retweeted post";
            self.retweetCountLable.text = [NSString stringWithFormat:@"%@" , tweet[@"retweet_count"]];
        } else {
            msg = @"Failed to retweet";
        }
        
        [self showAlertBoxWithTitle:@"Retweet status" msg:msg];
    }];
}
- (IBAction)replyPost:(id)sender {
}

// -- helper methods
-(void)showAlertBoxWithTitle:(NSString*)title msg:(NSString *) msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:msg
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];

}

-(void) setFavoriteButtonBackground:(BOOL)favorited
{
    if (favorited) {
        UIImage *favotiteOn = [UIImage imageNamed:@"favorite_on"];
        [self.favoriteButton setBackgroundImage:favotiteOn forState:UIControlStateNormal];
        
    } else {
        UIImage *favotite = [UIImage imageNamed:@"favorite"];
        [self.favoriteButton setBackgroundImage:favotite forState:UIControlStateNormal];
    }
}
@end
