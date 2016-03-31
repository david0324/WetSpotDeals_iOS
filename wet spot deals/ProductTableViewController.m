//
//  ProductTableViewController.m
//  wet spot deals
//
//  Created by KOMI Marketing on 30/03/15.
//  Copyright (c) 2015 KOMI Marketing All rights reserved.
//

#import "ProductTableViewController.h"
#import "DetailProductCollectionViewCell.h"
#import "SubDetailProductCollectionViewCell.h"
#import "DescriptionProductCollectionViewCell.h"
#import "MapProductCollectionViewCell.h"
#import "OtherProductCollectionViewCell.h"
#import "ProductReviewsTableViewController.h"
#import "Location.h"

#import "Retailer.h"
#import "Mixpanel.h"
@interface ProductTableViewController ()

@property(nonatomic)NSMutableDictionary     *listProducts;

@property(strong,nonatomic) NSMutableArray* relatedProducts;

@end

@implementation ProductTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _listProducts = [[NSMutableDictionary alloc] init];
    _relatedProducts = [_product.location getProductsWithout:_product];
    Mixpanel *mixpanel = [Mixpanel sharedInstance];
    
    [mixpanel track:@"view" properties:@{
                                         @"product":_product.webidProduct,
                                         @"invetory": _product.webid,
                                         @"location": _product.location.webid,
                                         @"client": _product.location.retailer.webid
                                         }];
    
    
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0) {
        if ([_relatedProducts count] > 0) {
            return 5;
        }else{
            int rows = 4;
            if ([_product.desc isEqualToString:@""]) {
                rows = rows -1;
            }
            return rows;
        }
    }
    return [_relatedProducts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    NSString *detailProduct = @"detailProduct";
    NSString *subDetailProduct = @"subDetailProduct";
    NSString *descriptionProduct = @"descriptionProduct";
    NSString *mapProduct = @"mapProduct";
    NSString *otherProduct = @"otherProduct";
    NSString *titleOtherProduct = @"titleOtherProduct";
    NSString *identifier ;

    switch (indexPath.section) {
        case 0:
            switch ([indexPath row]) {
                case 0:
                    identifier = detailProduct;
                    break;
                case 1:
                    identifier = subDetailProduct;
                    break;
                case 2:
                    identifier = descriptionProduct;
                    break;
                case 3:
                    identifier = mapProduct;
                    break;
                case 4:
                    identifier = titleOtherProduct;
                    break;
                    
                default:
                    break;
            }
            break;
        case 1:
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
            switch ([indexPath row]) {
                case 0:
                    cell = [self configureCellDetailProduct:cell];
                    break;
                case 1:
                    cell = [self configureCellSubDetailProduct:cell];
                    break;
                case 2:
                    cell = [self configureCellDescriptionProduct:cell];
//                    [cell setHidden:YES];
                    break;
                case 3:
                    cell = [self configureCellMapProduct:cell];
                    break;
                case 4:
                    break;
                    
                default:
                    break;
            }
            break;
        case 1:
            identifier = otherProduct;
            cell = [self configureCellOtherProduct:cell Row:indexPath.row];
            break;
        default:
            break;
    }
    
    return cell;
}

-(UITableViewCell*)configureCellDetailProduct:(UITableViewCell*)cell{
    DetailProductCollectionViewCell* cCell = (DetailProductCollectionViewCell*)cell;
    UIImage * image = [UIImage imageWithData:_product.imagen];
    [cCell.image setImage:image];
    
    cCell.name.text = _product.name;
    cCell.resume.text = [NSString stringWithFormat:@"%.2f %@",_product.size,_product.unit];
    [cCell setRate:_product.rate];
    cCell.price.text = [NSString stringWithFormat:@"%.2f", _product.salePrice];
    cCell.trendingPrice.text = [NSString stringWithFormat:@"%.2f", _product.regularPrice];
    
    return cCell;
}


