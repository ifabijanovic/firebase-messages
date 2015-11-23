//
//  RoomModel.h
//  BellabeatFeedback
//
//  Created by Ivan Fabijanović on 20/11/15.
//  Copyright © 2015 Bellabeat. All rights reserved.
//

#import "ModelBase.h"

@interface RoomModel : ModelBase

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithKey:(NSString *)key value:(NSDictionary *)dictionary NS_DESIGNATED_INITIALIZER;

@end
