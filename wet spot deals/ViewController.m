//
//  ViewController.m
//  wet spot deals
//
//  Created by KOMI Marketing on 29/03/15.
//  Copyright (c) 2015 KOMI Markerting. All rights reserved.
//

#import "ViewController.h"
#import "BeerParallaxController.h"
#import "Constants.h"

@interface ViewController ()

@property(strong, nonatomic)NSString* searchText;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    
//    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background_home_wetspotdepot.png"]];
//    
//    [_background_home setBackgroundColor:background];
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    
    UIGraphicsBeginImageContext(_background_home.frame.size);
    
    
    [[UIImage imageNamed:@"background_home_wetspotdepot.png"] drawInRect:_background_home.bounds];
      UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    _background_home.backgroundColor = [UIColor colorWithPatternImage:image];
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    _searchText = searchBar.text;
    [searchBar resignFirstResponder];
    [self performSegueWithIdentifier:@"searchLocation" sender:self];
}
-(void)viewDidLayoutSubviews{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    HomeViewController* beerController = (HomeViewController*)segue.destinationViewController;
//    viewToBeer
//    viewToWine
//    viewToLiquor
//    viewToLocation
    if ([[segue identifier] isEqualToString:@"viewToBeer"]) {
        Types* t = Beer;
        beerController.currentType = t;
    }else if ([[segue identifier] isEqualToString:@"viewToWine"]){
        beerController.currentType = Wine;
    }else if ([[segue identifier] isEqualToString:@"viewToLiquor"]){
        beerController.currentType = Liquor;
    }else if ([[segue identifier] isEqualToString:@"viewToLocation"]){
        beerController.currentType = Locations;
    }else if ([[segue identifier] isEqualToString:@"searchLocation"]){
        beerController.currentType = Locations;
        beerController.searchText = _searchText;
    }
    [_searchBar resignFirstResponder];
}

@end
