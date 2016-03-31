//
//  Retailer.m
//  wet spot deals
//
//  Created by KOMI Marketing on 13/04/15.
//  Copyright (c) 2015 KOMI Marketing All rights reserved.
//

#import "Retailer.h"
#import "Location.h"
#import "Event.h"

@implementation Retailer

@synthesize webid;
@synthesize imagen;
@synthesize companyName;
@synthesize address;
@synthesize address2;
@synthesize city;
@synthesize states;
@synthesize zipCode;
@synthesize phone;
@synthesize url;
@synthesize email;
@synthesize zipcode;
@synthesize locations;
@synthesize events;

-(void)addLocationsObject:(Location *)object{
    [self.locations addObject:object];
    [object setRetailer:self];
}
-(void)addEventsObject:(Event *)object{
    [self.events addObject:object];
    [object setRetailer:self];
}
@end
