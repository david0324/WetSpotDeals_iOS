//
//  Constants.h
//  PoliticosIos
//
//  Created by KOMI Marketing on 21/03/15.
//  Copyright (c) 2015 KOMI Marketing All rights reserved.
//

static NSString *sProjectName = @"wet_spot_deals";
static NSString *urlServer = @"https://wetspotdeals.com";
//static NSString *urlServer = @"http://127.0.0.1:8000";
static NSString *jsonLocation = @"service/location";
static NSString *jsonInventory = @"service/inventory";
static NSString *jsonReview = @"service/reviews";
static NSString *jsonRandomReviews = @"service/randomEvent";

typedef enum {
    Beer = 0,
    Wine,
    Liquor,
    Locations
} Types;

