//
//  OrderCollectionViewController.m
//  BellabeatFeedback
//
//  Created by Ivan Fabijanović on 23/11/15.
//  Copyright © 2015 Bellabeat. All rights reserved.
//

#import "OrderCollectionViewController.h"
#import "OrderCollectionViewCell.h"
#import "RoomModel.h"
#import "RoomDataStore.h"
#import "MessageDataStore.h"
#import "TopMessageSorter.h"
#import "NewMessageSorter.h"
#import "MessagesCollectionViewController.h"

@interface OrderCollectionViewController ()

@property (nonatomic, strong) RoomModel *room;
@property (nonatomic, strong) RoomDataStore *dataStore;

@property (nonatomic, strong) NSArray *sorters;

@end

@implementation OrderCollectionViewController

#pragma mark - Init

- (instancetype)initWithRoomDataStore:(RoomDataStore *)dataStore room:(RoomModel *)room {
    NSParameterAssert(dataStore);
    NSParameterAssert(room);
    
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
    if (self) {
        self.dataStore = dataStore;
        self.room = room;
        
        self.title = room.name;
        self.sorters = @[
                        [[TopMessageSorter alloc] init],
                        [[NewMessageSorter alloc] init]
                        ];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"OrderCollectionViewController dealloc");
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([OrderCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kOrderCellIdentifier];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.sorters.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width, 100.0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    OrderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kOrderCellIdentifier forIndexPath:indexPath];
    cell.sorter = [self.sorters objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    MessageSorter *sorter = [self.sorters objectAtIndex:indexPath.row];
    MessageDataStore *messageDataStore = [self.dataStore messageDataStoreForRoom:self.room sorter:sorter];
    
    MessagesCollectionViewController *vc = [[MessagesCollectionViewController alloc] initWithDataStore:messageDataStore];
    vc.title = [NSString stringWithFormat:@"%@ - %@", self.room.name, sorter.title];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
