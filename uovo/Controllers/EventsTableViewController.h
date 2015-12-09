//
//  EventsTableViewController.h
//  uovo
//
//  Created by George Nishimura on 08/12/2015.
//  Copyright © 2015 ytil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UovoService.h"
#import "Event.h"
#import "EventCell.h"
#import "EventViewController.h"
#import "ISO8601DateFormatter.h"
#import "AppDelegate.h"
#import "Schedule.h"

@interface EventsTableViewController : UITableViewController

@property NSArray * events;


@end
