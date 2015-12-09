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

-(IBAction)checkIn:(id)sender {
    NSLog(@"checkIn");
    [self configureForStatus:CheckedIn];
}

-(IBAction)checkOut:(id)sender {
    NSLog(@"checkOut");
    [self configureForStatus:CheckedOut];
}

-(IBAction)skip:(id)sender {
    NSLog(@"skip");
    [self configureForStatus:Skipped];
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
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
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
        self.timeText = [[UILabel alloc] init];
        self.timeText.text = @"0:00";
    } else {
        [self.timeText setHidden:NO];
    }
    
    [self.containerView addSubview:self.outButton];
    [self.containerView addSubview:self.timeText];
    
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
    if(self.timeText == nil) {
        self.timeText = [[UILabel alloc] init];
        self.timeText.text = @"0:00";
    } else {
        [self.timeText setHidden:NO];
    }
    
    if(self.outText == nil) {
        self.outText = [[UILabel alloc] init];
        self.outText.text = @"Checked Out At 9:55";
    } else {
        [self.outText setHidden:NO];
    }
    
    [self.containerView addSubview:self.outText];
    [self.containerView addSubview:self.timeText];
    
    [self.outText mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.bottom.equalTo(self.containerView);
        make.top.equalTo(self.timeText.mas_bottom).with.offset(50);
    }];
    
    [self.timeText mas_remakeConstraints:^(MASConstraintMaker *make) {
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
    
    [self.skippedText mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.bottom.equalTo(self.containerView);
        make.top.equalTo(self.skippedX.mas_bottom).with.offset(50);
    }];
    
    [self.skippedX mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.top.equalTo(self.containerView);
    }];
}

@end
