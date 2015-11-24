//
//  MessageModel.m
//  BellabeatFeedback
//
//  Created by Ivan Fabijanović on 20/11/15.
//  Copyright © 2015 Bellabeat. All rights reserved.
//

#import "MessageModel.h"
#import "MessageDataStore.h"

#define kKeyMessage         @"message"
#define kKeySender          @"sender"
#define kKeyPoints          @"points"
#define kKeyTotalActivity   @"totalActivity"
#define kKeyTimestamp       @"timestamp"
#define kKeyVotes           @"votes"

#define kValueUpvoted       @"u"
#define kValueNeutral       @"n"
#define kValueDownvoted     @"d"

@interface MessageModel()

@property (nonatomic, weak) MessageDataStore *dataStore;

@end

@implementation MessageModel

#pragma mark - Init

- (instancetype)initWithDataStore:(MessageDataStore *)dataStore senderId:(NSString *)senderId {
    NSParameterAssert(dataStore);
    NSParameterAssert(senderId);
    
    self = [super init];
    if (self) {
        self.dataStore = dataStore;
        
        self.key = [[NSUUID UUID] UUIDString];
        self.sender = senderId;
        self.points = 1;
        self.totalActivity = 1;
        self.votes = [NSMutableDictionary dictionary];
        
        [self.votes setObject:@"u" forKey:senderId];
    }
    return self;
}

- (instancetype)initWithDataStore:(MessageDataStore *)dataStore key:(NSString *)key value:(NSDictionary *)dictionary {
    NSParameterAssert(dataStore);
    NSParameterAssert(key);
    NSParameterAssert(dictionary);
    
    self = [super init];
    if (self) {
        self.dataStore = dataStore;
        
        self.key = key;
        [self updateWithDictionary:dictionary];
        
        if (!self.votes) {
            self.votes = [NSMutableDictionary dictionary];
        }
    }
    return self;
}

- (void)dealloc {
    NSLog(@"Message %@ dealloc", self.key);
}

#pragma mark - Public methods

- (void)updateWithDictionary:(NSDictionary *)dictionary {
    self.message = [dictionary objectForKey:kKeyMessage];
    self.sender = [dictionary objectForKey:kKeySender];
    self.points = [[dictionary objectForKey:kKeyPoints] integerValue];
    self.totalActivity = [[dictionary objectForKey:kKeyTotalActivity] integerValue];
    self.timestamp = [NSDate dateWithTimeIntervalSince1970:[[dictionary objectForKey:kKeyTimestamp] doubleValue]];
    self.votes = [[dictionary objectForKey:kKeyVotes] mutableCopy];
}

- (NSDictionary *)serialize {
    return @{
             self.key: @{
                     kKeyMessage: self.message,
                     kKeySender: self.sender,
                     kKeyPoints: @(self.points),
                     kKeyTotalActivity: @(self.totalActivity),
                     kKeyTimestamp: @([self.timestamp timeIntervalSince1970]),
                     kKeyVotes: self.votes
                     }
             };
}

- (BOOL)didUpvoteForUserId:(NSString *)userId {
    NSString *vote = [self.votes objectForKey:userId];
    return [vote isEqualToString:kValueUpvoted];
}

- (void)upvoteForUserId:(NSString *)userId {
    if ([self didUpvoteForUserId:userId]) {
        // Already upvoted, reverse upvote
        self.points--;
        self.totalActivity--;
        [self.votes setObject:kValueNeutral forKey:userId];
    } else if ([self didDownvoteForUserId:userId]) {
        // Downvoted, reverse downvote
        self.points++;
        self.totalActivity--;
        [self.votes setObject:kValueNeutral forKey:userId];
    } else {
        // Neutral position, upvote
        self.points++;
        self.totalActivity++;
        [self.votes setObject:kValueUpvoted forKey:userId];
    }
    
    [self.dataStore saveMessage:self];
}

- (BOOL)didDownvoteForUserId:(NSString *)userId {
    NSString *vote = [self.votes objectForKey:userId];
    return [vote isEqualToString:kValueDownvoted];
}

- (void)downvoteForUserId:(NSString *)userId {
    if ([self didDownvoteForUserId:userId]) {
        // Already downvoted, reverse downvote
        self.points++;
        self.totalActivity--;
        [self.votes setObject:kValueNeutral forKey:userId];
    } else if ([self didUpvoteForUserId:userId]) {
        // Upvoted, reverse upvote
        self.points--;
        self.totalActivity--;
        [self.votes setObject:kValueNeutral forKey:userId];
    } else {
        // Neutral position, downvote
        self.points--;
        self.totalActivity++;
        [self.votes setObject:kValueDownvoted forKey:userId];
    }
    
    [self.dataStore saveMessage:self];
}

@end
