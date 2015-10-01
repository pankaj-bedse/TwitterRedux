//
//  LeftMenuViewController.m
//  Twitter
//
//  Created by Pankaj Bedse on 9/29/15.
//  Copyright (c) 2015 Pankaj Bedse. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "UIImageView+AFNetworking.h"
#import "User.h"
#import "MenuCell.h"

@interface LeftMenuViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *menu;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *userTagline;
@end

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    User *user = [User currentUser];
    [self.profileImage setImageWithURL:[NSURL URLWithString:user.profileImageUrl]];
    self.userName.text = user.name;
    self.userTagline.text = [NSString stringWithFormat:@"@%@", user.screenName];
    
    // Do any additional setup after loading the view from its nib.
    self.menu = [NSArray arrayWithObjects:@"Home", @"Profile", nil];//  @[@"Home", @"Profile"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MenuCell" bundle:nil]  forCellReuseIdentifier:@"menuCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed: 135.0/255.0 green: 206.0/255.0 blue:250/255.0 alpha: 1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    // show content overlapped by navbar
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
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

#pragma UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menu.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"menuCell"];
    //cell.menuIcon setImageWithURL:<#(NSURL *)#>
    [cell.menuIcon setImage:[UIImage imageNamed:self.menu[indexPath.row]]];
    cell.menuName.text = self.menu[indexPath.row];
    //cell.textLabel.text = self.menu[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected %@", self.menu[indexPath.row]);
    if ([self.delegate respondsToSelector:@selector(showMenu:)]) {
        [self.delegate showMenu:self.menu[indexPath.row]];
    }
}

@end
