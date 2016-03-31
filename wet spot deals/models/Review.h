//
//  Review.h
//  wet spot deals
//
//  Created by KOMI Marketing on 05/05/15.
//  Copyright (c) 2015 KOMI Marketing All rights reserved.
//

#import <Foundation/Foundation.h>
@class Product;
@interface Review : NSObject

@property (nonatomic, retain) NSString * webid;
@property (nonatomic) Product * product;
@property (nonatomic, retain) NSString * user_name;
@property (nonatomic, retain) NSString * tagline;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic) float   rate;
@property (nonatomic, retain) NSString * userFacebookId;
@property (nonatomic, retain) NSDate  * date;


@end
