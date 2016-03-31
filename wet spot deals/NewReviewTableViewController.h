//
//  NewReviewTableViewController.h
//  wet spot deals
//
//  Created by KOMI Marketing on 31/03/15.
//  Copyright (c) 2015 KOMI Marketing All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKProfilePictureView.h>
@class Review;

@protocol NewReviewDelegate <NSObject>

-(void)addReview:(Review*)review;

@end

@interface NewReviewTableViewController : UITableViewController

@property (strong, nonatomic) id <NewReviewDelegate> delegate;
@property (strong, nonatomic) IBOutlet UITableViewCell *bottomReviewCell;

@property (strong, nonatomic) IBOutlet UITextField *taglineTxt;
@property ( nonatomic) int  inventoryID;
@property (strong, nonatomic) IBOutlet UITextField *rateTxt;
@property (strong, nonatomic) IBOutlet UITextView *messageTxt;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *stars;

@property (strong, nonatomic) IBOutlet FBSDKProfilePictureView *facebookProfile;
@property (strong, nonatomic) IBOutlet UILabel *nameTxt;

- (IBAction)rateChange:(id)sender;
- (IBAction)star1:(id)sender;
- (IBAction)star2:(id)sender;
- (IBAction)star3:(id)sender;
- (IBAction)star4:(id)sender;
- (IBAction)star5:(id)sender;
- (IBAction)sendReview:(id)sender;

@end
