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

+(void) getEventsWithHandler:(void (^)(NSError * error, NSArray * events)) handler;
+(void) checkInForEvent:(NSString *)eventId andCompletionHandler:(void (^)(NSError* error, NSDate * checkInTime)) handler;
+(void) checkOutForEvent:(NSString *)eventId andCompletionHandler:(void (^)(NSError * error, NSDate * checkOutTime)) handler;
+(void)skipEvent:(NSString *)eventId andCompletionHandler:(void (^)(NSError * error)) handler;

@end
