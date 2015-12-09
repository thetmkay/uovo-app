//
//  Schedule+CoreDataProperties.h
//  uovo
//
//  Created by George Nishimura on 09/12/2015.
//  Copyright © 2015 ytil. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Schedule.h"

NS_ASSUME_NONNULL_BEGIN

@interface Schedule (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSOrderedSet<Event *> *events;

@end

@interface Schedule (CoreDataGeneratedAccessors)

- (void)insertObject:(Event *)value inEventsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromEventsAtIndex:(NSUInteger)idx;
- (void)insertEvents:(NSArray<Event *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeEventsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInEventsAtIndex:(NSUInteger)idx withObject:(Event *)value;
- (void)replaceEventsAtIndexes:(NSIndexSet *)indexes withEvents:(NSArray<Event *> *)values;
- (void)addEventsObject:(Event *)value;
- (void)removeEventsObject:(Event *)value;
- (void)addEvents:(NSOrderedSet<Event *> *)values;
- (void)removeEvents:(NSOrderedSet<Event *> *)values;

@end

NS_ASSUME_NONNULL_END
