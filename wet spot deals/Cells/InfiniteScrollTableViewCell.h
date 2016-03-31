//
//  InfiniteScrollTableViewCell.h
//  wet spot deals
//
//  Created by KOMI Marketing on 13/04/15.
//  Copyright (c) 2015 KOMI Marketing All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InfiniteScrollTableViewCellDelegate <NSObject>

-(void)updateObjects;

@end

@interface InfiniteScrollTableViewCell : UITableViewCell

@property(weak,nonatomic)id<InfiniteScrollTableViewCellDelegate> delegate;

@end
