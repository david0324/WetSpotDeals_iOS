 //
//  BeerParallaxController.m
//  wet spot deals
//
//  Created by KOMI Marketing on 30/03/15.
//  Copyright (c) 2015 KOMI Marketing All rights reserved.
//



#import "BeerParallaxController.h"

#import <UIScrollView+InfiniteScroll.h>
#import "RestManager.h"
#import "ItemTableViewCell.h"
#import "Product.h"
#import "Location.h"
#import "ProductTableViewController.h"
#import "LocationTableViewController.h"
#import "SVProgressHUD.h"
#import "Retailer.h"
#import "DetailLocationTableViewCell.h"
#import "LocationTableViewCell.h"

#import "Mixpanel.h"



@interface BeerParallaxController ()

@property() float H;
@property(nonatomic) NSMutableArray *objects;
@property(nonatomic)NSArray *locations;
@property(nonatomic)NSArray *wineProducts;
@property(nonatomic)NSArray *beerProducts;
@property(nonatomic)NSArray *liquorProducts;
@property(nonatomic)NSArray *currentArray;
@property(nonatomic)NSMutableDictionary     *listProducts;
@property(nonatomic)NSMutableDictionary     *pointsProducts;


@end

@implementation BeerParallaxController

//-(void)setCurrentType:(Types )currentType{
//    _currentType = currentType;
//}

- (void)viewDidLoad {
    Mixpanel *mixpanel = [Mixpanel sharedInstance];
    _listProducts = [[NSMutableDictionary alloc] init];
    
    //    [CLLocationManager req];
//    self.locationManager = [[CLLocationManager alloc] init];
//    [self.locationManager requestWhenInUseAuthorization];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
    
    [self.mapView setShowsUserLocation:YES];
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    
    [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];


//
    self.H = self.view.frame.size.height/4;
    self.heighTableViewHeader = self.H ;
//
    self.Y_tableViewOnBottom =self.H*2;
//
//    self.minYOffsetToReach = 200;
    
    
    [super viewDidLoad];
    
    
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [RestManager updateProductsWhitLatitude:0 longitude:0 CallBack:^(NSArray *locations, NSArray *wineProducts, NSArray *beerProducts, NSArray *liquorProducts) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                _locations =locations;
                _wineProducts =wineProducts;
                _beerProducts =beerProducts;
                _liquorProducts =liquorProducts;
                
                if (_searchText != nil) {
                    NSMutableArray *aux = [[NSMutableArray alloc]init];
                    for (Location *loc in _locations) {
                        NSString *string = loc.name;
                        if ([string rangeOfString:_searchText].location == NSNotFound) {

                        } else {
                            [aux addObject:loc];
                        }
                    }
                    _locations = aux;
                }
                
                [self changeType:_currentType];
//                self.currentArray = _wineProducts;
//                [self.tableView reloadData];
                
                [SVProgressHUD dismiss];
            });
            
        }];
        
        
    });
    
    _beerProducts = [[NSArray alloc]init];
    self.currentArray = _beerProducts;
    [self.tableView registerNib:[UINib nibWithNibName:@"ItemCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"itemCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LocationTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"detailLocation"];
    
    self.objects = [[NSMutableArray alloc] init];
    
    // change indicator view style to white
    self.tableView.infiniteScrollIndicatorStyle = UIActivityIndicatorViewStyleGray;
    
    // setup infinite scroll
    [self.tableView addInfiniteScrollWithHandler:^(UITableView* tableView) {
        [RestManager updateProductsWhitLatitude:0 longitude:0 CallBack:^(NSArray *locations, NSArray *wineProducts, NSArray *beerProducts, NSArray *liquorProducts) {
            _locations =locations;
            _wineProducts =wineProducts;
            _beerProducts =beerProducts;
            _liquorProducts =liquorProducts;
            self.currentArray = _wineProducts;
            [self.tableView reloadData];
            [tableView finishInfiniteScroll];
        }];
        
//        int64_t delayInSeconds = 1;
//        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//            [_objects addObject:@"obj"];
//            [tableView reloadData];
//            [tableView finishInfiniteScroll];
//            
//        });
    }];
    
    
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
//    NSArray* locations= @[ MakeLocation(20,20) , MakeLocation(40,40) , MakeLocation(60,60) ];

    CLLocation * cccc = [[CLLocation alloc]initWithLatitude: userLocation.location.coordinate.latitude longitude: userLocation.location.coordinate.longitude];
    
    MKPointAnnotation* annotation= [MKPointAnnotation new];
    annotation.coordinate= [cccc coordinate];
    [self.mapView addAnnotation: annotation];
    
    NSLog(@"location delegate called");
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.currentArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell;
    static NSString *identifier;
//    if(indexPath.row == 0){
//        identifier = @"itemCell";
//        // Add some shadow to the first cell
//        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//        if(!cell){
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
//                                          reuseIdentifier:identifier];
//            
//            CGRect cellBounds       = cell.layer.bounds;
//            CGRect shadowFrame      = CGRectMake(cellBounds.origin.x, cellBounds.origin.y, tableView.frame.size.width, 10.0);
//            CGPathRef shadowPath    = [UIBezierPath bezierPathWithRect:shadowFrame].CGPath;
//            cell.layer.shadowPath   = shadowPath;
//            [cell.layer setShadowOffset:CGSizeMake(-2, -2)];
//            [cell.layer setShadowColor:[[UIColor grayColor] CGColor]];
//            [cell.layer setShadowOpacity:.75];
//        }
//    }
//    else{
//        identifier = @"itemCell";
//        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//        if(!cell)
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
//                                          reuseIdentifier:identifier];
//    }
    
    switch (_currentType) {
        case Locations:
            identifier = @"detailLocation";
            cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if(!cell){
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:identifier];
            }
            
            cell = [self configureLocation:cell IndexPath:indexPath];
            break;
            
        default:
            
            identifier = @"itemCell";
            cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if(!cell){
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                  reuseIdentifier:identifier];
            }
            
            cell = [self configureProduct:cell IndexPath:indexPath];
            break;
    }
    return cell;
}

