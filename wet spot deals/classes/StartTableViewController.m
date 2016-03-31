//
//  StartTableViewController.m
//  wet spot deals
//
//  Created by luis alfredo rivera acuña on 30/06/15.
//  Copyright (c) 2015 KOMI Marketing. All rights reserved.
//

#import "StartTableViewController.h"
#import "EventTableViewController.h"
#import "HomeViewController.h"
#import "Constants.h"
#import "RestManager.h"

@interface StartTableViewController ()

@property(strong, nonatomic)NSString* searchText;
@property(nonatomic)Types type;

@end

@implementation StartTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [RestManager getHomeEventsWhitLatitude:0 longitude:0 CallBack:^(Event *event1, Event *event2) {
            if (event1 != nil) {
                UIImage * image = [UIImage imageWithData:event1.imagen];
                [_event1Img setImage:image forState:UIControlStateNormal];
            }
            if (event2 != nil) {
                UIImage * image = [UIImage imageWithData:event2.imagen];
                [_event2Img setImage:image forState:UIControlStateNormal];
            }
            _evetRandom1 = event1;
            _evetRandom2 = event2;
        }];
        
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    _searchText = searchBar.text;
    self.type = Locations;
    [searchBar resignFirstResponder];
    [self performSegueWithIdentifier:@"viewToBeerController" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    HomeViewController* homeController = (HomeViewController*)segue.destinationViewController;

    if ([[segue identifier] isEqualToString:@"viewToBeerController"]) {
        homeController.currentType = self.type;
        homeController.searchText = _searchText;
    }
    
    
    if ([[segue identifier] isEqualToString:@"showEvent1"]) {
        EventTableViewController* eventController = (EventTableViewController*)segue.destinationViewController;
        
        eventController.event = _evetRandom1;
    }
    if ([[segue identifier] isEqualToString:@"showEvent2"]) {
        EventTableViewController* eventController = (EventTableViewController*)segue.destinationViewController;
        
        eventController.event = _evetRandom2;
    }
    
    [_searchBar resignFirstResponder];
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if ([identifier isEqualToString:@"showEvent1"]) {
        if (_evetRandom1 !=nil) {
            return YES;
        }else{
            return NO;
        }
    }
    if ([identifier isEqualToString:@"showEvent2"]) {
        if (_evetRandom2 !=nil) {
            return YES;
        }else{
            return NO;
        }
    }
    
    return YES;
}
- (IBAction)showBeer:(id)sender {
    self.type = Beer;
    [self performSegueWithIdentifier:@"viewToBeerController" sender:self];
}

- (IBAction)showWine:(id)sender {
    self.type = Wine;
    [self performSegueWithIdentifier:@"viewToBeerController" sender:self];
}

- (IBAction)showLiquor:(id)sender {
    self.type = Liquor;
    [self performSegueWithIdentifier:@"viewToBeerController" sender:self];
}

- (IBAction)showLocation:(id)sender {
    self.type = Locations;
    [self performSegueWithIdentifier:@"viewToBeerController" sender:self];
}
@end
