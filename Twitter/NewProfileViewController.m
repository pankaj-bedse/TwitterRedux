//
//  NewProfileViewController.m
//  Twitter
//
//  Created by Pankaj Bedse on 10/1/15.
//  Copyright (c) 2015 Pankaj Bedse. All rights reserved.
//

#import "NewProfileViewController.h"
#import "ProfileHeaderCell.h"
#import "ProfileSubheaderCell.h"
#import "SWRevealViewController.h"

@interface NewProfileViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation NewProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tableView registerNib:[UINib nibWithNibName:@"ProfileHeaderCell" bundle:nil] forCellReuseIdentifier:@"profileHeaderCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ProfileSubheaderCell" bundle:nil] forCellReuseIdentifier:@"profileSubheaderCell"];
    self.tableView.dataSource = self;
    self.tableView.delegate= self;
    
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 173;
    }
    return 88;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ProfileHeaderCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"profileHeaderCell"];
        [cell setCellWithUser:[User currentUser]];
        return cell;
    }
    ProfileSubheaderCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"profileSubheaderCell"];
    [cell setCellWithUser:[User currentUser]];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // setup initial state (e.g. before animation)
    cell.layer.shadowColor = [[UIColor blackColor] CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    cell.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5);
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    // define final state (e.g. after animation) & commit animation
    [UIView beginAnimations:@"scaleTableViewCellAnimationID" context:NULL];
    [UIView setAnimationDuration:0.7];
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    cell.alpha = 1;
    cell.layer.transform = CATransform3DIdentity;
    [UIView commitAnimations];
}
@end
