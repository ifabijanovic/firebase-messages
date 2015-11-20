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

- (instancetype)initWithDataStore:(MessageDataStore *)dataStore NS_DESIGNATED_INITIALIZER;

@end