-(UITableViewCell*)configureCellSubDetailProduct:(UITableViewCell*)cell{
    SubDetailProductCollectionViewCell* cCell = (SubDetailProductCollectionViewCell*)cell;
    
//    @property (strong, nonatomic) IBOutlet UILabel *type;
//    @property (strong, nonatomic) IBOutlet UILabel *country;
//    @property (strong, nonatomic) IBOutlet UILabel *serving_size;
//    @property (strong, nonatomic) IBOutlet UILabel *total_volume;
//    @property (strong, nonatomic) IBOutlet UILabel *alcoho_percentaje;
    
    if ([_product.country isEqualToString:@""]) {
        [cCell.labelCountry setHidden:YES];
    }
    cCell.type.text = _product.prouctType;
    cCell.country.text = _product.country;
    cCell.serving_size.text = [NSString stringWithFormat:@"%.2f", _product.size];
    cCell.total_volume.text = @"";
    cCell.alcoho_percentaje.text = @"";
    [cCell.labelVolume setHidden:YES];
    [cCell.labelPercentage setHidden:YES];
    
    
    return cCell;
}

-(UITableViewCell*)configureCellDescriptionProduct:(UITableViewCell*)cell{
    DescriptionProductCollectionViewCell* cCell = (DescriptionProductCollectionViewCell*)cell;
    
    //@property (strong, nonatomic) IBOutlet UILabel *long_description;
    cCell.long_description.text =_product.desc;
    
    return cCell;
}

-(UITableViewCell*)configureCellMapProduct:(UITableViewCell*)cell{
    MapProductCollectionViewCell* cCell = (MapProductCollectionViewCell*)cell;
    
    CLLocation * cccc = [[CLLocation alloc]initWithLatitude: _product.location.latitude longitude: _product.location.longitude];
    
    MKPointAnnotation* annotation= [MKPointAnnotation new];
    annotation.coordinate= [cccc coordinate];
    [cCell.map addAnnotation: annotation];
    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.005;
    span.longitudeDelta = 0.005;
    CLLocationCoordinate2D location;
    location.latitude = _product.location.latitude;
    location.longitude = _product.location.longitude;
    region.span = span;
    region.center = location;
    [cCell.map setRegion:region animated:YES];
    
//    TODO:
//    @property (strong, nonatomic) IBOutlet MKMapView *map;
    
    return cCell;
}

-(UITableViewCell*)configureCellOtherProduct:(UITableViewCell*)cell Row:(NSInteger)row{
    DetailProductCollectionViewCell* cCell = (DetailProductCollectionViewCell*)cell;
    
//    @property (strong, nonatomic) IBOutlet UIImageView *image;
//    @property (strong, nonatomic) IBOutlet UILabel *name;
//    @property (strong, nonatomic) IBOutlet UILabel *resume;
//    @property (strong, nonatomic) IBOutlet UILabel *price;
//    
//    @property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *star;
    Product * other = [_relatedProducts objectAtIndex:row];
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    float height = 80;
    switch (indexPath.section) {
        case 0:
            switch ([indexPath row]) {
                case 0:
                case 1:
                case 2:
                    height =  100;
                    break;
                case 3:
                    height =  200;
                    break;
                case 4:
                    height =  50;
                    break;
                    
                default:
                    break;
            }
            break;
        case 1:
            height =  80;
            break;
        default:
            height =  80;
            break;
    }
    return height;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 1 && indexPath.row > 0) {
//        [self performSegueWithIdentifier:<#(NSString *)#> sender:self];
//    }
}
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showReviews"]) {
        ProductReviewsTableViewController* productController = (ProductReviewsTableViewController*)segue.destinationViewController;
        
        productController.product_id = _product.webid;
    }
    
    if ([[segue identifier] isEqualToString:@"productSelected"]) {
        ProductTableViewController* productController = (ProductTableViewController*)segue.destinationViewController;
        
        productController.product = (Product*)[ _relatedProducts objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
    
}

@end
