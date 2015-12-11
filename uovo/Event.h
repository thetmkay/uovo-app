//
//  Event.h
//  uovo
//
//  Created by George Nishimura on 09/12/2015.
//  Copyright © 2015 ytil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ISO8601DateFormatter/ISO8601DateFormatter.h"
#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, EventStatus)
{
    Idle,
    CheckedIn,
    CheckedOut,
    Skipped
};

@interface Event : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
+(Event *)createFromJSON:(NSDictionary *)json;

-(void)saveEvent;
-(EventStatus) getStatus;

@end

NS_ASSUME_NONNULL_END

#import "Event+CoreDataProperties.h"
