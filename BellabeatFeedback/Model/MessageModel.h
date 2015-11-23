//
//  MessageModel.h
//  BellabeatFeedback
//
//  Created by Ivan Fabijanović on 20/11/15.
//  Copyright © 2015 Bellabeat. All rights reserved.
//

#import "ModelBase.h"

#warning GLOBAL USER DECLARATION
#define kCurrentUser @"u2"

@class MessageDataStore;

@interface MessageModel : ModelBase

@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *sender;
@property (nonatomic, assign) NSInteger points;
@property (nonatomic, strong) NSDate *timestamp;
@property (nonatomic, strong) NSMutableDictionary *votes;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithDataStore:(MessageDataStore *)dataStore NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithDataStore:(MessageDataStore *)dataStore key:(NSString *)key value:(NSDictionary *)dictionary NS_DESIGNATED_INITIALIZER;

- (BOOL)didUpvote;
- (void)upvote;

- (BOOL)didDownvote;
- (void)downvote;

@end
