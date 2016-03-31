//
//  ProductReviewsTableViewController.h
//  wet spot deals
//
//  Created by KOMI Marketing on 31/03/15.
//  Copyright (c) 2015 KOMI Marketing All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "DetailProductCollectionViewCell.h"
#import "NewReviewTableViewController.h"

@interface ProductReviewsTableViewController : UITableViewController<AddReviewDelegate,NewReviewDelegate >

@property(strong,nonatomic) NSString* product_id;
@property(strong,nonatomic) Product* product;


@end
