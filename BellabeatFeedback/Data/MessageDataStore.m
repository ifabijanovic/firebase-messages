//
//  MessageDataStore.m
//  BellabeatFeedback
//
//  Created by Ivan Fabijanović on 20/11/15.
//  Copyright © 2015 Bellabeat. All rights reserved.
//

#import "MessageDataStore.h"
#import "MessageModel.h"
#import "RoomModel.h"

@interface MessageDataStore()

@property (nonatomic, strong) Firebase *root;
@property (nonatomic, strong) Firebase *messages;

@property (nonatomic, strong) NSMutableDictionary *data;

@end

@implementation MessageDataStore

#pragma mark - Init

- (instancetype)initWithRoot:(Firebase *)root forRoom:(RoomModel *)room {
    NSParameterAssert(root);
    NSParameterAssert(room);
    
    self = [super init];
    if (self) {
        self.root = root;
        
        NSString *path = [NSString stringWithFormat:@"messages/%@", room.key];
        self.messages = [root childByAppendingPath:path];
        
        self.data = [NSMutableDictionary dictionary];
        
        __weak typeof(self) weakSelf = self;
        [self.messages observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
            if (snapshot.value && snapshot.value != [NSNull null]) {
                MessageModel *model = [[MessageModel alloc] initWithDataStore:weakSelf key:snapshot.key value:snapshot.value];
                [weakSelf.data setValue:model forKey:model.key];
                
                if ([weakSelf.delegate respondsToSelector:@selector(messageDataStore:didAddMessage:)]) {
                    [weakSelf.delegate messageDataStore:weakSelf didAddMessage:model];
                }
            }
        }];
        
        [self.messages observeEventType:FEventTypeChildChanged withBlock:^(FDataSnapshot *snapshot) {
            if (snapshot && snapshot.value != [NSNull null]) {
                MessageModel *model = [weakSelf.data objectForKey:snapshot.key];
                [model updateWithDictionary:snapshot.value];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:kMessageDidChangeNotification object:model];
                
                if ([weakSelf.delegate respondsToSelector:@selector(messageDataStore:didUpdateMessage:)]) {
                    [weakSelf.delegate messageDataStore:weakSelf didUpdateMessage:model];
                }
            }
        }];
        
        [self.messages observeEventType:FEventTypeChildRemoved withBlock:^(FDataSnapshot *snapshot) {
            if (snapshot && snapshot.value != [NSNull null]) {
                MessageModel *model = [weakSelf.data objectForKey:snapshot.key];
                [weakSelf.data removeObjectForKey:model.key];
                
                if ([weakSelf.delegate respondsToSelector:@selector(messageDataStore:didRemoveMessage:)]) {
                    [weakSelf.delegate messageDataStore:weakSelf didRemoveMessage:model];
                }
            }
        }];
    }
    return self;
}

- (void)dealloc {
    [self.messages removeAllObservers];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    NSLog(@"MessageDataStore dealloc");
}

#pragma mark - Public methods

- (MessageModel *)newMessage {
    return [[MessageModel alloc] initWithDataStore:self];
}

- (void)saveMessage:(MessageModel *)message {
    [self.messages updateChildValues:[message serialize]];
}

@end
