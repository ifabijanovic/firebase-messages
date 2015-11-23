//
//  ModelBase.m
//  BellabeatFeedback
//
//  Created by Ivan Fabijanović on 23/11/15.
//  Copyright © 2015 Bellabeat. All rights reserved.
//

#import "ModelBase.h"

@implementation ModelBase

#pragma mark - Abstract methods

- (void)updateWithDictionary:(NSDictionary *)dictionary {}
- (NSDictionary *)serialize { return nil; }

@end
