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
@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, strong) UILabel *sizingLabel;

@end

@implementation MessagesCollectionViewController

#pragma mark - Init

- (instancetype)initWithDataStore:(MessageDataStore *)dataStore {
    NSParameterAssert(dataStore);
    
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
    if (self) {
        self.dataStore = dataStore;
        self.dataStore.delegate = self;
        
        self.data = [NSMutableArray array];
        
        self.sizingLabel = [[UILabel alloc] init];
        self.sizingLabel.numberOfLines = 0;
        self.sizingLabel.font = [UIFont systemFontOfSize:15.0];
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
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MessagesCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kMessageCellIdentifier];
    
    UIBarButtonItem *newMessageButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(newMessageTapped:)];
    self.navigationItem.rightBarButtonItem = newMessageButton;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    [self.collectionViewLayout invalidateLayout];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    [self.collectionViewLayout invalidateLayout];
}

#pragma mark - Actions

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
    self.sizingLabel.preferredMaxLayoutWidth = collectionView.frame.size.width - 70.0;
    MessageModel *model = [self.data objectAtIndex:indexPath.row];
    self.sizingLabel.text = model.message;
    
    CGSize size = [self.sizingLabel intrinsicContentSize];
    CGFloat height = size.height + 47.0;
    
    return CGSizeMake(collectionView.frame.size.width, MAX(height, 92.0));
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MessagesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMessageCellIdentifier forIndexPath:indexPath];
    cell.message = [self.data objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - MessageDataStoreDelegate

- (void)messageDataStore:(MessageDataStore *)dataStore didAddMessage:(MessageModel *)message {
    NSUInteger index = [self.dataStore.order indexForMessage:message inArray:self.data];
    [self.data insertObject:message atIndex:index];
    [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:index inSection:0]]];
}

- (void)messageDataStore:(MessageDataStore *)dataStore didUpdateMessage:(MessageModel *)message {
    NSUInteger oldIndex = [self.data indexOfObject:message];
    NSUInteger newIndex = [self.dataStore.order indexForMessage:message inArray:self.data];
    
    if (newIndex != oldIndex) {
        [self.collectionView moveItemAtIndexPath:[NSIndexPath indexPathForItem:oldIndex inSection:0] toIndexPath:[NSIndexPath indexPathForItem:newIndex inSection:0]];
    }
}

- (void)messageDataStore:(MessageDataStore *)dataStore didRemoveMessage:(MessageModel *)message {
    NSUInteger index = [self.data indexOfObject:message];
    [self.data removeObject:message];

    [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:index inSection:0]]];
}

@end
