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

@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation RoomDataStore

#pragma mark - Init

- (instancetype)initWithRoot:(Firebase *)root {
    NSParameterAssert(root);
    
    self = [super init];
    if (self) {
        self.root = root;
        self.rooms = [root childByAppendingPath:@"rooms"];
        
        self.data = [NSMutableArray array];
        
        __weak typeof(self) weakSelf = self;
        [self.rooms observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
            if (snapshot.value && snapshot.value != [NSNull null]) {
                RoomModel *model = [[RoomModel alloc] initWithKey:snapshot.key value:snapshot.value];
                [weakSelf.data addObject:model];
                
                if ([weakSelf.delegate respondsToSelector:@selector(roomDataStore:didAddRoom:)]) {
                    [weakSelf.delegate roomDataStore:weakSelf didAddRoom:model];
                }
            }
        }];
    }
    return self;
}

- (void)dealloc {
    [self.rooms removeAllObservers];
}

#pragma mark - Public methods

- (NSArray<RoomModel *> *)allRooms {
    return self.data;
}

- (MessageDataStore *)messageDataStoreForRoom:(RoomModel *)room order:(MessageOrderModel *)order {
    return [[MessageDataStore alloc] initWithRoot:self.root forRoom:room order:order];
}

@end
