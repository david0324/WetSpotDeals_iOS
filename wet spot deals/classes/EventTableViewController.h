//
//  EventTableViewController.h
//  wet spot deals
//
//  Created by luis alfredo rivera acuña on 26/06/15.
//  Copyright (c) 2015 luis alfredo rivera acu&#241;a. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import <MapKit/MapKit.h>

@interface EventTableViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UIImageView *img;

@property (strong, nonatomic) IBOutlet UILabel *textTitle;
@property (strong, nonatomic) IBOutlet UITextField *price;
@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UILabel *datetime;
@property (strong, nonatomic) IBOutlet UILabel *desc;
@property(strong,nonatomic) Event * event;

@property (strong, nonatomic) IBOutlet MKMapView *map;
- (IBAction)addCalendar:(id)sender;
@end
