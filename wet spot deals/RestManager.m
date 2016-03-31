//
//  RestManager.m
//  PoliticosIos
//
//  Created by KOMI Marketing on 27/03/15.
//  Copyright (c) 2015 KOMI Marketing. All rights reserved.
//

#import "RestManager.h"

#import "AFHTTPRequestOperationManager.h"
#import "CoreDataManager.h"
#import "Constants.h"

#import "Retailer.h"
#import "Location.h"
#import "Product.h"
#import "Review.h"
#import "Event.h"

@implementation RestManager


+ (void)getHomeEventsWhitLatitude:(float)latitude
                        longitude:(float)longitude
                         CallBack:(void (^)(Event* event1,Event* event2))callbackBlock{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    NSDictionary *parameters = @{
                                 @"latitude": [NSString stringWithFormat:@"%f",latitude],
                                 @"longitude": [NSString stringWithFormat:@"%f",longitude]
                                 };
    NSString *urlJson = [NSString stringWithFormat:@"%@/%@/",urlServer,jsonRandomReviews];
    
    [manager GET:urlJson parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        int count = 0;
        
        Event* event1= nil;
        Event* event2= nil;
        for (id event in responseObject) {
            //             NSLog(@"JSON: %@", resp);
            
            NSString *webid =event[@"id"];
            NSString *retailer =event[@"retailer"];
            NSString *imagen =event[@"imagen"];
            NSString *name =event[@"name"];
            NSString *description =event[@"description"];
            NSString *date =event[@"date"];
            NSString *time =event[@"time"];
            NSString *address =event[@"address"];
            NSString *address2 =event[@"address2"];
            NSString *city =event[@"city"];
            NSString *states =event[@"states"];
            NSString *zipCode =event[@"zipCode"];
            NSString *cost =event[@"cost"];
            
            float latitudeEvent =[event[@"latitude"] floatValue];
            float longitudeEvent =[event[@"longitude"] floatValue];
            
            Event * ev = [[Event alloc] init];
            [ev setWebid:webid];
            [ev setName:name];
            [ev setDescription:description];
            
            if ((NSNull *)imagen != [NSNull null]) {
                NSURL * imageURL = [NSURL URLWithString:imagen];
                NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
                [ev setImagen:imageData];
            }
            
            NSDateFormatter *aDateFormatter = [[NSDateFormatter alloc] init];
            aDateFormatter.dateFormat = @"yyyy-MM-dd";
            NSDate *dDate = [aDateFormatter dateFromString:date];
            [ev setDate:dDate];
            aDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            NSDate *dTime = [aDateFormatter dateFromString:[NSString stringWithFormat:@"%@ %@",date,time]];
            [ev setTime:dTime];
            
            [ev setAddress:address];
            [ev setAddress2:address2];
            [ev setCity:city];
            [ev setStates:states];
            [ev setZipCode:zipCode];
            float fCost =[cost floatValue];
            [ev setCost:fCost];
            [ev setLatitude:latitudeEvent];
            [ev setLongitude:longitudeEvent];
            [ev setLocationWebid:retailer];
           
            
            if (count == 0) {
                event1 = ev;
                count = 1;
            }else{
                event2 = ev;
            }
            
            
        }
        callbackBlock(event1,event2);
            
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"There has been an error with the network."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        callbackBlock(nil,nil);
        
        NSLog(@"%@",error.description);
        
    }];
    
    
}

