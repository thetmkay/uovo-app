//
//  UovoService.h
//  uovo
//
//  Created by George Nishimura on 09/12/2015.
//  Copyright © 2015 ytil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking/AFNetworking.h"
#import "AppDelegate.h"
#import "ISO8601DateFormatter/ISO8601DateFormatter.h"
#import "Sync/Sync.h"

@interface UovoService : NSObject

+(void) getEventsFromNetworkForDate:(NSDate *) date WithHandler:(void (^)(NSError * error, NSArray * events)) handler;
+(void) getEventsFromLocalForDate:(NSDate *) date WithHandler:(void (^)(NSError * error, NSArray * events)) handler;
+(void) getEventsForDate:(NSDate *) date WithHandler:(void (^)(NSError * error, NSArray * events)) handler;
+(void) checkInForEvent:(NSString *)eventId withRequestHandler: (void (^)(NSError* error, NSDate * checkInTime)) onRequested andCompletionHandler:(void (^)(NSError* error, NSDate * checkInTime)) onCompletion;
+(void) checkOutForEvent:(NSString *)eventId withRequestHandler: (void (^)(NSError* error, NSDate * checkInTime)) onRequested andCompletionHandler:(void (^)(NSError* error, NSDate * checkOutTime)) onCompletion;
+(void)skipEvent:(NSString *)eventId withRequestHandler: (void (^)(NSError* error, BOOL skipped)) onRequested andCompletionHandler:(void (^)(NSError* error, BOOL skipped)) onCompletion;

@end
