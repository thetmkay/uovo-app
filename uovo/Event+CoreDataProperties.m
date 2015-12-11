//
//  Event+CoreDataProperties.m
//  uovo
//
//  Created by George Nishimura on 09/12/2015.
//  Copyright © 2015 ytil. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Event+CoreDataProperties.h"

@implementation Event (CoreDataProperties)

@dynamic eventId;
@dynamic name;
@dynamic startTime;
@dynamic endTime;
@dynamic checkInTime;
@dynamic checkOutTime;
@dynamic skipped;

@end
