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

@property UIButton * inButton;
@property UIButton * outButton;
@property UIButton * skipButton;
@property UILabel * skippedText;
@property UILabel * skippedX;
@property UILabel * timeText;
@property UILabel * outText;

@property UIView *containerView;

-(void)configureForStatus:(EventStatus) status;

@end
