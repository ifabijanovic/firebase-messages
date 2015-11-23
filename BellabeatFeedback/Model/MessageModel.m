//
//  MessageModel.m
//  BellabeatFeedback
//
//  Created by Ivan Fabijanović on 20/11/15.
//  Copyright © 2015 Bellabeat. All rights reserved.
//

#import "MessageModel.h"
#import "MessageDataStore.h"

@interface MessageModel()

@property (nonatomic, weak) MessageDataStore *dataStore;

@end

@implementation MessageModel

#pragma mark - Init

- (instancetype)initWithDataStore:(MessageDataStore *)dataStore {
    NSParameterAssert(dataStore);
    
    self = [super init];
    if (self) {
        self.dataStore = dataStore;
        
        self.key = [[NSUUID UUID] UUIDString];
        self.sender = kCurrentUser;
        self.points = 1;
        self.votes = [NSMutableDictionary dictionary];
        
        [self.votes setObject:@"u" forKey:kCurrentUser];
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
    self.message = [dictionary objectForKey:@"message"];
    self.sender = [dictionary objectForKey:@"sender"];
    self.points = [[dictionary objectForKey:@"points"] integerValue];
    self.timestamp = [NSDate dateWithTimeIntervalSince1970:[[dictionary objectForKey:@"timestamp"] doubleValue]];
    self.votes = [[dictionary objectForKey:@"votes"] mutableCopy];
}

- (NSDictionary *)serialize {
    return @{
             self.key: @{
                     @"message": self.message,
                     @"sender": self.sender,
                     @"points": @(self.points),
                     @"timestamp": @([self.timestamp timeIntervalSince1970]),
                     @"votes": self.votes
                     }
             };
}

- (BOOL)didUpvote {
    NSString *vote = [self.votes objectForKey:kCurrentUser];
    return [vote isEqualToString:@"u"];
}

- (void)upvote {
    if ([self didUpvote]) {
        self.points--;
        [self.votes setObject:@"n" forKey:kCurrentUser];
    } else if ([self didDownvote]) {
        self.points += 2;
        [self.votes setObject:@"u" forKey:kCurrentUser];
    } else {
        self.points++;
        [self.votes setObject:@"u" forKey:kCurrentUser];
    }
    
    [self.dataStore saveMessage:self];
}

- (BOOL)didDownvote {
    NSString *vote = [self.votes objectForKey:kCurrentUser];
    return [vote isEqualToString:@"d"];
}

- (void)downvote {
    if ([self didDownvote]) {
        self.points++;
        [self.votes setObject:@"n" forKey:kCurrentUser];
    } else if ([self didUpvote]) {
        self.points -= 2;
        [self.votes setObject:@"d" forKey:kCurrentUser];
    } else {
        self.points--;
        [self.votes setObject:@"d" forKey:kCurrentUser];
    }
    
    [self.dataStore saveMessage:self];
}

@end
