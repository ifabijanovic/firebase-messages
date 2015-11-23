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
#import "HotMessageOrderModel.h"
#import "NewMessageOrderModel.h"
#import "MessagesCollectionViewController.h"

@interface OrderCollectionViewController ()

@property (nonatomic, strong) NSArray *orders;

@end

@implementation OrderCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([OrderCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kOrderCellIdentifier];
    
    self.title = self.room.name;
    self.orders = @[
                    [[HotMessageOrderModel alloc] init],
                    [[NewMessageOrderModel alloc] init]
                    ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.orders.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width, 100.0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    OrderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kOrderCellIdentifier forIndexPath:indexPath];
    cell.order = [self.orders objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    MessageOrderModel *order = [self.orders objectAtIndex:indexPath.row];
    MessageDataStore *messageDataStore = [self.dataStore messageDataStoreForRoom:self.room order:order];
    
    MessagesCollectionViewController *vc = [[MessagesCollectionViewController alloc] initWithDataStore:messageDataStore];
    vc.title = [NSString stringWithFormat:@"%@ - %@", self.room.name, order.title];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
