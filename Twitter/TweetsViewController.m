//
//  TweetsViewController.m
//  Twitter
//
//  Created by Pankaj Bedse on 9/23/15.
//  Copyright (c) 2015 Pankaj Bedse. All rights reserved.
//

#import "TweetsViewController.h"
#import "User.h"
#import "TwitterClient.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "NewTweetViewController.h"
#import "TweetDetailViewController.h"
#import "SWRevealViewController.h"

@interface TweetsViewController () <UITableViewDataSource, UITableViewDelegate, NewTweetDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray * tweets;

@end

@implementation TweetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[TwitterClient sharedInstance] homeTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        for (Tweet* tweet in tweets) {
            NSLog(@"Tweets %@", tweet.text);
            
            
        }
        self.tweets = tweets;
        [self.tableView reloadData];
    }];
    [self configureNavbar];
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetCell" bundle:nil] forCellReuseIdentifier:@"tweetCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 113;
    UIRefreshControl *rc = [[UIRefreshControl alloc]init];
    //[rc addTarget:self action:@selector(refreshTweets) forControlEvents:UIControlEventValueChanged];
    [rc addTarget:self action:@selector(refreshTweets:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:rc];
    //self.tableView
    SWRevealViewController *revealController = [self revealViewController];
    
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
}

- (void)configureNavbar
{
    self.title = @"Home";
    UIBarButtonItem *logout = [[UIBarButtonItem alloc]initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(onLogout:)];
    self.navigationItem.leftBarButtonItem = logout;
    UIBarButtonItem *new = [[UIBarButtonItem alloc]initWithTitle:@"New" style:UIBarButtonItemStylePlain target:self action:@selector(newTweet)];
    self.navigationItem.rightBarButtonItem = new;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed: 135.0/255.0 green: 206.0/255.0 blue:250/255.0 alpha: 1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onLogout:(id)sender {
    [User logout];
}

-(void)newTweet
{
    NewTweetViewController *newTweet = [[NewTweetViewController alloc] init];
    newTweet.delegate = self;
    //[self showViewController:newTweet sender:self];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:newTweet];
    [self presentViewController:nvc animated:YES completion:nil];
}

#pragma makr - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tweets.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tweetCell"];
    Tweet *tweet = self.tweets[indexPath.row];
    User *user = tweet.user;
    cell.tweetText.text = [self.tweets[indexPath.row] text];
    cell.userId.text = [NSString stringWithFormat:@"@%@", user.screenName];
    cell.userName.text = user.name;
    [cell.profileImage setImageWithURL:[NSURL URLWithString:user.profileImageUrl]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"M/d/yy";
    cell.timeText.text = [formatter stringFromDate:tweet.createdAt];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TweetDetailViewController *tdc = [[TweetDetailViewController alloc]init];
    [tdc initializeTweet:self.tweets[indexPath.row]];
    [self.navigationController pushViewController:tdc animated:YES];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //1. Setup the CATransform3D structure
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
    rotation.m34 = 1.0/ -600;
    
    
    //2. Define the initial state (Before the animation)
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    
    cell.layer.transform = rotation;
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    
    //3. Define the final state (After the animation) and commit the animation
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.4];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
    
}



- (void)refreshTweets:(UIRefreshControl *)refreshControl
{
    [[TwitterClient sharedInstance] homeTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        for (Tweet* tweet in tweets) {
            NSLog(@"Tweets %@", tweet.text);
            
            
        }
        self.tweets = tweets;
        
        [self.tableView reloadData];
        [refreshControl endRefreshing];
    }];
}

// handle selection with
// TweetDetailViewController *tweetDetail = [[TweetDetailViewController alloc] init];
// [self showViewController:tweetDetail sender:self];
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)fetchTweets
{
    [[TwitterClient sharedInstance] homeTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        for (Tweet* tweet in tweets) {
            NSLog(@"Tweets %@", tweet.text);
            
            
        }
        self.tweets = tweets;
        [self.tableView reloadData];
    }];
}
#pragma NewTweetDelegate
-(void)newTweet:(NSString *)tweetText
{
    NSLog(@"Inside TweetsViewController now create new tweet with this text %@", tweetText);
    NSDictionary *param = @{@"status":tweetText};
    //[param setValue:tweetText forKey:@"status"];
    [[TwitterClient sharedInstance] createTweetWithParams:param completion:^(NSDictionary *reply, NSError *error) {
        NSLog(@"response %@", reply);
        [self fetchTweets];
    }];
}
@end
