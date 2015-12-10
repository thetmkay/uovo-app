//
//  AppDelegate.m
//  uovo
//
//  Created by George Nishimura on 07/12/2015.
//  Copyright © 2015 ytil. All rights reserved.
//

#import "AppDelegate.h"
#import "EventsTableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    self.dataStack = [[DATAStack alloc] initWithModelName:@"uovo"];
    
    [self startNetworkQueueMonitoring];
    
    
    EventsTableViewController * rootController = [[EventsTableViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:rootController];
    self.window.rootViewController = navController;
    
    return YES;
}

-(void) startNetworkQueueMonitoring
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSOperationQueue * queue = manager.operationQueue;
    
    manager.reachabilityManager = [AFNetworkReachabilityManager managerForDomain:@"http://localhost:3000"];
    
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [queue setSuspended:NO];
                break;
            case AFNetworkReachabilityStatusNotReachable:
            default:
                [queue setSuspended:YES];
                break;
        }
    }];
    
    [manager.reachabilityManager startMonitoring];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self.dataStack persistWithCompletion:nil];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [UovoService getEventsFromNetworkForDate:[NSDate date] WithHandler:^(NSError *error, NSArray *events) {
            NSLog(@"updaed");
        }];
    });
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
 
    [self.dataStack persistWithCompletion:nil];
}


@end
