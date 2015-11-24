//
//  MessageModel.h
//  BellabeatFeedback
//
//  Created by Ivan Fabijanović on 20/11/15.
//  Copyright © 2015 Bellabeat. All rights reserved.
//

#import "ModelBase.h"

@class MessageDataStore;

@interface MessageModel : ModelBase

@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *sender;
@property (nonatomic, assign) NSInteger points;
@property (nonatomic, assign) NSInteger totalActivity;
@property (nonatomic, strong) NSDate *timestamp;
@property (nonatomic, strong) NSMutableDictionary *votes;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithDataStore:(MessageDataStore *)dataStore senderId:(NSString *)senderId NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithDataStore:(MessageDataStore *)dataStore key:(NSString *)key value:(NSDictionary *)dictionary NS_DESIGNATED_INITIALIZER;

- (BOOL)didUpvoteForUserId:(NSString *)userId;
- (void)upvoteForUserId:(NSString *)userId;

- (BOOL)didDownvoteForUserId:(NSString *)userId;
- (void)downvoteForUserId:(NSString *)userId;

@end
