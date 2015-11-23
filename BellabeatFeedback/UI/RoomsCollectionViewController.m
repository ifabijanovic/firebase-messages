//
//  RoomsCollectionViewController.m
//  BellabeatFeedback
//
//  Created by Ivan Fabijanović on 20/11/15.
//  Copyright © 2015 Bellabeat. All rights reserved.
//

#import "RoomsCollectionViewController.h"
#import "RoomsCollectionViewCell.h"
#import "OrderCollectionViewController.h"

@interface RoomsCollectionViewController ()

@property (nonatomic, strong) RoomDataStore *dataStore;

@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation RoomsCollectionViewController

#pragma mark - Init

- (instancetype)initWithDataStore:(RoomDataStore *)dataStore {
    NSParameterAssert(dataStore);
    
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
    if (self) {
        self.dataStore = dataStore;
        self.dataStore.delegate = self;
        
        self.data = [NSMutableArray array];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"RoomsCollectionViewContorller dealloc");
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([RoomsCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kRoomCellIdentifier];
    
    self.title = @"Rooms";
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
    return self.data.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width, 100.0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RoomsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kRoomCellIdentifier forIndexPath:indexPath];
    cell.room = [self.data objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    RoomModel *room = [self.data objectAtIndex:indexPath.row];
    OrderCollectionViewController *vc = [[OrderCollectionViewController alloc] initWithRoomDataStore:self.dataStore room:room];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - RoomDataStoreDelegate

- (void)roomDataStore:(RoomDataStore *)dataStore didAddRoom:(RoomModel *)room {
    [self.data addObject:room];
    NSInteger newIndex = self.data.count - 1;
    [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:newIndex inSection:0]]];
}

@end
