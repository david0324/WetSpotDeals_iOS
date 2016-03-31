//
//  UpcomingEventTableViewCell.h
//  wet spot deals
//
//  Created by luis alfredo rivera acuña on 24/06/15.
//  Copyright (c) 2015 luis alfredo rivera acu&#241;a. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpcomingEventTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UITextField *price;
@property (strong, nonatomic) IBOutlet UILabel *eventDate;
@property (strong, nonatomic) IBOutlet UILabel *eventAddress;
@property (strong, nonatomic) IBOutlet UILabel *desc;
- (IBAction)more_details:(id)sender;
@end
