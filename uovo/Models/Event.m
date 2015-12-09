//
//  Event.m
//  uovo
//
//  Created by George Nishimura on 08/12/2015.
//  Copyright © 2015 ytil. All rights reserved.
//

#import "Event.h"

@implementation Event

+(Event *)createFromJSON:(NSDictionary *)json{
    
    ISO8601DateFormatter * formatter = [[ISO8601DateFormatter alloc] init];
    
    Event * event = [[Event alloc] init];
    
    event.eventId = [json objectForKey:@"eventId"];
    event.title = [json objectForKey:@"name"];
    //ignore timezone
    event.startTime = [formatter dateFromString:[json objectForKey:@"startTime"]];
    event.endTime = [formatter dateFromString:[json objectForKey:@"endTime"]];
    event.colorId = [[json objectForKey:@"colorId"] integerValue];
    if([[json objectForKey:@"checkInTime"] isKindOfClass:[NSString class]]) {
         event.checkInTime = [formatter dateFromString:[json objectForKey:@"checkInTime"]];
    }
    if([[json objectForKey:@"checkOutTime"] isKindOfClass:[NSString class] ]){
        event.checkOutTime = [formatter dateFromString:[json objectForKey:@"checkOutTime"]];
    }
    if([[json objectForKey:@"skipped"] isKindOfClass: [NSString class] ]){
        event.skipped = [[json objectForKey:@"skipped"] boolValue];
    }
    
    return event;
}

@end
