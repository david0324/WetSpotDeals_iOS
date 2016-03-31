//
//  Location.h
//  wet spot deals
//
//  Created by KOMI Marketing on 13/04/15.
//  Copyright (c) 2015 KOMI Marketing All rights reserved.
//

#import <Foundation/Foundation.h>
@class Retailer;
@class Product;

@interface Location : NSObject

@property (nonatomic, retain) NSString * webid;
@property (nonatomic) Retailer * retailer;
@property (nonatomic) NSMutableArray * products;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic) float latitude;
@property (nonatomic) float longitude;

-(void)addProductsObject:(Product *)object;
-(NSMutableArray*)getProductsWithout:(Product*)product;

@end
