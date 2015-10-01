//
//  ProfileSubheaderCell.h
//  Twitter
//
//  Created by Pankaj Bedse on 10/1/15.
//  Copyright (c) 2015 Pankaj Bedse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ProfileSubheaderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *tweetsNum;
@property (weak, nonatomic) IBOutlet UILabel *followersNum;

@property (weak, nonatomic) IBOutlet UILabel *followingNum;
-(void)setCellWithUser:(User *)user;
@end
