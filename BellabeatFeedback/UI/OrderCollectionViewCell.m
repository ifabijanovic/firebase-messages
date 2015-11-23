//
//  OrderCollectionViewCell.m
//  BellabeatFeedback
//
//  Created by Ivan Fabijanović on 23/11/15.
//  Copyright © 2015 Bellabeat. All rights reserved.
//

#import "OrderCollectionViewCell.h"
#import "MessageOrderModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation OrderCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    RAC(self.orderTitleLabel, text) = RACObserve(self, order.title);
}

- (void)dealloc {
    NSLog(@"OrderCollectionViewCell dealloc");
}

@end
