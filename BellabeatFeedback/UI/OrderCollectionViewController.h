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

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout NS_UNAVAILABLE;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil NS_UNAVAILABLE;
- (instancetype)initWithRoomDataStore:(RoomDataStore *)dataStore room:(RoomModel *)room NS_DESIGNATED_INITIALIZER;

@end
