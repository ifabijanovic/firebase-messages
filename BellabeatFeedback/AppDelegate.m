//
//  AppDelegate.m
//  BellabeatFeedback
//
//  Created by Ivan Fabijanović on 19/11/15.
//  Copyright © 2015 Bellabeat. All rights reserved.
//

#import "AppDelegate.h"
#import <Firebase/Firebase.h>
#import "RoomsCollectionViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    Firebase *rootRef = [[Firebase alloc] initWithUrl:@"https://bellabeat-feedback.firebaseio.com/"];
//    [self generateSomeDataWithRoot:rootRef];
    RoomDataStore *roomDataStore = [[RoomDataStore alloc] initWithRoot:rootRef];
    
    RoomsCollectionViewController *root = [[RoomsCollectionViewController alloc] initWithDataStore:roomDataStore];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:root];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setRootViewController:navController];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)generateSomeDataWithRoot:(Firebase *)root {
    [root setValue:@{
                     @"rooms": @{
                             @"r1": @{
                                     @"name": @"General",
                                     @"type": @"public"
                                     },
                             @"r2": @{
                                     @"name": @"Feedback",
                                     @"type": @"public"
                                     },
                             @"r3": @{
                                     @"name": @"Staff",
                                     @"type": @"private"
                                     }
                             },
                     @"users": @{
                             @"u1": @{
                                     @"email": @"user1@bbfeedback.com"
                                     },
                             @"u2": @{
                                     @"email": @"user2@bbfeedback.com"
                                     },
                             @"u3": @{
                                     @"email": @"user3@bbfeedback.com"
                                     }
                             },
                     @"messages": @{
                             @"r1": @{}
                             }
                     }];
    
    Firebase *messages = [root childByAppendingPath:@"messages/r1"];
    int numberOfMessages = 1000;
    for (int i = 0; i < numberOfMessages; i++) {
        [[messages childByAutoId] setValue:@{
                                             @"sender": @"u1",
                                             @"message": [self randomStringWithLength:50],
                                             @"timestamp": @([self randomDate]),
                                             @"points": @(arc4random_uniform(25)),
                                             @"votes": @{
                                                     @"u1": @"u"
                                                     }
                                             }];
    }

}

NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

- (NSString *)randomStringWithLength:(int)len {
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    int nextSpace = arc4random_uniform(7) + 3;
    
    for (int i=0; i<len; i++) {
        if (nextSpace == 0) {
            nextSpace = arc4random_uniform(7) + 3;
            [randomString appendString:@" "];
        } else {
            nextSpace--;
        }
        
        [randomString appendFormat: @"%C", [letters characterAtIndex:arc4random_uniform([letters length])]];
    }
    
    return randomString;
}

- (NSTimeInterval)randomDate {
    int days = arc4random_uniform(7);
    int hours = arc4random_uniform(24);
    int minutes = arc4random_uniform(60);
    
    NSTimeInterval interval = (-days * 24*60*60) + (-hours * 60*60) + (-minutes * 60);
    
    return [[NSDate dateWithTimeIntervalSinceNow:interval] timeIntervalSince1970];
}

@end
