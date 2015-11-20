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
                             @"r1": @{
                                     [[NSUUID UUID] UUIDString]: @{
                                             @"sender": @"u1",
                                             @"message": @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. In sit amet velit ac turpis scelerisque mattis eu vitae lacus.",
                                             @"timestamp": @([[NSDate date] timeIntervalSince1970]),
                                             @"points": @(1),
                                             @"votes": @{
                                                     @"u1": @"u"
                                                     }
                                             },
                                     [[NSUUID UUID] UUIDString]: @{
                                             @"sender": @"u2",
                                             @"message": @"Proin sapien orci, luctus at massa nec, faucibus molestie lectus.",
                                             @"timestamp": @([[NSDate date] timeIntervalSince1970]),
                                             @"points": @(1),
                                             @"votes": @{
                                                     @"u2": @"u"
                                                     }
                                             },
                                     [[NSUUID UUID] UUIDString]: @{
                                             @"sender": @"u3",
                                             @"message": @"Integer mollis justo convallis neque tempor accumsan. Ut a viverra arcu. Sed in facilisis sem.",
                                             @"timestamp": @([[NSDate date] timeIntervalSince1970]),
                                             @"points": @(1),
                                             @"votes": @{
                                                     @"u3": @"u"
                                                     }
                                             }
                                     },
                             @"r2": @{
                                     [[NSUUID UUID] UUIDString]: @{
                                             @"sender": @"u3",
                                             @"message": @"Nulla nec sagittis leo. Ut scelerisque quam a elit elementum egestas sed quis dui. Pellentesque sit amet augue dolor.",
                                             @"timestamp": @([[NSDate date] timeIntervalSince1970]),
                                             @"points": @(1),
                                             @"votes": @{
                                                     @"u3": @"u"
                                                     }
                                             },
                                     [[NSUUID UUID] UUIDString]: @{
                                             @"sender": @"u1",
                                             @"message": @"Interdum et malesuada fames ac ante ipsum primis in faucibus. Integer laoreet luctus turpis eu auctor. Morbi porta commodo magna nec feugiat.",
                                             @"timestamp": @([[NSDate date] timeIntervalSince1970]),
                                             @"points": @(1),
                                             @"votes": @{
                                                     @"u1": @"u"
                                                     }
                                             },
                                     }
                             }
                     }];
    
}

@end
