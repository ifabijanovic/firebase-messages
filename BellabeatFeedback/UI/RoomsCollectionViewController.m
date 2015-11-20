//
//  RoomsCollectionViewController.m
//  BellabeatFeedback
//
//  Created by Ivan Fabijanović on 20/11/15.
//  Copyright © 2015 Bellabeat. All rights reserved.
//

#import "RoomsCollectionViewController.h"
#import "RoomsCollectionViewCell.h"
#import "RoomDataStore.h"

#import "MessageDataStore.h"
#import "MessagesCollectionViewController.h"

@interface RoomsCollectionViewController ()

@property (nonatomic, strong) RoomDataStore *dataStore;

@end

@implementation RoomsCollectionViewController

#pragma mark - Init

- (instancetype)initWithDataStore:(RoomDataStore *)dataStore {
    NSParameterAssert(dataStore);
    
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
    if (self) {
        self.dataStore = dataStore;
        self.dataStore.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([RoomsCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kRoomCellIdentifier];
    
    self.title = @"Rooms";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    [self.collectionViewLayout invalidateLayout];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    [self.collectionViewLayout invalidateLayout];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataStore.allRooms.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width, 100.0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RoomsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kRoomCellIdentifier forIndexPath:indexPath];
    cell.room = [self.dataStore.allRooms objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    RoomModel *room = [self.dataStore.allRooms objectAtIndex:indexPath.row];
    MessageDataStore *messageDataStore = [self.dataStore messageDataStoreForRoom:room];
    
    MessagesCollectionViewController *vc = [[MessagesCollectionViewController alloc] initWithDataStore:messageDataStore];
    vc.title = room.name;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - RoomDataStoreDelegate

- (void)roomDataStore:(RoomDataStore *)dataStore didAddRoom:(RoomModel *)room {
    NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:0];
    [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:numberOfItems inSection:0]]];
}

@end
