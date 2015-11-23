//
//  RoomDataStore.m
//  BellabeatFeedback
//
//  Created by Ivan Fabijanović on 20/11/15.
//  Copyright © 2015 Bellabeat. All rights reserved.
//

#import "RoomDataStore.h"
#import "MessageDataStore.h"
#import "MessageOrderModel.h"

@interface RoomDataStore()

@property (nonatomic, strong) Firebase *root;
@property (nonatomic, strong) Firebase *rooms;

@property (nonatomic, strong) NSMutableDictionary *data;

@end

@implementation RoomDataStore

#pragma mark - Init

- (instancetype)initWithRoot:(Firebase *)root {
    NSParameterAssert(root);
    
    self = [super init];
    if (self) {
        self.root = root;
        self.rooms = [root childByAppendingPath:@"rooms"];
        
        self.data = [NSMutableDictionary dictionary];
        
        FQuery *query = [self.rooms queryOrderedByChild:@"name"];
        
        __weak typeof(self) weakSelf = self;
        [query observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
            if (snapshot.value && snapshot.value != [NSNull null]) {
                RoomModel *model = [[RoomModel alloc] initWithKey:snapshot.key value:snapshot.value];
                [weakSelf.data setObject:model forKey:model.key];
                
                if ([weakSelf.delegate respondsToSelector:@selector(roomDataStore:didAddRoom:)]) {
                    [weakSelf.delegate roomDataStore:weakSelf didAddRoom:model];
                }
            }
        }];
        
        [query observeEventType:FEventTypeChildChanged withBlock:^(FDataSnapshot *snapshot) {
            if (snapshot.value && snapshot.value != [NSNull null]) {
                RoomModel *model = [weakSelf.data objectForKey:snapshot.key];
                [model updateWithDictionary:snapshot.value];
                
                if ([weakSelf.delegate respondsToSelector:@selector(roomDataStore:didUpdateRoom:)]) {
                    [weakSelf.delegate roomDataStore:weakSelf didUpdateRoom:model];
                }
            }
        }];
        
        [query observeEventType:FEventTypeChildRemoved withBlock:^(FDataSnapshot *snapshot) {
            if (snapshot.value && snapshot.value != [NSNull null]) {
                RoomModel *model = [weakSelf.data objectForKey:snapshot.key];
                [weakSelf.data removeObjectForKey:model.key];
                
                if ([weakSelf.delegate respondsToSelector:@selector(roomDataStore:didRemoveRoom:)]) {
                    [weakSelf.delegate roomDataStore:weakSelf didRemoveRoom:model];
                }
            }
        }];
    }
    return self;
}

- (void)dealloc {
    [self.rooms removeAllObservers];
    
    NSLog(@"RoomDataStore dealloc");
}

#pragma mark - Public methods

- (MessageDataStore *)messageDataStoreForRoom:(RoomModel *)room order:(MessageOrderModel *)order {
    return [[MessageDataStore alloc] initWithRoot:self.root forRoom:room order:order];
}

@end
