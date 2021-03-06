//
//  EventControlView.h
//  uovo
//
//  Created by George Nishimura on 08/12/2015.
//  Copyright © 2015 ytil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UovoService.h"
#import "Event.h"
#import "EventsDelegate.h"
#import "MZTimerLabel.h"

#import "Masonry.h"

@interface EventControlView : UIView

@property UIButton * inButton;
@property UIButton * outButton;
@property UIButton * skipButton;
@property UILabel * skippedText;
@property UILabel * skippedX;
@property MZTimerLabel * timer;
@property UILabel * timeText;
@property UILabel * durationText;
@property UILabel * outText;

@property UIView *containerView;

@property Event * event;

@property id<EventsDelegate> delegate;

-(id)initWithEvent:(Event *)event;

@end
