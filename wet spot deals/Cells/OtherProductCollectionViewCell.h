//
//  OtherProductCollectionViewCell.h
//  wet spot deals
//
//  Created by KOMI Marketing on 24/04/15.
//  Copyright (c) 2015 KOMI Marketing All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OtherProductCollectionViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *resume;
@property (strong, nonatomic) IBOutlet UILabel *price;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *star;

-(void) setRate:(float)rate;

@end
