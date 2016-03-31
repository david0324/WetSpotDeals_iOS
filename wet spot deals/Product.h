//
//  Product.h
//  wet spot deals
//
//  Created by KOMI Marketing on 13/04/15.
//  Copyright (c) 2015 KOMI Marketing All rights reserved.
//

#import <Foundation/Foundation.h>
@class Location;
@class Review;

@interface Product : NSObject


@property (nonatomic, retain) NSString * webid;
@property (nonatomic, retain) NSString * webidProduct;
@property (nonatomic) Location * location;
@property (nonatomic, retain) NSData * imagen;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic) float  size;
@property (nonatomic, retain) NSString * unit;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * prouctType;
@property (nonatomic, retain) NSString * year;
@property (nonatomic, retain) NSString * color;
@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSString * manufacturer;
@property (nonatomic) float   regularPrice;
@property (nonatomic) float   salePrice;
@property (nonatomic) float   rate;
@property (nonatomic, retain) NSDate * saleStartDate;
@property (nonatomic, retain) NSDate * saleEndDate;

@property (nonatomic) NSMutableArray * reviews;

-(void)addReviewsObject:(Review *)object;

@end
