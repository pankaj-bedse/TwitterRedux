//
//  TweetCell.m
//  Twitter
//
//  Created by Pankaj Bedse on 9/25/15.
//  Copyright (c) 2015 Pankaj Bedse. All rights reserved.
//

#import "TweetCell.h"

@implementation TweetCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)showProfile:(id)sender {
    NSLog(@"image tabbed");
}
@end
