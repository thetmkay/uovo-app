//
//  EventViewController.h
//  uovo
//
//  Created by George Nishimura on 08/12/2015.
//  Copyright © 2015 ytil. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Event.h"
#import "EventControlView.h"
#import "EventsDelegate.h"

@interface EventViewController : UIViewController

@property Event *event;

@property EventControlView * controlView;

@property id<EventsDelegate> delegate;

- (id)initWithEvent:(Event *)event;

@end
