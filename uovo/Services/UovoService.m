//
//  UovoService.m
//  uovo
//
//  Created by George Nishimura on 09/12/2015.
//  Copyright © 2015 ytil. All rights reserved.
//

#import "UovoService.h"

@implementation UovoService

+(NSString *)urlForEndpoint:(NSString *)endpoint{
    return [NSString stringWithFormat:@"http://192.168.0.5:3000/%@",endpoint];
}

+(NSString *)ISOStringForDate:(NSDate *) date{
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setLocale:enUSPOSIXLocale];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    
//    ISO8601DateFormatter * formatter = [[ISO8601DateFormatter alloc] init];
    
    return [formatter stringFromDate:date];
}

+(void)getEventsFromNetworkForDate:(NSDate *) date WithHandler:(void (^)(NSError * , NSArray * ))handler {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    
    NSString * endpoint = [NSString stringWithFormat:@"events/%@", [dateFormatter stringFromDate:date]];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [manager GET: [self urlForEndpoint:endpoint] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        DATAStack * dataStack = [(AppDelegate *)[[UIApplication sharedApplication] delegate] dataStack];
        
        [Sync changes:@[responseObject]
        inEntityNamed:@"Schedule"
            dataStack:dataStack
           completion:^(NSError *error) {
               NSLog(@"Sync error: %@", error);
               [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
               
               [self getEventsFromLocalForDate:date WithHandler:^(NSError * error, NSArray * events) {
                   handler(error, events);
               }];
               
           }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        handler(error, nil);
    }];
}

+(void)getEventsFromLocalForDate:(NSDate *) date WithHandler:(void (^)(NSError * , NSArray * ))handler {
    
    NSDate *startDate = date;
    NSTimeInterval day;
    
    [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay startDate:&startDate interval:&day forDate:startDate];
    
    NSDate * endDate = [startDate dateByAddingTimeInterval:day];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(date >= %@) AND (date < %@)", startDate, endDate];
    
    NSManagedObjectContext *moc = [[(AppDelegate *)[[UIApplication sharedApplication] delegate] dataStack] mainContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Schedule" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    [request setPredicate:predicate];
    // Fetch the records and handle an error
    NSError *error;
    
    NSArray * response = [moc executeFetchRequest:request error:&error];
    

    
    if(error != nil || response.count == 0) {
        handler([NSError errorWithDomain:@"uovo.service" code:404 userInfo:nil], nil);
        return;
    }
    
    NSOrderedSet * events = [[ response valueForKey:@"events"] objectAtIndex:0];
    handler(nil,[events array]);
}

+(void) getEventsForDate:(NSDate *) date WithHandler:(void (^)(NSError * , NSArray * )) handler{
    [self getEventsFromLocalForDate:date WithHandler:^(NSError *err, NSArray *evs) {
        if(err != nil || evs == nil || evs.count == 0){
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self getEventsFromNetworkForDate:date WithHandler:^(NSError *error, NSArray *events) {
                    handler(error,events);
                }];
            });
        } else {
            handler(nil, evs);
        }
    }];
}

+(void) checkInForEvent:(NSString *)eventId withRequestHandler: (void (^)(NSError* error, NSDate * checkInTime)) onRequested andCompletionHandler:(void (^)(NSError* error, NSDate * checkInTime)) onCompletion{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSDate * checkInTime = [NSDate date];
    
    NSDictionary * parameters = @{@"eventId": eventId, @"checkInTime": [self ISOStringForDate:checkInTime]};
    
    onRequested(nil, checkInTime);
    
    [manager POST:@"http://localhost:3000/event/checkin" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
 
        ISO8601DateFormatter *formatter = [[ISO8601DateFormatter alloc] init];
        
        NSDate * checkInTime = [formatter dateFromString:[responseObject objectForKey:@"check_in_time"]];
        
        onCompletion(nil, checkInTime);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        onCompletion(error, nil);
    }];
}

+(void) checkOutForEvent:(NSString *)eventId withRequestHandler: (void (^)(NSError* error, NSDate * checkInTime)) onRequested andCompletionHandler:(void (^)(NSError* error, NSDate * checkOutTime)) onCompletion{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSDate * checkOutTime = [NSDate date];
    
    NSDictionary * parameters = @{@"eventId": eventId, @"checkOutTime": [self ISOStringForDate: checkOutTime]};
    
    onRequested(nil, checkOutTime);
    
    [manager POST:@"http://localhost:3000/event/checkout" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        ISO8601DateFormatter *formatter = [[ISO8601DateFormatter alloc] init];
        
        NSDate * checkOutTime = [formatter dateFromString:[responseObject objectForKey:@"check_out_time"]];
        
        onCompletion(nil, checkOutTime);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        onCompletion(error, nil);
    }];
}

+(void)skipEvent:(NSString *)eventId withRequestHandler: (void (^)(NSError* error, BOOL skipped)) onRequested andCompletionHandler:(void (^)(NSError* error, BOOL skipped)) onCompletion{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary * parameters = @{@"eventId": eventId};
    
    onRequested(nil, YES);
    
    [manager POST:@"http://localhost:3000/event/skip" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        onCompletion(nil, [responseObject objectForKey:@"skipped"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        onCompletion(error, NO);
    }];
}


@end
