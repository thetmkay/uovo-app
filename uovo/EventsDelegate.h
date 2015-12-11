//
//  EventsDelegate.h
//  uovo
//
//  Created by George Nishimura on 11/12/2015.
//  Copyright © 2015 ytil. All rights reserved.
//

#ifndef EventsDelegate_h
#define EventsDelegate_h

@protocol EventsDelegate <NSObject>

-(void)checkIn:(Event *)event andBlock:(void(^)(Event *event)) block;
-(void)checkOut:(Event *)event andBlock:(void(^)(Event *event)) block;
-(void)skip:(Event *)event andBlock:(void(^)(Event *event)) block;
-(void)fetchEvents;

@end

#endif /* EventsDelegate_h */
