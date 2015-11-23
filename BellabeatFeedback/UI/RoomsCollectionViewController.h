//
//  RoomsCollectionViewController.h
//  BellabeatFeedback
//
//  Created by Ivan Fabijanović on 20/11/15.
//  Copyright © 2015 Bellabeat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoomDataStore.h"

@interface RoomsCollectionViewController : UICollectionViewController<RoomDataStoreDelegate, UICollectionViewDelegateFlowLayout>

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout NS_UNAVAILABLE;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil NS_UNAVAILABLE;
- (instancetype)initWithDataStore:(RoomDataStore *)dataStore NS_DESIGNATED_INITIALIZER;

@end
