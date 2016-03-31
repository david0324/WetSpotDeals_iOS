//
//  HomeViewController.m
//  wet spot deals
//
//  Created by KOMI Marketing on 26/05/15.
//  Copyright (c) 2015 KOMI Marketing All rights reserved.
//

#import "HomeViewController.h"
#import "BeerParallaxController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    switch (_currentType) {
        case Beer:
            [ _productSelecter setSelectedSegmentIndex:0];
            break;
        case Wine:
            [ _productSelecter setSelectedSegmentIndex:1];
            break;
        case Liquor:
            [ _productSelecter setSelectedSegmentIndex:2];
            break;
        case Locations:
            break;
            
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)typeChanged:(id)sender forEvent:(UIEvent *)event {
    int index = [_productSelecter selectedSegmentIndex];
    
    switch (index) {
        case 0:
            [self.delegate selectBeer];
            break;
        case 1:
            [self.delegate selectWine];
            break;
        case 2:
            [self.delegate selectLiquor];
            break;
            
        default:
            break;
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString * segueName = segue.identifier;
    if ([segueName isEqualToString: @"beerChild"]) {
        BeerParallaxController *child = (BeerParallaxController*)[segue destinationViewController];
        self.delegate =child;
        child.currentType = _currentType;
        
        if (_searchText != nil) {
            child.searchText = _searchText;
        }
//        AlertView * alertView = childViewController.view;
        // do something with the AlertView's subviews here...
    }
}

@end
