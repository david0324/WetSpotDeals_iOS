//
//  ItemTableViewCell.m
//  wet spot deals
//
//  Created by KOMI Marketing on 30/03/15.
//  Copyright (c) 2015 KOMI Marketing All rights reserved.
//

#import "ItemTableViewCell.h"

@implementation ItemTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setRate:(float)rate{
    UIImage * enableStar = [UIImage imageNamed:@"star_enable_item_wetspotdepot.png"];
    UIImage * disableStar = [UIImage imageNamed:@"star_disable_item_wetspotdepot.png"];

    for (id star in _stars) {
        [star setImage:disableStar];
    }
    
    if (rate >= 1) {
        [[_stars objectAtIndex:0] setImage:enableStar];
    }
    if (rate >= 2) {
        [[_stars objectAtIndex:1] setImage:enableStar];
    }
    if (rate >= 3) {
        [[_stars objectAtIndex:2] setImage:enableStar];
    }
    if (rate >= 4) {
        [[_stars objectAtIndex:3] setImage:enableStar];
    }
    if (rate >= 5) {
        [[_stars objectAtIndex:4] setImage:enableStar];
    }
//    NSLog(@"%@",[NSString stringWithFormat:@"%.2f",rate]);
    _rating.text = [NSString stringWithFormat:@"%.1f",rate];
}

@end
