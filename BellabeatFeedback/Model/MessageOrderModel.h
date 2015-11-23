//
//  MessageOrderModel.h
//  BellabeatFeedback
//
//  Created by Ivan Fabijanović on 23/11/15.
//  Copyright © 2015 Bellabeat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageModel.h"

@class Firebase;
@class FQuery;

@interface MessageOrderModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) int limit;

- (FQuery *)queryForRef:(Firebase *)ref;
- (NSUInteger)indexForMessage:(MessageModel *)message inArray:(NSArray *)array;

@end
