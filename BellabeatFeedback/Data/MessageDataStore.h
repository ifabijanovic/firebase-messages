//
//  MessageDataStore.h
//  BellabeatFeedback
//
//  Created by Ivan Fabijanović on 20/11/15.
//  Copyright © 2015 Bellabeat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Firebase/Firebase.h>
#import "MessageModel.h"

@class MessageDataStore;
@class RoomModel;

@protocol MessageDataStoreDelegate <NSObject>

- (void)messageDataStore:(MessageDataStore *)dataStore didAddMessage:(MessageModel *)message;
- (void)messageDataStore:(MessageDataStore *)dataStore didUpdateMessage:(MessageModel *)message;
- (void)messageDataStore:(MessageDataStore *)dataStore didRemoveMessage:(MessageModel *)message;

@end

@interface MessageDataStore : NSObject

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithRoot:(Firebase *)root forRoom:(RoomModel *)room type:(NSString *)type;

@property (nonatomic, weak) id<MessageDataStoreDelegate> delegate;

- (MessageModel *)newMessage;
- (void)saveMessage:(MessageModel *)message;

@end
