//
//  MessagesCollectionViewController.h
//  BellabeatFeedback
//
//  Created by Ivan Fabijanović on 20/11/15.
//  Copyright © 2015 Bellabeat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageDataStore.h"

@interface MessagesCollectionViewController : UICollectionViewController<MessageDataStoreDelegate, UICollectionViewDelegateFlowLayout>

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout NS_UNAVAILABLE;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil NS_UNAVAILABLE;
- (instancetype)initWithDataStore:(MessageDataStore *)dataStore userId:(NSString *)userId NS_DESIGNATED_INITIALIZER;

@end
