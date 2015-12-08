//
//  EventControlView.h
//  uovo
//
//  Created by George Nishimura on 08/12/2015.
//  Copyright © 2015 ytil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "Event.h"
#import "RoundButton.h"

#import "Masonry.h"

@interface EventControlView : UIView

@property RoundButton * inButton;
@property RoundButton * outButton;
@property RoundButton * skipButton;
@property UITextView * skippedText;
@property UITextView * skippedX;
@property UITextView * timeText;
@property UITextView * outText;

@property UIView *containerView;

-(void)configureForStatus:(EventStatus) status;

@end
