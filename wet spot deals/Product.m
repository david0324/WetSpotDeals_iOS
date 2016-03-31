//
//  Product.m
//  wet spot deals
//
//  Created by KOMI Marketing on 13/04/15.
//  Copyright (c) 2015 KOMI Marketing All rights reserved.
//

#import "Product.h"
#import "Location.h"
#import "Review.h"


@implementation Product

@synthesize webid;
@synthesize webidProduct;
@synthesize location;
@synthesize imagen;
@synthesize name;
@synthesize description;
@synthesize size;
@synthesize unit;
@synthesize country;
@synthesize prouctType;
@synthesize year;
@synthesize color;
@synthesize category;
@synthesize manufacturer;
@synthesize regularPrice;
@synthesize salePrice;
@synthesize saleStartDate;
@synthesize saleEndDate;
@synthesize rate;
@synthesize reviews;


-(void)addReviewsObject:(Review *)object{
    if (!self.reviews) {
        self.reviews = [[NSMutableArray alloc] init];
    }
    [self.reviews addObject:object];
    [object setProduct:self];
}
@end
