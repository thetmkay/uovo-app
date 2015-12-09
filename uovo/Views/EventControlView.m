//
//  EventControlView.m
//  uovo
//
//  Created by George Nishimura on 08/12/2015.
//  Copyright © 2015 ytil. All rights reserved.
//

#import "EventControlView.h"

@implementation EventControlView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id) initWithEvent:(Event *)event{
    self = [super init];
    
    self.event = event;
    
    if(self.event.skipped) {
        [self configureForStatus:Skipped];
    } else if(self.event.checkOutTime != nil){
        [self configureForStatus:CheckedOut];
    } else if(self.event.checkInTime != nil) {
        [self configureForStatus:CheckedIn];
    } else {
        [self configureForStatus:Idle];
    }
    
    return self;
}

-(IBAction)checkIn:(id)sender {
    
    [UovoService checkInForEvent:self.event.eventId andCompletionHandler:^(NSError *error, NSDate* checkInTime) {
        if(error == nil){
            self.event.checkInTime = checkInTime;
            [self configureForStatus:CheckedIn];
        } else{
            NSLog(@"Check In Error: %@", error);
        }
    }];
    
}

-(IBAction)checkOut:(id)sender {
    
    [UovoService checkOutForEvent:self.event.eventId andCompletionHandler:^(NSError *error, NSDate * checkOutTime) {
        if(error == nil){
            self.event.checkOutTime = checkOutTime;
            [self configureForStatus:CheckedOut];
        } else{
            NSLog(@"Check Out Error: %@", error);
        }
    }];
}

-(IBAction)skip:(id)sender {
    [UovoService skipEvent:self.event.eventId andCompletionHandler:^(NSError *error) {
        if(error == nil){
            self.event.skipped = YES;
            [self configureForStatus:Skipped];
        } else{
            NSLog(@"Skip Error: %@", error);
        }
    }];
}

-(void)configureForStatus:(EventStatus)status{
    
    [self clearView];
    
    switch (status) {
        case Idle:
            [self idleView];
            break;
        case CheckedIn:
            [self checkedInView];
            break;
        case CheckedOut:
            [self checkedOutView];
            break;
        case Skipped:
            [self skippedView];
            break;
        default:
            break;
    }
    
    [self layoutSubviews];
}

-(void)clearView{
    
    if(self.containerView == nil){
        self.containerView = [[UIView alloc] init];
        [self addSubview:self.containerView];
    } else {
        [[self.containerView subviews] makeObjectsPerformSelector:@selector(setHidden:) withObject:[NSNumber numberWithBool:YES]];
        [[self.containerView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    [self.containerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.centerX.equalTo(self);
    }];
}

-(UIButton *)createButtonWithText:(NSString *)buttonText AndColor:(UIColor *)color{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 100, 100);
    button.layer.cornerRadius = 50;
    button.clipsToBounds = YES;
    button.backgroundColor = color;
    [button setTitle:buttonText forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    return button;
}

-(void)idleView{
    if(self.inButton == nil){
        self.inButton = [self createButtonWithText:@"in" AndColor: [UIColor greenColor]];
        [self.inButton addTarget:self action:@selector(checkIn:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [self.inButton setHidden:NO];
    }
    
    if(self.skipButton == nil){
        self.skipButton = [self createButtonWithText:@"skip" AndColor:[UIColor redColor]];
        [self.skipButton addTarget:self action:@selector(skip:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [self.skipButton setHidden:NO];
    }
    
    [self.containerView addSubview:self.inButton];
    [self.containerView addSubview:self.skipButton];
    
    [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.greaterThanOrEqualTo(self.inButton);
        make.height.greaterThanOrEqualTo(self.skipButton);
    }];
    
    [self.inButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@100);
        make.centerY.equalTo(self.containerView);
        make.left.equalTo(self.containerView);
        make.right.equalTo(self.skipButton.mas_left).with.offset(-50);
    }];
    
    [self.skipButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@100);
        make.centerY.equalTo(self.containerView);
        make.right.equalTo(self.containerView);
    }];

}

-(void)checkedInView{
    if(self.outButton == nil){
        self.outButton = [self createButtonWithText:@"out" AndColor:[UIColor blueColor]];
        [self.outButton addTarget:self action:@selector(checkOut:) forControlEvents:UIControlEventAllTouchEvents];
    } else {
        [self.outButton setHidden:NO];
    }
    
    if(self.timeText == nil) {
        
        NSTimeInterval timePassed = [self.event.checkInTime timeIntervalSinceNow];
        NSTimeInterval duration = [self.event.endTime timeIntervalSinceDate:self.event.startTime];
        
        
        self.timeText = [[UILabel alloc] init];
        self.timer = [[MZTimerLabel alloc] initWithLabel:self.timeText andTimerType:MZTimerLabelTypeTimer];
        [self.timer setCountDownTime:(duration)];
        [self.timer addTimeCountedByTime:timePassed];
        [self.timer start];
    } else {
        [self.timeText setHidden:NO];
    }
    
    [self.containerView addSubview:self.outButton];
    [self.containerView addSubview:self.timeText];
    
    [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.greaterThanOrEqualTo(self.timeText);
        make.width.greaterThanOrEqualTo(self.outButton);
    }];
    
    [self.outButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@100);
        make.centerX.bottom.equalTo(self.containerView);
        make.top.equalTo(self.timeText.mas_bottom).with.offset(50);
    }];
    
    [self.timeText mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.top.equalTo(self.containerView);
    }];
    
}



-(void)checkedOutView{
    if(self.durationText == nil) {
        self.durationText = [[UILabel alloc] init];
        
        int duration = (int)[self.event.checkOutTime timeIntervalSinceDate:self.event.checkInTime];
        
        int seconds = duration % 60;
        int minutes = (duration /60) %60;
        int hours = (duration /3600);
        
        self.durationText.text = [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];
    } else {
        [self.durationText setHidden:NO];
    }
    
    if(self.outText == nil) {
        self.outText = [[UILabel alloc] init];
        self.outText.text = [self checkOutTime];
    } else {
        [self.outText setHidden:NO];
    }
    
    [self.containerView addSubview:self.outText];
    [self.containerView addSubview:self.durationText];
    
    [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.greaterThanOrEqualTo(self.outText);
        make.width.greaterThanOrEqualTo(self.durationText);
    }];
    
    [self.outText mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.bottom.equalTo(self.containerView);
        make.top.equalTo(self.durationText.mas_bottom).with.offset(50);
    }];
    
    [self.durationText mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.top.equalTo(self.containerView);
    }];
}

-(void)skippedView{
    if(self.skippedText == nil) {
        self.skippedText = [[UILabel alloc] init];
        self.skippedText.text = @"Skipped";
    } else {
        [self.skippedText setHidden:NO];
    }
    
    if(self.skippedX == nil) {
        self.skippedX = [[UILabel alloc] init];
        self.skippedX.text = @"X";
    } else {
        [self.skippedX setHidden:NO];
    }
    
    [self.containerView addSubview:self.skippedText];
    [self.containerView addSubview:self.skippedX];
    
    [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.greaterThanOrEqualTo(self.skippedText);
        make.width.greaterThanOrEqualTo(self.skippedX);
    }];
    
    [self.skippedText mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.bottom.equalTo(self.containerView);
        make.top.equalTo(self.skippedX.mas_bottom).with.offset(50);
    }];
    
    [self.skippedX mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.top.equalTo(self.containerView);
    }];
}

-(NSString *)checkOutTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"H:mm"];
    
    return [NSString stringWithFormat:@"Checked out at %@", [formatter stringFromDate:self.event.checkOutTime]];
}

@end
