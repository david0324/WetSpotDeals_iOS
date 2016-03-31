//
//  StartTableViewController.h
//  wet spot deals
//
//  Created by luis alfredo rivera acuña on 30/06/15.
//  Copyright (c) 2015 KOMI Marketing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Event;

@interface StartTableViewController : UITableViewController<UISearchBarDelegate>
@property (strong, nonatomic) IBOutlet UIButton *event1Img;
@property (strong, nonatomic) IBOutlet UIButton *event2Img;

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) Event* evetRandom1;
@property (strong, nonatomic) Event* evetRandom2;

- (IBAction)showBeer:(id)sender;
- (IBAction)showWine:(id)sender;
- (IBAction)showLiquor:(id)sender;
- (IBAction)showLocation:(id)sender;

@end
