//
//  ModelBase.h
//  BellabeatFeedback
//
//  Created by Ivan Fabijanović on 23/11/15.
//  Copyright © 2015 Bellabeat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelBase : NSObject

@property (nonatomic, copy) NSString *key;

- (void)updateWithDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)serialize;

@end
