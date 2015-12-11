//
//  Event.m
//  uovo
//
//  Created by George Nishimura on 09/12/2015.
//  Copyright © 2015 ytil. All rights reserved.
//

#import "Event.h"

@implementation Event

// Insert code here to add functionality to your managed object subclass
+(Event *)createFromJSON:(NSDictionary *)json{
    
    ISO8601DateFormatter * formatter = [[ISO8601DateFormatter alloc] init];
    
    Event * event = [[Event alloc] init];
    
    event.eventId = [json objectForKey:@"eventId"];
    event.name = [json objectForKey:@"name"];
    //ignore timezone
    event.startTime = [formatter dateFromString:[json objectForKey:@"startTime"]];
    event.endTime = [formatter dateFromString:[json objectForKey:@"endTime"]];
    if([[json objectForKey:@"checkInTime"] isKindOfClass:[NSString class]]) {
        event.checkInTime = [formatter dateFromString:[json objectForKey:@"checkInTime"]];
    }
    if([[json objectForKey:@"checkOutTime"] isKindOfClass:[NSString class] ]){
        event.checkOutTime = [formatter dateFromString:[json objectForKey:@"checkOutTime"]];
    }
    if([[json objectForKey:@"skipped"] isKindOfClass: [NSString class] ]){
        event.skipped = [json objectForKey:@"skipped"];
    }
    
    return event;
}

-(EventStatus) getStatus {
    if([self.skipped boolValue]) {
        return Skipped;
    } else if(self.checkOutTime != nil){
        return CheckedOut;
    } else if(self.checkInTime != nil) {
       return CheckedIn;
    } else {
        return Idle;
    }
}

-(void)saveEvent{
    NSManagedObjectContext * moc = [[(AppDelegate *)[[UIApplication sharedApplication] delegate] dataStack] mainContext];
    [moc save:nil];
}

@end
