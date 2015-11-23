//
//  TopMessageSorter.m
//  BellabeatFeedback
//
//  Created by Ivan Fabijanović on 23/11/15.
//  Copyright © 2015 Bellabeat. All rights reserved.
//

#import "TopMessageSorter.h"
#import <Firebase/Firebase.h>

@implementation TopMessageSorter

#pragma mark - Init

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"Top";
        self.limit = 50;
    }
    return self;
}

#pragma mark - Public methods

- (FQuery *)queryForRef:(Firebase *)ref {
    return [[ref queryOrderedByChild:@"points"] queryLimitedToLast:self.limit];
}

- (NSUInteger)indexForMessage:(MessageModel *)message inArray:(NSArray *)array {
    NSMutableArray *tempData = [array mutableCopy];
    [tempData addObject:message];
    
    NSSortDescriptor *byPointsDesc = [NSSortDescriptor sortDescriptorWithKey:@"points" ascending:NO];
    NSSortDescriptor *byTimestamp = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:NO];
    NSArray *data = [tempData sortedArrayUsingDescriptors:@[byPointsDesc, byTimestamp]];
    
    return [data indexOfObject:message];
}

@end
