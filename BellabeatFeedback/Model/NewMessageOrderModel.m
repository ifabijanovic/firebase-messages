//
//  NewMessageOrderModel.m
//  BellabeatFeedback
//
//  Created by Ivan Fabijanović on 23/11/15.
//  Copyright © 2015 Bellabeat. All rights reserved.
//

#import "NewMessageOrderModel.h"
#import <Firebase/Firebase.h>

@implementation NewMessageOrderModel

#pragma mark - Init

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"New";
        self.limit = 50;
    }
    return self;
}

#pragma mark - Public methods

- (FQuery *)queryForRef:(Firebase *)ref {
    return [[ref queryOrderedByPriority] queryLimitedToLast:self.limit];
}

- (NSUInteger)indexForMessage:(MessageModel *)message inArray:(NSArray *)array {
    NSMutableArray *tempData = [array mutableCopy];
    [tempData addObject:message];
    
    NSSortDescriptor *byTimestamp = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:NO];
    NSArray *data = [tempData sortedArrayUsingDescriptors:@[byTimestamp]];
    
    return [data indexOfObject:message];
}

@end
