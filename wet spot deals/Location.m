//
//  Location.m
//  wet spot deals
//
//  Created by KOMI Marketing on 13/04/15.
//  Copyright (c) 2015 KOMI Marketing All rights reserved.
//

#import "Location.h"
#import "Product.h"


@implementation Location

@synthesize webid;
@synthesize retailer;
@synthesize name;
@synthesize phone;
@synthesize desc;
@synthesize latitude;
@synthesize longitude;
@synthesize products;

-(void)addProductsObject:(Product *)object{
    [self.products addObject:object];
    [object setLocation:self];
}

-(NSMutableArray*)getProductsWithout:(Product*)product{
    NSMutableArray * prods = [[NSMutableArray alloc]init];
    
    for (Product *prod in self.products) {
        if (![prod isEqual:product]) {
            [prods addObject:prod];
        }
    }
    
    return prods;
}

@end
