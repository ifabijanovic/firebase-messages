//
//  OrderCollectionViewCell.h
//  BellabeatFeedback
//
//  Created by Ivan Fabijanović on 23/11/15.
//  Copyright © 2015 Bellabeat. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MessageOrderModel;

#define kOrderCellIdentifier @"orderCell"

@interface OrderCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *orderTitleLabel;

@property (nonatomic, strong) MessageOrderModel *order;

@end
