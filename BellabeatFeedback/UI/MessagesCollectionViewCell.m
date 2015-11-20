//
//  MessagesCollectionViewCell.m
//  BellabeatFeedback
//
//  Created by Ivan Fabijanović on 20/11/15.
//  Copyright © 2015 Bellabeat. All rights reserved.
//

#import "MessagesCollectionViewCell.h"
#import "MessageModel.h"

@interface MessagesCollectionViewCell()

@property (nonatomic, strong) MessageModel *model;

@end

@implementation MessagesCollectionViewCell

- (void)dealloc {
    [self removeObservers];
    
    NSLog(@"MessageCollectionViewCell dealloc");
}

#pragma mark - Public methods

- (void)setMessage:(MessageModel *)message {
    [self removeObservers];
    self.model = message;
    [self addObservers];
    
    [self updateAppearance];
}

#pragma mark - Observing

- (void)addObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modelDidChange:) name:kMessageDidChangeNotification object:self.model];
}

- (void)removeObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)modelDidChange:(NSNotification *)notification {
    [self updateAppearance];
}

#pragma mark - Private methods

- (void)updateAppearance {
    self.messageTextLabel.text = self.model.message;
    self.messageTimestampLabel.text = [NSString stringWithFormat:@"%@", self.model.timestamp];
    self.messagePointsLabel.text = [NSString stringWithFormat:@"%ld", (long)self.model.points];
    [self updateButtonAppearance];
}

- (void)updateButtonAppearance {
    if ([self.model didUpvote]) {
        [self.upvoteButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [self.downvoteButton setTitleColor:[UIColor colorWithRed:0 green:122.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    } else if ([self.model didDownvote]) {
        [self.downvoteButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.upvoteButton setTitleColor:[UIColor colorWithRed:0 green:122.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    } else {
        [self.upvoteButton setTitleColor:[UIColor colorWithRed:0 green:122.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
        [self.downvoteButton setTitleColor:[UIColor colorWithRed:0 green:122.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    }
}

- (IBAction)upTapped:(id)sender {
    [self.model upvote];
}

- (IBAction)downTapped:(id)sender {
    [self.model downvote];
}

@end
