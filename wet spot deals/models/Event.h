//
//  Event.h
//  wet spot deals
//
//  Created by luis alfredo rivera acuña on 25/06/15.
//  Copyright (c) 2015 luis alfredo rivera acu&#241;a. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Retailer;

@interface Event : NSObject

@property (nonatomic, retain) NSString * webid;
@property (nonatomic, retain) NSString * locationWebid;
@property (nonatomic) Retailer * retailer;
@property (nonatomic, retain) NSData * imagen;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * description;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * address2;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * states;
@property (nonatomic, retain) NSString * zipCode;
@property (nonatomic) float cost;
@property (nonatomic) float latitude;
@property (nonatomic) float longitude;

@end
