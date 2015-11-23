//
//  MessageSorter.m
//  BellabeatFeedback
//
//  Created by Ivan Fabijanović on 23/11/15.
//  Copyright © 2015 Bellabeat. All rights reserved.
//

#import "MessageSorter.h"
#import <Firebase/Firebase.h>

@implementation MessageSorter

#pragma mark - Init

- (void)dealloc {
    NSLog(@"MessageOrderModel dealloc");
}

#pragma mark - Abstract methods

- (FQuery *)queryForRef:(Firebase *)ref {
    return nil;
}

- (NSUInteger)indexForMessage:(MessageModel *)message inArray:(NSArray *)array {
    return 0;
}

@end
