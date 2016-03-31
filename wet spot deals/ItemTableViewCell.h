//
//  ItemTableViewCell.h
//  wet spot deals
//
//  Created by KOMI Marketing on 30/03/15.
//  Copyright (c) 2015 KOMI Marketing All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *subTitle;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *stars;
@property (strong, nonatomic) IBOutlet UITextField *rating;
@property (strong, nonatomic) IBOutlet UIImageView *logo;

-(void) setRate:(float)rate;

@end
