//
//  DetailProductCollectionViewCell.h
//  wet spot deals
//
//  Created by KOMI Marketing on 24/04/15.
//  Copyright (c) 2015 KOMI Marketing All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddReviewDelegate <NSObject>

- (void)addReview;
- (void)shareReview;
@end

@interface DetailProductCollectionViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *resume;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UITextField *rateTxt;
@property (strong, nonatomic) IBOutlet UILabel *trendingPrice;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *stars;

@property (nonatomic, weak) id <AddReviewDelegate> delegate;

-(void) setRate:(float)rate;
- (IBAction)addReview:(id)sender;
- (IBAction)shareReview:(id)sender;

@end
