//
//  RoomsCollectionViewCell.m
//  BellabeatFeedback
//
//  Created by Ivan Fabijanović on 20/11/15.
//  Copyright © 2015 Bellabeat. All rights reserved.
//

#import "RoomsCollectionViewCell.h"
#import "RoomModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation RoomsCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    RAC(self, roomTitleLabel.text) = RACObserve(self, room.name);
}

@end
