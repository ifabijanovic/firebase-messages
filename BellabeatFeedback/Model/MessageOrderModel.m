//
//  MessageOrderModel.m
//  BellabeatFeedback
//
//  Created by Ivan Fabijanović on 23/11/15.
//  Copyright © 2015 Bellabeat. All rights reserved.
//

#import "MessageOrderModel.h"
#import <Firebase/Firebase.h>

@implementation MessageOrderModel

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
