//
//  EventViewController.h
//  uovo
//
//  Created by George Nishimura on 08/12/2015.
//  Copyright © 2015 ytil. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Event.h"

@interface EventViewController : UIViewController

@property Event *event;

- (id) initWithEvent:(Event *)event

@end
