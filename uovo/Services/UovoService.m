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

+(NSString *)nowInISOString{
    
    NSDate * date = [NSDate date];
    
    ISO8601DateFormatter * formatter = [[ISO8601DateFormatter alloc] init];
    
    return [formatter stringFromDate:date timeZone: [NSTimeZone timeZoneWithName:@"UTC" ]];
}

+(void) getEventsWithHandler:(void (^)(NSError * error, NSArray * events)) handler{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET: [self urlForEndpoint:@"events"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(nil,responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        handler(error, nil);
    }];
}

+(void) checkInForEvent:(NSString *)eventId andCompletionHandler:(void (^)(NSError* error)) handler{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary * parameters = @{@"eventId": eventId, @"checkInTime": [self nowInISOString]};
    
    [manager POST:@"http://localhost:3000/event/checkin" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        handler(error);
    }];
}

+(void) checkOutForEvent:(NSString *)eventId andCompletionHandler:(void (^)(NSError * error)) handler{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary * parameters = @{@"eventId": eventId, @"checkOutTime": [self nowInISOString]};
    
    [manager POST:@"http://localhost:3000/event/checkout" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        handler(error);
    }];
}

+(void)skipEvent:(NSString *)eventId andCompletionHandler:(void (^)(NSError * error)) handler{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary * parameters = @{@"eventId": eventId};
    
    [manager POST:@"http://localhost:3000/event/skip" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        handler(error);
    }];
}


@end
