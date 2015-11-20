//
//  MessagesCollectionViewCell.m
//  BellabeatFeedback
//
//  Created by Ivan Fabijanović on 20/11/15.
//  Copyright © 2015 Bellabeat. All rights reserved.
//

#import "MessagesCollectionViewCell.h"
#import "MessageModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation MessagesCollectionViewCell

#pragma mark - Init

- (void)awakeFromNib {
    [super awakeFromNib];
    
    __weak typeof(self) weakSelf = self;
    RAC(self.messageTextLabel, text) = RACObserve(self, message.message);
    RAC(self.messageTimestampLabel, text) = [RACObserve(self, message.timestamp) map:^id(id value) {
        return [NSString stringWithFormat:@"%@", value];
    }];
    RAC(self.messagePointsLabel, text) = [RACObserve(self, message.points) map:^id(id value) {
        return [NSString stringWithFormat:@"%ld", (long)[value integerValue]];
    }];
    [RACObserve(self, message.points) subscribeNext:^(id x) {
        [weakSelf updateButtonAppearance];
    }];
    [[self.upvoteButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [weakSelf.message upvote];
    }];
    [[self.downvoteButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [weakSelf.message downvote];
    }];
}

- (void)dealloc {
    NSLog(@"MessageCollectionViewCell dealloc");
}

#pragma mark - Private methods

- (void)updateButtonAppearance {
    if ([self.message didUpvote]) {
        [self.upvoteButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [self.downvoteButton setTitleColor:[UIColor colorWithRed:0 green:122.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    } else if ([self.message didDownvote]) {
        [self.downvoteButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.upvoteButton setTitleColor:[UIColor colorWithRed:0 green:122.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    } else {
        [self.upvoteButton setTitleColor:[UIColor colorWithRed:0 green:122.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
        [self.downvoteButton setTitleColor:[UIColor colorWithRed:0 green:122.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    }
}

@end
