//
//  RoomModel.m
//  BellabeatFeedback
//
//  Created by Ivan Fabijanović on 20/11/15.
//  Copyright © 2015 Bellabeat. All rights reserved.
//

#import "RoomModel.h"

@implementation RoomModel

- (instancetype)initWithKey:(NSString *)key value:(NSDictionary *)dictionary {
    NSParameterAssert(key);
    NSParameterAssert(dictionary);
    
    self = [super init];
    if (self) {
        self.key = key;
        self.name = [dictionary objectForKey:@"name"];
        self.type = [dictionary objectForKey:@"type"];
    }
    return self;
}

@end
