//
//  roundedButton.m
//  wet spot deals
//
//  Created by KOMI Marketing on 31/03/15.
//  Copyright (c) 2015 KOMI Marketing All rights reserved.
//

#import "roundedButton.h"
#define DEFAULT_CORNER_RADIUS                5
@implementation roundedButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.layer.cornerRadius = DEFAULT_CORNER_RADIUS; // this value vary as per your desire
        self.clipsToBounds = YES;
    }
    return self;
}

-(instancetype)init{
    if (self = [super init]) {
        self.layer.cornerRadius = DEFAULT_CORNER_RADIUS; // this value vary as per your desire
        self.clipsToBounds = YES;
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = DEFAULT_CORNER_RADIUS; // this value vary as per your desire
        self.clipsToBounds = YES;
    }
    return self;
}
@end
