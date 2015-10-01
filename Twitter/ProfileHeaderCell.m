//
//  ProfileHeaderCell.m
//  Twitter
//
//  Created by Pankaj Bedse on 10/1/15.
//  Copyright (c) 2015 Pankaj Bedse. All rights reserved.
//

#import "ProfileHeaderCell.h"
#import "UIImageView+AFNetworking.h"

@implementation ProfileHeaderCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellWithUser:(User *)user
{
    [self.profileBgImage setImageWithURL:[NSURL URLWithString:user.profileBackgroundImageUrl]];
    [self.profileImage setImageWithURL:[NSURL URLWithString:user.profileImageUrl]];
    self.name.text = user.name;
    self.screenName.text = [NSString stringWithFormat:@"@%@", user.screenName];
}
@end
