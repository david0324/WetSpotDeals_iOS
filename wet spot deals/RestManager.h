//
//  RestManager.h
//  PoliticosIos
//
//  Created by KOMI Marketing on 27/03/15.
//  Copyright (c) 2015 KOMI Marketing All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"
#import "Review.h"
#import "Event.h"

@interface RestManager : NSObject
+ (void)updateProductsWhitLatitude:(float)latitude
                         longitude:(float)longitude
                          CallBack:(void (^)(NSArray* locations,NSArray* wineProducts,NSArray* beerProducts,NSArray* liquorProducts))callbackBlock;
+ (void)getHomeEventsWhitLatitude:(float)latitude
                         longitude:(float)longitude
                          CallBack:(void (^)(Event* event1,Event* event2))callbackBlock;


+ (void)getProductsWhitId:(int)product_id
                          CallBack:(void (^)(Product *product))callbackBlock;

+(void)sendReviewWithUser_name:(NSString*)user_name
                       Tagline:(NSString*)tagline
                          Rate:(float)rate
                     Inventory:(int)inventory
                UserFacebookId:(NSString*)userFacebookId
                   Description:(NSString*)description
                      CallBack:(void (^)(Review *newReview))callbackBlock;


@end
