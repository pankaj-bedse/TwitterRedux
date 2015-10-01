//
//  NewTweetViewController.m
//  Twitter
//
//  Created by Pankaj Bedse on 9/25/15.
//  Copyright (c) 2015 Pankaj Bedse. All rights reserved.
//

#import "NewTweetViewController.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"

@interface NewTweetViewController () <UITextViewDelegate>
//@property (nonatomic, strong) User *currentUser;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UITextView *tweetText;
@end

@implementation NewTweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(dismissDialog)];
    self.navigationItem.leftBarButtonItem = cancel;
    UIBarButtonItem *tweet = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(postTweet)];
    self.navigationItem.rightBarButtonItem = tweet;
    [self setupViewWithUserInfo];
    self.tweetText.delegate = self;
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
}

-(void) setupViewWithUserInfo
{
    User *currentUser = [User currentUser];
    [self.profileImage setImageWithURL:[NSURL URLWithString:currentUser.profileImageUrl]];
    self.name.text = currentUser.screenName;
    self.userName.text = currentUser.name;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)postTweet
{
    if ([self.delegate respondsToSelector:@selector(newTweet:)]) {
        if (self.tweetText.text.length > 0) {
            [self.delegate newTweet:self.tweetText.text];
        }
    }
    [self dismissDialog];
}
- (void)dismissDialog
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return textView.text.length + (text.length - range.length) <= 140;
    
}
@end
