//
//  RoomDataStore.h
//  BellabeatFeedback
//
//  Created by Ivan Fabijanović on 20/11/15.
//  Copyright © 2015 Bellabeat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Firebase/Firebase.h>
#import "RoomModel.h"

@class RoomDataStore;
@class MessageDataStore;

@protocol RoomDataStoreDelegate <NSObject>

- (void)roomDataStore:(RoomDataStore *)dataStore didAddRoom:(RoomModel *)room;

@end

@interface RoomDataStore : NSObject

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithRoot:(Firebase *)root;

@property (nonatomic, weak) id<RoomDataStoreDelegate> delegate;

- (NSArray<RoomModel *> *)allRooms;

- (MessageDataStore *)messageDataStoreForRoom:(RoomModel *)room type:(NSString *)type;

@end
