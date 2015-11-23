//
//  NewMessageViewController.h
//  BellabeatFeedback
//
//  Created by Ivan Fabijanović on 20/11/15.
//  Copyright © 2015 Bellabeat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageDataStore.h"

@interface NewMessageViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *inputTextView;

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil NS_UNAVAILABLE;
- (instancetype)initWithDataStore:(MessageDataStore *)dataStore NS_DESIGNATED_INITIALIZER;

@end
