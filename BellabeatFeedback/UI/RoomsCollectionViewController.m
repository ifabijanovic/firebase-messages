//
//  RoomsCollectionViewController.m
//  BellabeatFeedback
//
//  Created by Ivan Fabijanović on 20/11/15.
//  Copyright © 2015 Bellabeat. All rights reserved.
//

#import "RoomsCollectionViewController.h"
#import "RoomsCollectionViewCell.h"
#import "LoadingCollectionViewFooterView.h"

#import "MessageDataStore.h"
#import "MessagesCollectionViewController.h"

@interface RoomsCollectionViewController ()

@property (nonatomic, strong) RoomDataStore *dataStore;
@property (nonatomic, copy) NSString *userId;

@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, assign) BOOL didLoad;

@end

@implementation RoomsCollectionViewController

#pragma mark - Init

- (instancetype)initWithDataStore:(RoomDataStore *)dataStore userId:(NSString *)userId {
    NSParameterAssert(dataStore);
    NSParameterAssert(userId);
    
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
    if (self) {
        self.dataStore = dataStore;
        self.dataStore.delegate = self;
        self.userId = userId;
        
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
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LoadingCollectionViewFooterView class]) bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kLoadingViewIdentifier];
    
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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return self.didLoad ? CGSizeZero : CGSizeMake(collectionView.frame.size.width, 77.0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RoomsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kRoomCellIdentifier forIndexPath:indexPath];
    cell.room = [self.data objectAtIndex:indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionFooter) {
        return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kLoadingViewIdentifier forIndexPath:indexPath];
    }
    
    return [[UICollectionReusableView alloc] init];
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    RoomModel *room = [self.data objectAtIndex:indexPath.row];
    MessageDataStore *messageDataSource = [self.dataStore messageDataStoreForRoom:room userId:self.userId];
    
    MessagesCollectionViewController *messagesViewController = [[MessagesCollectionViewController alloc] initWithDataStore:messageDataSource userId:self.userId];
    [self.navigationController pushViewController:messagesViewController animated:YES];
}

#pragma mark - RoomDataStoreDelegate

- (void)roomDataStore:(RoomDataStore *)dataStore didAddRoom:(RoomModel *)room {
    [self.data addObject:room];
    NSInteger newIndex = self.data.count - 1;
    [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:newIndex inSection:0]]];
    
    if (!self.didLoad) {
        self.didLoad = YES;
        [self.collectionViewLayout invalidateLayout];
    }
}

- (void)roomDataStore:(RoomDataStore *)dataStore didRemoveRoom:(RoomModel *)room {
    NSUInteger index = [self.data indexOfObject:room];
    [self.data removeObject:room];
    [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:index inSection:0]]];
}

@end
