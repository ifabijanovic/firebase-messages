//
//  RoomsCollectionViewCell.h
//  BellabeatFeedback
//
//  Created by Ivan Fabijanović on 20/11/15.
//  Copyright © 2015 Bellabeat. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RoomModel;

#define kRoomCellIdentifier @"roomCell"

@interface RoomsCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *roomTitleLabel;

@property (nonatomic, strong) RoomModel *room;

@end
