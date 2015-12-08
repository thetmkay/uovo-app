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
}

-(void)clearView{
    
    if(self.containerView == nil){
        self.containerView = [[UIView alloc] init];
        [self addSubview:self.containerView];
    } else {
        [[self.containerView subviews] makeObjectsPerformSelector:@selector(setHidden:) withObject:[NSNumber numberWithBool:YES]];
        [[self.containerView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
}

-(void)idleView{
    if(self.inButton == nil){
        self.inButton = [[RoundButton alloc] initWithText:@"in"];
        self.inButton.backgroundColor = [UIColor greenColor];
    } else {
        [self.inButton setHidden:NO];
    }
    
    if(self.skipButton == nil){
        self.skipButton = [[RoundButton alloc] initWithText:@"skip"];
        self.skipButton.backgroundColor = [UIColor redColor];
    } else {
        [self.skipButton setHidden:NO];
    }
    
    [self.containerView addSubview:self.inButton];
    [self.containerView addSubview:self.skipButton];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.centerX.equalTo(self);
    }];
    
    [self.inButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.containerView);
        make.left.equalTo(self.containerView);
        make.right.equalTo(self.skipButton.mas_left).with.offset(-50);
    }];
    
    [self.skipButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.containerView);
        make.right.equalTo(self.containerView);
    }];

}

-(void)checkedInView{
    
}

-(void)checkedOutView{
    
}

-(void)skippedView{
    
}

@end
