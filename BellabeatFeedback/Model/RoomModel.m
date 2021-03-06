//
//  RoomModel.m
//  BellabeatFeedback
//
//  Created by Ivan Fabijanović on 20/11/15.
//  Copyright © 2015 Bellabeat. All rights reserved.
//

#import "RoomModel.h"

@implementation RoomModel

#pragma mark - Init

- (instancetype)initWithKey:(NSString *)key value:(NSDictionary *)dictionary {
    NSParameterAssert(key);
    NSParameterAssert(dictionary);
    
    self = [super init];
    if (self) {
        self.key = key;
        [self updateWithDictionary:dictionary];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"RoomModel %@ dealloc", self.key);
}

#pragma mark - Public methods

- (void)updateWithDictionary:(NSDictionary *)dictionary {
    self.name = [dictionary objectForKey:@"name"];
    self.type = [dictionary objectForKey:@"type"];
}

- (NSDictionary *)serialize {
    return @{
             self.key: @{
                     @"name": self.name,
                     @"type": self.type
                     }
             };
}

@end
