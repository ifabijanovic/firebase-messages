//
//  OrderCollectionViewController.h
//  BellabeatFeedback
//
//  Created by Ivan Fabijanović on 23/11/15.
//  Copyright © 2015 Bellabeat. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RoomModel;
@class RoomDataStore;

@interface OrderCollectionViewController : UICollectionViewController <UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) RoomModel *room;
@property (nonatomic, strong) RoomDataStore *dataStore;

@end
