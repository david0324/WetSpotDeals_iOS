//
//  EventTableViewController.m
//  wet spot deals
//
//  Created by luis alfredo rivera acuña on 26/06/15.
//  Copyright (c) 2015 luis alfredo rivera acu&#241;a. All rights reserved.
//

#import "EventTableViewController.h"
#import <EventKit/EventKit.h>

@interface EventTableViewController ()

@end

@implementation EventTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIImage * image = [UIImage imageWithData:_event.imagen];
    [_img setImage:image];
    _textTitle.text = _event.name;
    if (_event.cost == 0) {
        _price.text = @"free";
    }else{
        _price.text = [NSString stringWithFormat:@"$%.2f",_event.cost];
    }
    
    NSDateFormatter *aDateFormatter = [[NSDateFormatter alloc] init];
    aDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    _datetime.text = [aDateFormatter stringFromDate:_event.time];
    _address.text = _event.address;
    _desc.text = _event.description;
    
    CLLocation * cccc = [[CLLocation alloc]initWithLatitude: _event.latitude longitude: _event.longitude];
    
    MKPointAnnotation* annotation= [MKPointAnnotation new];
    annotation.coordinate= [cccc coordinate];
    [_map addAnnotation: annotation];
    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.005;
    span.longitudeDelta = 0.005;
    CLLocationCoordinate2D location;
    location.latitude = _event.latitude;
    location.longitude = _event.longitude;
    region.span = span;
    region.center = location;
    [_map setRegion:region animated:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)addCalendar:(id)sender {
    
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)])
    {
        // the selector is available, so we must be on iOS 6 or newer
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error)
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Event"
                                                                    message:@"Some error has occurred."
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                    [alert show];
                }
                else if (!granted)
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Event"
                                                                    message:@"We dont have permission to write in your calendar."
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                    [alert show];
                }
                else
                {
                    EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
                    event.title     = _event.name;
                    event.notes     = _event.description;
                    event.startDate = _event.time;
                    event.endDate   = _event.time;
                    
                    [event setCalendar:[eventStore defaultCalendarForNewEvents]];
                    NSError *err;
                    [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Event"
                                                                    message:@"The event has being added to your calendar."
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                    [alert show];
                    
                }
            });
        }];
    }
    else
    {
        // this code runs in iOS 4 or iOS 5
        // ***** do the important stuff here *****
    }
    
//    [eventStore release];

    
    
    
    
}
@end
