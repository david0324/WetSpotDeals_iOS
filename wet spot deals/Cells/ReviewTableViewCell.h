//
//  ReviewTableViewCell.h
//  wet spot deals
//
//  Created by KOMI Marketing on 11/05/15.
//  Copyright (c) 2015 KOMI Marketing All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKProfilePictureView.h>

@interface ReviewTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *tagline;

@property (strong, nonatomic) IBOutlet UILabel *reviewDesc;
@property (strong, nonatomic) IBOutlet UITextField *rateTxt;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *stars;
@property (strong, nonatomic) IBOutlet FBSDKProfilePictureView *profilePicture;

@property (strong, nonatomic) IBOutlet UILabel *user_name;
@property (strong, nonatomic) IBOutlet UILabel *date_label;

-(void) setRate:(float)rate;
@end