-(UITableViewCell*)configureProduct:(UITableViewCell*)cell IndexPath:(NSIndexPath*)indexPath{
    ItemTableViewCell* cCell = (ItemTableViewCell*)cell;
    Product * product = (Product*) [_currentArray objectAtIndex:indexPath.row];
    
    UIImage * image = [UIImage imageWithData:product.imagen];
    [cCell.image setImage:image];
    cCell.title.text = product.name;
    cCell.subTitle.text = [NSString stringWithFormat:@"%.2f %@",product.size,product.unit];
    [cCell setRate:product.rate];
    
    if ([_listProducts objectForKey:product.webid] == nil) {
        
        Mixpanel *mixpanel = [Mixpanel sharedInstance];
        
        [mixpanel track:@"list" properties:@{
                                             @"product":product.webidProduct,
                                             @"invetory": product.webid,
                                             @"location": product.location.webid,
                                             @"client": product.location.retailer.webid
                                             }];
        [_listProducts setValue:@"true" forKey:product.webid];
    }
    return cCell;
}

-(UITableViewCell*)configureLocation:(UITableViewCell*)cell IndexPath:(NSIndexPath*)indexPath{
    LocationTableViewCell* cCell = (LocationTableViewCell*)cell;
    Location * location = (Location*) [_locations objectAtIndex:indexPath.row];
    
    cCell.name.text = location.name;
    cCell.detail.text = location.desc;
    
    if ([location.phone isEqualToString:@""] || location.phone == nil) {
        [cCell.phoneImg setHidden:YES];
        [cCell.phone setHidden:YES];
    }else{
        cCell.phone.text = location.phone;
    }
    if ([location.retailer.url isEqualToString:@""] || location.retailer.url == nil) {
        [cCell.homeImg setHidden:YES];
        [cCell.webpage setHidden:YES];
    }else{
        cCell.webpage.text = location.retailer.url;
    }
    
    UIImage * image = [UIImage imageWithData:location.retailer.imagen];
    [cCell.img setImage:image];
    
    return cCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (self.currentType) {
        case Locations:
            [self performSegueWithIdentifier:@"locationSelected" sender:self];
            break;
            
        default:
            [self performSegueWithIdentifier:@"productSelected" sender:self];
            break;
    }
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"productSelected"]) {
        ProductTableViewController* productController = (ProductTableViewController*)segue.destinationViewController;
        
        productController.product = (Product*)[ _currentArray objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
    if ([[segue identifier] isEqualToString:@"locationSelected"]) {
        LocationTableViewController* productController = (LocationTableViewController*)segue.destinationViewController;
        
        productController.location = (Location*)[ _locations objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
}
-(void)updateAnnotationsWithArray:(NSArray*)arr{
    [self.mapView removeAnnotations:self.mapView.annotations];
    _pointsProducts = [[NSMutableDictionary alloc] init];
    if ([arr isEqual:_locations]) {
        
        for (Location * loc in arr) {
            CLLocation * cccc = [[CLLocation alloc]initWithLatitude: loc.latitude longitude: loc.longitude];
            
            [_pointsProducts setValue:loc forKey:[NSString stringWithFormat:@"%f%f",loc.latitude,loc.longitude]];
            
            MKPointAnnotation* annotation= [MKPointAnnotation new];
            annotation.coordinate= [cccc coordinate];
//            annotation.
            [self.mapView addAnnotation: annotation];
        }
    }else{
        
        for (Product * prod in arr) {
            CLLocation * cccc = [[CLLocation alloc]initWithLatitude: prod.location.latitude longitude: prod.location.longitude];
            
            
            [_pointsProducts setValue:prod forKey:[NSString stringWithFormat:@"%f%f",prod.location.latitude,prod.location.longitude]];
            
            
            MKPointAnnotation* annotation= [MKPointAnnotation new];
            annotation.coordinate= [cccc coordinate];
            [self.mapView addAnnotation: annotation];
        }
    
    
    }
}

- (void)mapView:(MKMapView *)map annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    
    float latitude = [view.annotation coordinate].latitude;
    float longitude = [view.annotation coordinate].longitude;
    
    if ([_currentArray isEqual:_locations]) {
        Location *loc = [_pointsProducts valueForKey:[NSString stringWithFormat:@"%f%f",latitude,longitude]];
    }else{
        Location *prod = [_pointsProducts valueForKey:[NSString stringWithFormat:@"%f%f",latitude,longitude]];
        
    }
}

-(void)changeType:(Types)type{
    self.currentType = type;
    
    switch (type) {
        case Beer:
            self.currentArray = _beerProducts;
            [self.tableView reloadData];
            [self updateAnnotationsWithArray:_beerProducts];
            break;
        case Wine:
            self.currentArray = _wineProducts;
            [self.tableView reloadData];
            [self updateAnnotationsWithArray:_wineProducts];
            break;
        case Liquor:
            self.currentArray = _liquorProducts;
            [self.tableView reloadData];
            [self updateAnnotationsWithArray:_liquorProducts];
            break;
        case Locations:
            self.currentArray = _locations;
            [self.tableView reloadData];
            [self updateAnnotationsWithArray:_locations];
            break;
            
    }
}

-(void)selectBeer{
    [self changeType:Beer];
}
-(void)selectWine{
    [self changeType:Wine];
}
-(void)selectLiquor{
    [self changeType:Liquor];
}
-(void)selectLocation{
    [self changeType:Locations];
}

@end