+ (void)updateProductsWhitLatitude:(float)latitude
                         longitude:(float)longitude
                          CallBack:(void (^)(NSArray* locations,NSArray* wineProducts,NSArray* beerProducts,NSArray* liquorProducts))callbackBlock{
    
    NSMutableArray *_locations = [[NSMutableArray alloc] init];
    NSMutableArray *_wineProducts = [[NSMutableArray alloc] init];
    NSMutableArray *_beerProducts = [[NSMutableArray alloc] init];
    NSMutableArray *_liquorProducts = [[NSMutableArray alloc] init];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    NSDictionary *parameters = @{
                                 @"latitude": [NSString stringWithFormat:@"%f",latitude],
                                 @"longitude": [NSString stringWithFormat:@"%f",longitude]
                                 };
    NSString *urlJson = [NSString stringWithFormat:@"%@/%@/",urlServer,jsonLocation];
    
    [manager GET:urlJson parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        
        for (id resp in responseObject) {
            //             NSLog(@"JSON: %@", resp);
            
            NSString *imagen =resp[@"retailer"][@"imagen"];
            NSString *idRet =resp[@"retailer"][@"id"];
            Retailer * retailer;
            
            
            retailer = [dic objectForKey:idRet];
            
            if (!retailer){
                retailer = [[Retailer alloc] init];
                if ((NSNull *)imagen != [NSNull null]) {
                    NSURL * imageURL = [NSURL URLWithString:imagen];
                    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
                
                    [retailer setImagen:imageData];
                }
                [retailer setWebid:idRet];
                retailer.events = [[NSMutableArray alloc]init];
                
                for (id event in resp[@"retailer"][@"events"]) {
                    NSString *webid =event[@"id"];
                    //                NSString *retailer =event[@"retailer"];
                    NSString *imagen =event[@"imagen"];
                    NSString *name =event[@"name"];
                    NSString *description =event[@"description"];
                    NSString *date =event[@"date"];
                    NSString *time =event[@"time"];
                    NSString *address =event[@"address"];
                    NSString *address2 =event[@"address2"];
                    NSString *city =event[@"city"];
                    NSString *states =event[@"states"];
                    NSString *zipCode =event[@"zipCode"];
                    NSString *cost =event[@"cost"];
                    
                    float latitudeEvent =[event[@"latitude"] floatValue];
                    float longitudeEvent =[event[@"longitude"] floatValue];
                    
                    Event * ev = [[Event alloc] init];
                    [ev setWebid:webid];
                    [ev setName:name];
                    [ev setDescription:description];
                    
                    if ((NSNull *)imagen != [NSNull null]) {
                        NSURL * imageURL = [NSURL URLWithString:imagen];
                        NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
                        [ev setImagen:imageData];
                    }
                    
                    NSDateFormatter *aDateFormatter = [[NSDateFormatter alloc] init];
                    aDateFormatter.dateFormat = @"yyyy-MM-dd";
                    NSDate *dDate = [aDateFormatter dateFromString:date];
                    [ev setDate:dDate];
                    aDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                    NSDate *dTime = [aDateFormatter dateFromString:[NSString stringWithFormat:@"%@ %@",date,time]];
                    [ev setTime:dTime];
                    
                    [ev setAddress:address];
                    [ev setAddress2:address2];
                    [ev setCity:city];
                    [ev setStates:states];
                    [ev setZipCode:zipCode];
                    float fCost =[cost floatValue];
                    [ev setCost:fCost];
                    [ev setLatitude:latitudeEvent];
                    [ev setLongitude:longitudeEvent];
                    
                    [retailer addEventsObject:ev];
                    
                }
                
                [dic setObject:retailer forKey:idRet];
            }
            
            
            
            Location * location = [[Location alloc] init];
            [retailer addLocationsObject:location];
            
            NSString *nameLocation =resp[@"name"];
            NSString *webid =resp[@"id"];
            NSString *descLocation =resp[@"description"];
            float latitudeLocation =[resp[@"latitude"] floatValue];
            float longitudeLocation =[resp[@"longitude"] floatValue];
            
            [location setName:nameLocation];
            [location setDesc:descLocation];
            [location setLatitude:latitudeLocation];
            [location setLongitude:longitudeLocation];
            [location setWebid:webid];
            location.products = [[NSMutableArray alloc]init];

            
            for (id prod in resp[@"products"]) {
                
                Product * product = [[Product alloc] init];
                
                NSString *imagenProduct =prod[@"product"][@"imagen"];
                NSString *nameProduct =prod[@"product"][@"name"];
                NSString *sizeProduct =prod[@"product"][@"size"];
                NSString *unitProduct =prod[@"product"][@"unit"];
                NSString *description =prod[@"product"][@"description"];
                NSString *webid =prod[@"id"];
                NSString *webidProduct =prod[@"product"][@"id"];
                NSString *prouctTypeProduct =prod[@"product"][@"prouctType"];
                NSString *country =prod[@"product"][@"country"];
                
                NSString *salePriceProduct =prod[@"salePrice"];
                NSString *regularPriceProduct =prod[@"regularPrice"];
                
                NSString *rate =prod[@"rate"];
                
                
                if ((NSNull *)imagenProduct != [NSNull null]) {
                    NSURL * imageURL = [NSURL URLWithString:imagenProduct];
                    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
                    [product setImagen:imageData];
                }
                [product setName:nameProduct];
                [product setSize:[sizeProduct floatValue]];
                [product setUnit:unitProduct];
                [product setProuctType:prouctTypeProduct];
                [product setSalePrice:[salePriceProduct floatValue]];
                [product setRegularPrice:[regularPriceProduct floatValue]];
                [product setRate:[rate floatValue]];
                [product setWebid:webid];
                [product setWebidProduct:webidProduct];
                [location addProductsObject:product];
//                [product setLocation:location];
                [product setDesc:description];
                [product setCountry:country];
                
                if ([product.prouctType isEqualToString:@"Wi"]) {
                    [_wineProducts addObject:product];
                }else if ([product.prouctType isEqualToString:@"Be"]){
                    [_beerProducts addObject:product];
                }else if ([product.prouctType isEqualToString:@"Li"]){
                    [_liquorProducts addObject:product];
                }
                
                
            }
            [_locations addObject:location];
            callbackBlock(_locations,_wineProducts,_beerProducts,_liquorProducts);
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSMutableArray *_locations = [[NSMutableArray alloc] init];
        NSMutableArray *_wineProducts = [[NSMutableArray alloc] init];
        NSMutableArray *_beerProducts = [[NSMutableArray alloc] init];
        NSMutableArray *_liquorProducts = [[NSMutableArray alloc] init];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"There has been an error with the network."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        callbackBlock(_locations,_wineProducts,_beerProducts,_liquorProducts);
        
        NSLog(@"%@",error.description);
        
    }];
   
    
}


