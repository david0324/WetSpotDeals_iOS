//
//  DetailLocationTableViewCell.h
//  wet spot deals
//
//  Created by luis alfredo rivera acuña on 24/06/15.
//  Copyright (c) 2015 luis alfredo rivera acu&#241;a. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailLocationTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *detail;
@property (strong, nonatomic) IBOutlet UILabel *phone;
@property (strong, nonatomic) IBOutlet UILabel *webpage;
@property (strong, nonatomic) IBOutlet UIImageView *phoneImg;
@property (strong, nonatomic) IBOutlet UIImageView *webpageImg;
@end
