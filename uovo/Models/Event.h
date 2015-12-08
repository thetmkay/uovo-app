//
//  Event.h
//  uovo
//
//  Created by George Nishimura on 08/12/2015.
//  Copyright © 2015 ytil. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, EventStatus)
{
    Idle,
    CheckedIn,
    CheckedOut,
    Skipped
};

@interface Event : NSObject

@property NSString * title;
@property NSDate * startTime;
@property NSDate * endTime;
@property NSDate * checkInTime;
@property NSDate * checkOutTime;
@property BOOL skipped;

@property EventStatus status;

@end