+ (void)getProductsWhitId:(int)product_id
                 CallBack:(void (^)(Product *product))callbackBlock{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    NSString *urlJson = [NSString stringWithFormat:@"%@/%@/%d/",urlServer,jsonInventory,product_id];
    
    [manager GET:urlJson parameters:nil success:^(AFHTTPRequestOperation *operation, id prod) {
        
        Product * product = [[Product alloc] init];
        
        NSString *imagenProduct =prod[@"product"][@"imagen"];
        NSString *nameProduct =prod[@"product"][@"name"];
        NSString *sizeProduct =prod[@"product"][@"size"];
        NSString *unitProduct =prod[@"product"][@"unit"];
        NSString *description =prod[@"product"][@"description"];
        NSString *webid =prod[@"id"];
        NSString *webidProduct =prod[@"product"][@"id"];
        NSString *prouctTypeProduct =prod[@"product"][@"prouctType"];
        NSString *country =prod[@"product"][@"country"];
        
        NSString *salePriceProduct =prod[@"salePrice"];
        NSString *regularPriceProduct =prod[@"regularPrice"];
        NSString *rate =prod[@"rate"];
        
        
        if ((NSNull *)imagenProduct != [NSNull null]) {
            NSURL * imageURL = [NSURL URLWithString:imagenProduct];
            NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
            [product setImagen:imageData];
        }
        [product setName:nameProduct];
        [product setSize:[sizeProduct floatValue]];
        [product setUnit:unitProduct];
        [product setProuctType:prouctTypeProduct];
        [product setSalePrice:[salePriceProduct floatValue]];
        [product setRegularPrice:[regularPriceProduct floatValue]];
        [product setRate:[rate floatValue]];
        [product setWebid:webid];
        [product setWebidProduct:webidProduct];
//        [product setLocation:location];
        [product setDesc:description];
        [product setCountry:country];
        
        for (id rev in prod[@"product"][@"reviews"]) {
            Review * review = [[Review alloc] init];
            NSString * webid = rev[@"id"];
            NSString * user_name = rev[@"user_name"];
            NSString * tagline = rev[@"tagline"];
            NSString * description = rev[@"description"];
            NSString * rate = rev[@"rate"];
            NSString * userFacebookId = rev[@"userFacebookId"];
            
            NSString *aStrDate = rev[@"date"];
            NSDateFormatter *aDateFormatter = [[NSDateFormatter alloc] init];
            aDateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
            NSDate *aDate = [aDateFormatter dateFromString:aStrDate];
            NSLog(@"%@",aDate);
            
            [review setWebid:webid];
            [review setDate:aDate];
            [review setUser_name:user_name];
            [review setTagline:tagline];
            [review setDesc:description];
            [review setRate:[rate floatValue]];
            [review setUserFacebookId:userFacebookId];
            [product addReviewsObject:review];
            
        }
        NSLog(@"reviews : %d",[product.reviews count]);
        callbackBlock(product);
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        callbackBlock(nil);
    }];
    
}

+(void)sendReviewWithUser_name:(NSString*)user_name
                       Tagline:(NSString*)tagline
                          Rate:(float)rate
                     Inventory:(int)inventory
                UserFacebookId:(NSString*)userFacebookId
                Description:(NSString*)description
                      CallBack:(void (^)(Review *newReview))callbackBlock{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    NSDictionary *parameters = @{
                                 @"user_name": user_name,
                                 @"tagline": tagline,
                                 @"rate": [NSString stringWithFormat:@"%f",rate],
                                 @"product": [NSString stringWithFormat:@"%d",inventory],
                                 @"userFacebookId": userFacebookId,
                                 @"description":description
                                 };
    NSString *urlJson = [NSString stringWithFormat:@"%@/%@/",urlServer,jsonReview];
    NSLog(@"%@",parameters);

    
    
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
//    
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    manager.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithArray:@[@"POST", @"GET", @"HEAD"]];

    
//    [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlJson parameters:parameters ];
    
    [manager POST:urlJson parameters:parameters success:^(AFHTTPRequestOperation *operation, id rev) {
        
        Review * review = [[Review alloc] init];
        NSString * webid = rev[@"id"];
        NSString * user_name = rev[@"user_name"];
        NSString * tagline = rev[@"tagline"];
        NSString * description = rev[@"description"];
        NSString * rate = rev[@"rate"];
        NSString * userFacebookId = rev[@"userFacebookId"];
        
        NSString *aStrDate = rev[@"date"];
        NSDateFormatter *aDateFormatter = [[NSDateFormatter alloc] init];
        aDateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
        NSDate *aDate = [aDateFormatter dateFromString:aStrDate];
        NSLog(@"%@",aDate);
        
        [review setWebid:webid];
        [review setDate:aDate];
        [review setUser_name:user_name];
        [review setTagline:tagline];
        [review setDesc:description];
        [review setRate:[rate floatValue]];
        [review setUserFacebookId:userFacebookId];
        
        
        callbackBlock(review);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        callbackBlock(nil);
    }];
    
}

@end
