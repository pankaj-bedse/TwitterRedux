//
//  ProfileViewController.m
//  Twitter
//
//  Created by Pankaj Bedse on 9/29/15.
//  Copyright (c) 2015 Pankaj Bedse. All rights reserved.
//

#import "ProfileViewController.h"
#import "SWRevealViewController.h"
#import "UIImageView+AFNetworking.h"
#import "User.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *tweetsCount;
@property (weak, nonatomic) IBOutlet UILabel *followingCount;
@property (weak, nonatomic) IBOutlet UILabel *followersCount;
@property (weak, nonatomic) IBOutlet UIImageView *profileBgImage;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    User *user = [User currentUser];
    // Do any additional setup after loading the view from its nib.
    [self.profileImage setImageWithURL:[NSURL URLWithString:user.profileImageUrl]];
    self.tweetsCount.text = [NSString stringWithFormat:@"%ld",(long)user.tweetsCount];
    self.followersCount.text = [NSString stringWithFormat:@"%ld", (long)user.follwersCount];
    self.followingCount.text = [NSString stringWithFormat:@"%ld", (long)user.followingCount];
    [self.profileBgImage setImageWithURL:[NSURL URLWithString:user.profileBackgroundImageUrl]];
    
    SWRevealViewController *revealController = [self revealViewController];
    
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    // show content overlapped by navbar
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    // Navbar setup
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed: 135.0/255.0 green: 206.0/255.0 blue:250/255.0 alpha: 1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.title = @"Me";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
