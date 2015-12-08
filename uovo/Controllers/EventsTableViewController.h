//
//  EventsTableViewController.h
//  uovo
//
//  Created by George Nishimura on 08/12/2015.
//  Copyright © 2015 ytil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTMOAuth2ViewControllerTouch.h"
#import "GTLCalendar.h"
#import "Event.h"

@interface EventsTableViewController : UITableViewController

@property NSArray * events;

@property (nonatomic, strong) GTLServiceCalendar *service;

@end
