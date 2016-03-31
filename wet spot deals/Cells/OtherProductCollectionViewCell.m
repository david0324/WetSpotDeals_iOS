//
//  OtherProductCollectionViewCell.m
//  wet spot deals
//
//  Created by KOMI Marketing on 24/04/15.
//  Copyright (c) 2015 KOMI Marketing All rights reserved.
//

#import "OtherProductCollectionViewCell.h"

@implementation OtherProductCollectionViewCell


-(void) setRate:(float)rate{
    UIImage * enableStar = [UIImage imageNamed:@"star_enable_item_wetspotdepot.png"];
    UIImage * disableStar = [UIImage imageNamed:@"star_disable_item_wetspotdepot.png"];
    
    for (id star in _star) {
        [star setImage:disableStar];
    }
    
    if (rate >= 1) {
        [[_star objectAtIndex:0] setImage:enableStar];
    }
    if (rate >= 2) {
        [[_star objectAtIndex:1] setImage:enableStar];
    }
    if (rate >= 3) {
        [[_star objectAtIndex:2] setImage:enableStar];
    }
    if (rate >= 4) {
        [[_star objectAtIndex:3] setImage:enableStar];
    }
    if (rate >= 5) {
        [[_star objectAtIndex:4] setImage:enableStar];
    }
    //    NSLog(@"%@",[NSString stringWithFormat:@"%.2f",rate]);
//    _rating.text = [NSString stringWithFormat:@"%.1f",rate];
}



@end
