//
//  SubDetailProductCollectionViewCell.h
//  wet spot deals
//
//  Created by KOMI Marketing on 24/04/15.
//  Copyright (c) 2015 KOMI Marketing All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubDetailProductCollectionViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *type;
@property (strong, nonatomic) IBOutlet UILabel *country;
@property (strong, nonatomic) IBOutlet UILabel *serving_size;
@property (strong, nonatomic) IBOutlet UILabel *total_volume;
@property (strong, nonatomic) IBOutlet UILabel *alcoho_percentaje;
@property (strong, nonatomic) IBOutlet UILabel *labelType;
@property (strong, nonatomic) IBOutlet UILabel *labelCountry;
@property (strong, nonatomic) IBOutlet UILabel *labelSize;
@property (strong, nonatomic) IBOutlet UILabel *labelVolume;
@property (strong, nonatomic) IBOutlet UILabel *labelPercentage;

@end
