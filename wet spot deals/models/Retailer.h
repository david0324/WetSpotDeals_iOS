//
//  Retailer.h
//  wet spot deals
//
//  Created by KOMI Marketing on 13/04/15.
//  Copyright (c) 2015 KOMI Marketing All rights reserved.
//

#import <Foundation/Foundation.h>
@class Location;
@class Event;

@interface Retailer : NSObject


@property (nonatomic, retain) NSString * webid;
@property (nonatomic) NSMutableArray * locations;
@property (nonatomic) NSMutableArray * events;

@property (nonatomic, retain) NSData * imagen;
@property (nonatomic, retain) NSString * companyName;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * address2;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * states;
@property (nonatomic, retain) NSString * zipCode;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * zipcode;


-(void)addLocationsObject:(Location *)object;
-(void)addEventsObject:(Event *)object;
@end
