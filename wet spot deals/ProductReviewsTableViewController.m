//
//  ProductReviewsTableViewController.m
//  wet spot deals
//
//  Created by KOMI Marketing on 31/03/15.
//  Copyright (c) 2015 KOMI Marketing All rights reserved.
//

#import "ProductReviewsTableViewController.h"
#import "RestManager.h"
#import "Review.h"
#import "SVProgressHUD.h"
#import "ReviewTableViewCell.h"
#import <FBSDKCoreKit/FBSDKAccessToken.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import "Constants.h"

@interface ProductReviewsTableViewController ()

@end

@implementation ProductReviewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    
    
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [RestManager getProductsWhitId:[_product_id intValue] CallBack:^(Product *product) {

            dispatch_async(dispatch_get_main_queue(), ^{
                _product = product;
                [self.tableView reloadData];
                [SVProgressHUD dismiss];
                
            });
        }];
        
    });
    
    
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
    if (section == 1) {
        if(_product != nil){
            return [_product.reviews count];
        }else{
            return 0;
        }
    }
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    NSString *reviewProduct = @"reviewProduct";
    NSString *titleReviewsProduct = @"titleReviewsProduct";
    NSString *detailProduct = @"detailProduct";
    NSString *identifier ;
    
    switch (indexPath.section) {
        case 0:
            
            switch ([indexPath row]) {
                case 0:
                    identifier = detailProduct;
                    break;
                case 1:
                    identifier = titleReviewsProduct;
                    break;
                default:
                    identifier = reviewProduct;
                    break;
            }
            break;
        case 1:
            identifier = reviewProduct;
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
                default:
                    break;
            }
            break;
        case 1:
            cell = [self configureCellReviewProduct:cell WithPosition:[indexPath row]];
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
    cCell.delegate = self;
    return cCell;
}

-(UITableViewCell*)configureCellReviewProduct:(UITableViewCell*)cell WithPosition:(int)position{
    ReviewTableViewCell* cCell = (ReviewTableViewCell*)cell;
    Review *review = [_product.reviews objectAtIndex:position];
    cCell.tagline.text = review.tagline;
    cCell.reviewDesc.text = review.desc;
    [cCell setRate:review.rate];
    [cCell.profilePicture setProfileID:review.userFacebookId];
    cCell.user_name.text = review.user_name;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMMM, dd yyyy"];
    cCell.date_label.text = [dateFormatter stringFromDate:review.date];
    
    return cCell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float height = 110;
    switch (indexPath.section) {
        case 0:
            switch ([indexPath row]) {
                case 0:
                    height = 100;
                    break;
                default:
                    height =  50;
                    break;
            }
            break;
        default:
            height =  110;
            break;
    }
    return height;
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
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"viewToAddReview"]) {
        NewReviewTableViewController * newReviewView = (NewReviewTableViewController*)segue.destinationViewController;
        newReviewView.inventoryID = [_product.webidProduct integerValue];
        newReviewView.delegate = self;
    }
}

- (void)addReview:(Review*)review{
    
    [_product.reviews insertObject:review atIndex:0];
    [self.tableView reloadData];
}

- (void)addReview{
    
    if ([FBSDKAccessToken currentAccessToken]) {
        [self performSegueWithIdentifier:@"viewToAddReview" sender:self];
        
    }else{
        [self performSegueWithIdentifier:@"popToFacebook" sender:self];
    }
}

-(void)shareReview{
    if ([FBSDKAccessToken currentAccessToken]) {
        UIImage *image = [UIImage imageWithData:_product.imagen];
        
        FBSDKSharePhoto *photo = [[FBSDKSharePhoto alloc] init];
        photo.image = image;
        photo.userGenerated = YES;
        FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc] init];
        content.photos = @[photo];
        content.contentURL = [NSURL URLWithString:urlServer];
        
        
        FBSDKShareDialog *shareDialog = [[FBSDKShareDialog alloc] init];
        shareDialog.fromViewController = self;
        shareDialog.shareContent = content;
        
        shareDialog.mode = FBSDKShareDialogModeShareSheet;
        
        
        if (![shareDialog canShow]) {
            // update the app UI accordingly
            
            [shareDialog show];
        }
        NSError *error;
        if (![shareDialog validateWithError:&error]) {
            NSLog(@"%@",error);
            // check the error for explanation of invalid content
        }
        
//        [FBSDKShareAPI shareWithContent:content delegate:nil];
//
//        [FBSDKShareDialog showFromViewController:self
//                                     withContent:content
//                                        delegate:nil];
//        [FBSDKMessageDialog showWithContent:content delegate:nil];
        
//        [self performSegueWithIdentifier:@"viewToAddReview" sender:self];
        
    }else{
        [self performSegueWithIdentifier:@"popToFacebook" sender:self];
    }
}

@end
