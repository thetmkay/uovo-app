//
//  UovoService.h
//  uovo
//
//  Created by George Nishimura on 09/12/2015.
//  Copyright © 2015 ytil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "ISO8601DateFormatter.h"

@interface UovoService : NSObject

+(void) getEventsWithHandler:(void (^)(NSError * error, NSArray * events)) handler;
+(void) checkInForEvent:(NSString *)eventId andCompletionHandler:(void (^)(NSError* error)) handler;
+(void) checkOutForEvent:(NSString *)eventId andCompletionHandler:(void (^)(NSError * error)) handler;
+(void)skipEvent:(NSString *)eventId andCompletionHandler:(void (^)(NSError * error)) handler;

@end
