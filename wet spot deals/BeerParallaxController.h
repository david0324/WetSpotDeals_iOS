//
//  BeerParallaxController.h
//  wet spot deals
//
//  Created by KOMI Marketing on 30/03/15.
//  Copyright (c) 2015 KOMI Marketing All rights reserved.
//

#import "SLParallaxController.h"
#import "HomeViewController.h"
#import "Constants.h"


@interface BeerParallaxController : SLParallaxController<HomeViewChooseDelegate,CLLocationManagerDelegate>


@property (strong, nonatomic) CLLocationManager *locationManager;

@property(nonatomic)Types currentType;
@property(strong, nonatomic)NSString* searchText;
@end
