//
//  MessagesCollectionViewCell.h
//  BellabeatFeedback
//
//  Created by Ivan Fabijanović on 20/11/15.
//  Copyright © 2015 Bellabeat. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MessageModel;

#define kMessageCellIdentifier @"messageCell"

@interface MessagesCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *messageTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageTimestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *messagePointsLabel;
@property (weak, nonatomic) IBOutlet UIButton *upvoteButton;
@property (weak, nonatomic) IBOutlet UIButton *downvoteButton;

@property (nonatomic, strong) MessageModel *message;
@property (nonatomic, copy) NSString *userId;

@end
