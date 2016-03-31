//
//  LocationTableViewController.m
//  wet spot deals
//
//  Created by luis alfredo rivera acuña on 24/06/15.
//  Copyright (c) 2015 luis alfredo rivera acu&#241;a. All rights reserved.
//

#import "LocationTableViewController.h"
#import "Location.h"
#import "Retailer.h"
#import "Product.h"
#import "Mixpanel.h"
#import "Event.h"

#import "DetailLocationTableViewCell.h"
#import "MapProductCollectionViewCell.h"
#import "UpcomingEventTableViewCell.h"
#import "OtherProductCollectionViewCell.h"
#import "LocationTableViewCell.h"
#import "ProductTableViewController.h"
#import "EventTableViewController.h"

@interface LocationTableViewController ()

@property(nonatomic)NSMutableDictionary     *listProducts;
@end

@implementation LocationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _listProducts = [[NSMutableDictionary alloc] init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            if ([_location.retailer.events count] > 0) {
                return 1;
            }else{
                return 0;
            }
            break;
        case 3:
            return [_location.retailer.events count];
            break;
        case 4:
            if ([_location.products count] > 0) {
                return 1;
            }else{
                return 0;
            }
            
            break;
        case 5:
            return [_location.products count];
            break;
            
        default:
            break;
    }
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float height = 80;
    switch (indexPath.section) {
        case 0:
            height =  100;
            break;
        case 1:
            height =  200;
            break;
        case 2:
            height =  50;
            break;
        case 3:
            height =  200;
            break;
        case 4:
            height =  50;
            break;
        case 5:
            height =  80;
            break;
            
        default:
            break;
    }
    
    return height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    NSString *detailLocation = @"detailLocation2";
    NSString *mapProduct = @"mapProduct";
    NSString *upcomingEvents = @"upcomingEvents";
    NSString *upcomingEvent = @"upcomingEvent";
    NSString *titleOtherProduct = @"titleOtherProduct";
    NSString *otherProduct = @"otherProduct";
    NSString *identifier ;
    
    switch (indexPath.section) {
        case 0:
            identifier =detailLocation;
            break;
        case 1:
            identifier =mapProduct;
            break;
        case 2:
            identifier =upcomingEvents;
            break;
        case 3:
            identifier =upcomingEvent;
            break;
        case 4:
            identifier =titleOtherProduct;
            break;
        case 5:
            identifier = otherProduct;
            break;
        default:
            break;
    }
    
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:identifier];
    }
    
    switch (indexPath.section) {
        case 0:
            cell = [self configureDetailLocation:cell];
            break;
        case 1:
            cell = [self configureMapProduct:cell];
            break;
        case 3:
            cell = [self configureUpcomingEvent:cell IndexPath:indexPath];
            break;
        case 5:
            cell = [self configureOtherProduct:cell IndexPath:indexPath];
            break;
        default:
            break;
    }
    
    
    return cell;
}



-(UITableViewCell*)configureDetailLocation:(UITableViewCell*)cell{
    
    MapProductCollectionViewCell* cCell2 = (MapProductCollectionViewCell*)cell;
    
    LocationTableViewCell* cCell = (LocationTableViewCell*)cell;
    
    //@property (strong, nonatomic) IBOutlet UILabel *long_description;
    cCell.name.text = _location.name;
    cCell.detail.text = _location.desc;
    if ([_location.phone isEqualToString:@""] || _location.phone == nil) {
        [cCell.phoneImg setHidden:YES];
        [cCell.phone setHidden:YES];
    }else{
        cCell.phone.text = _location.phone;
    }
    if ([_location.retailer.url isEqualToString:@""] || _location.retailer.url == nil) {
        [cCell.homeImg setHidden:YES];
        [cCell.webpage setHidden:YES];
    }else{
        cCell.webpage.text = _location.retailer.url;
    }
    
    UIImage * image = [UIImage imageWithData:_location.retailer.imagen];
    [cCell.img setImage:image];
    return cCell;
}
-(UITableViewCell*)configureMapProduct:(UITableViewCell*)cell{
    MapProductCollectionViewCell* cCell = (MapProductCollectionViewCell*)cell;
    
    CLLocation * cccc = [[CLLocation alloc]initWithLatitude: _location.latitude longitude: _location.longitude];
    
    MKPointAnnotation* annotation= [MKPointAnnotation new];
    annotation.coordinate= [cccc coordinate];
    [cCell.map addAnnotation: annotation];
    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.005;
    span.longitudeDelta = 0.005;
    CLLocationCoordinate2D location;
    location.latitude = _location.latitude;
    location.longitude = _location.longitude;
    region.span = span;
    region.center = location;
    [cCell.map setRegion:region animated:YES];
    
    return cCell;
}

-(UITableViewCell*)configureUpcomingEvent:(UITableViewCell*)cell IndexPath:(NSIndexPath*)indexPath{
    UpcomingEventTableViewCell* cCell = (UpcomingEventTableViewCell*)cell;
    NSInteger row = indexPath.row;
    Event * event = [_location.retailer.events objectAtIndex:row];
    UIImage * image = [UIImage imageWithData:event.imagen];
    [cCell.img setImage:image];
    cCell.title.text = event.name;
    if (event.cost == 0) {
        cCell.price.text = @"free";
    }else{
        cCell.price.text = [NSString stringWithFormat:@"$%.2f",event.cost];
    }
    
    NSDateFormatter *aDateFormatter = [[NSDateFormatter alloc] init];
    aDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    cCell.eventDate.text = [aDateFormatter stringFromDate:event.time];
    cCell.eventAddress.text = event.address;
    cCell.desc.text = event.description;
    
    
    
    //@property (strong, nonatomic) IBOutlet UILabel *long_description;
//    cCell.long_description.text =_product.desc;
    
    return cCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 3:
//            cell = [self configureUpcomingEvent:cell IndexPath:indexPath];
            break;
        case 5:
            [self performSegueWithIdentifier:@"productSelected" sender:self];
            break;
        default:
            break;
    }
    
    
    
}


-(UITableViewCell*)configureOtherProduct:(UITableViewCell*)cell IndexPath:(NSIndexPath*)indexPath{
    OtherProductCollectionViewCell* cCell = (OtherProductCollectionViewCell*)cell;
    NSInteger row = indexPath.row;
    Product * other = [_location.products objectAtIndex:row];
    UIImage * image = [UIImage imageWithData:other.imagen];
    [cCell.image setImage:image];
    
    cCell.name.text = other.name;
    cCell.resume.text = [NSString stringWithFormat:@"%.2f %@",other.size,other.unit];
    [cCell setRate:other.rate];
    cCell.price.text = [NSString stringWithFormat:@"%.2f", other.salePrice];
    
    
    if ([_listProducts objectForKey:other.webid] == nil) {
        
        Mixpanel *mixpanel = [Mixpanel sharedInstance];
        
        [mixpanel track:@"list" properties:@{
                                             @"product":other.webidProduct,
                                             @"invetory": other.webid,
                                             @"location": other.location.webid,
                                             @"client": other.location.retailer.webid
                                             }];
        [_listProducts setValue:@"true" forKey:other.webid];
    }
    
    return cCell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"productSelected"]) {
        ProductTableViewController* productController = (ProductTableViewController*)segue.destinationViewController;
        
        productController.product = (Product*)[ _location.products objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
    if ([[segue identifier] isEqualToString:@"showEvent"]) {
        EventTableViewController* eventController = (EventTableViewController*)segue.destinationViewController;
        
        eventController.event = (Event*)[ _location.retailer.events objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
    
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
