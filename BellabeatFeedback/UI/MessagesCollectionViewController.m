//
//  MessagesCollectionViewController.m
//  BellabeatFeedback
//
//  Created by Ivan Fabijanović on 20/11/15.
//  Copyright © 2015 Bellabeat. All rights reserved.
//

#import "MessagesCollectionViewController.h"
#import "MessagesCollectionViewCell.h"
#import "NewMessageViewController.h"

@interface MessagesCollectionViewController ()

@property (nonatomic, strong) MessageDataStore *dataStore;

@property (nonatomic, strong) NSArray *data;

@end

@implementation MessagesCollectionViewController

#pragma mark - Init

- (instancetype)initWithDataStore:(MessageDataStore *)dataStore {
    NSParameterAssert(dataStore);
    
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
    if (self) {
        self.dataStore = dataStore;
        self.dataStore.delegate = self;
        
        self.data = [NSArray array];
    }
    return self;
}

- (void)dealloc {
    self.dataStore.delegate = nil;
    
    NSLog(@"MessagesCollectionViewController dealloc");
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MessagesCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kMessageCellIdentifier];
    
    UIBarButtonItem *newMessageButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(newMessageTapped:)];
    self.navigationItem.rightBarButtonItem = newMessageButton;
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

- (void)newMessageTapped:(id)sender {
    NewMessageViewController *vc = [[NewMessageViewController alloc] initWithDataStore:self.dataStore];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    UILabel *label = [[UILabel alloc] init];
    label.preferredMaxLayoutWidth = collectionView.frame.size.width - 70;
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:15.0];
    MessageModel *model = [self.data objectAtIndex:indexPath.row];
    label.text = model.message;
    
    CGSize lblSize = [label intrinsicContentSize];
    
    CGFloat height = lblSize.height + 47.0;
    return CGSizeMake(collectionView.frame.size.width, MAX(height, 92.0));
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MessagesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMessageCellIdentifier forIndexPath:indexPath];
    cell.message = [self.data objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

#pragma mark - MessageDataStoreDelegate

- (void)messageDataStore:(MessageDataStore *)dataStore didAddMessage:(MessageModel *)message {
    NSMutableArray *tempData = [self.data mutableCopy];
    [tempData addObject:message];
    
    NSSortDescriptor *byPointsDesc = [NSSortDescriptor sortDescriptorWithKey:@"points" ascending:NO];
    NSSortDescriptor *byTimestamp = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:NO];
    self.data = [tempData sortedArrayUsingDescriptors:@[byPointsDesc, byTimestamp]];
    
    NSUInteger index = [self.data indexOfObject:message];
    [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:index inSection:0]]];
}

- (void)messageDataStore:(MessageDataStore *)dataStore didUpdateMessage:(MessageModel *)message {
    NSUInteger oldIndex = [self.data indexOfObject:message];
    
    NSSortDescriptor *byPointsDesc = [NSSortDescriptor sortDescriptorWithKey:@"points" ascending:NO];
    NSSortDescriptor *byTimestamp = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:NO];
    self.data = [self.data sortedArrayUsingDescriptors:@[byPointsDesc, byTimestamp]];
    
    NSUInteger newIndex = [self.data indexOfObject:message];
    
    if (newIndex != oldIndex) {
        [self.collectionView moveItemAtIndexPath:[NSIndexPath indexPathForItem:oldIndex inSection:0] toIndexPath:[NSIndexPath indexPathForItem:newIndex inSection:0]];
    }
}

- (void)messageDataStore:(MessageDataStore *)dataStore didRemoveMessage:(MessageModel *)message {
    NSUInteger index = [self.data indexOfObject:message];
    
    NSMutableArray *tempData = [self.data mutableCopy];
    [tempData removeObject:message];
    
    self.data = [tempData copy];
    
    [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:index inSection:0]]];
}

@end
