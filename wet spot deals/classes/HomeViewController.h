//
//  HomeViewController.h
//  wet spot deals
//
//  Created by KOMI Marketing on 26/05/15.
//  Copyright (c) 2015 KOMI Marketing All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeViewChooseDelegate;

#import "Constants.h"

@protocol HomeViewChooseDelegate <NSObject>

-(void)selectBeer;
-(void)selectWine;
-(void)selectLiquor;
-(void)selectLocation;

@end

@interface HomeViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *container;
@property (weak) id <HomeViewChooseDelegate> delegate;
- (IBAction)typeChanged:(id)sender forEvent:(UIEvent *)event;
@property (strong, nonatomic) IBOutlet UISegmentedControl *productSelecter;


@property(nonatomic)Types currentType;
@property(strong, nonatomic)NSString* searchText;

@end
