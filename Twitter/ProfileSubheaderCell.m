//
//  ProfileSubheaderCell.m
//  Twitter
//
//  Created by Pankaj Bedse on 10/1/15.
//  Copyright (c) 2015 Pankaj Bedse. All rights reserved.
//

#import "ProfileSubheaderCell.h"

@implementation ProfileSubheaderCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setCellWithUser:(User *)user
{
    self.tweetsNum.text = [NSString stringWithFormat:@"%ld", user.tweetsCount];
    self.followersNum.text = [NSString stringWithFormat:@"%ld", user.follwersCount];
    self.followingNum.text = [NSString stringWithFormat:@"%ld", user.followingCount];
}
@end
