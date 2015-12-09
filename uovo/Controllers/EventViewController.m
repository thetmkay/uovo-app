//
//  EventViewController.m
//  uovo
//
//  Created by George Nishimura on 08/12/2015.
//  Copyright © 2015 ytil. All rights reserved.
//

#import "EventViewController.h"

@interface EventViewController ()

@end

@implementation EventViewController

- (id) initWithEvent:(Event *)event {
    self = [super init];
    self.event = event;
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view setClipsToBounds:YES];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.controlView =  [[EventControlView alloc] initWithEvent:self.event];
    
    [self.view addSubview:self.controlView];
    [self.view setLayoutMargins:UIEdgeInsetsZero];
    
    [self.controlView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.equalTo(@400);
    }];
    
    [self initTextViews];
    
    [self.navigationItem setTitle:self.event.title];
    
    return self;
}

- (void) initTextViews{
    UIView *textContainer = [[UIView alloc] init];
    
        [self.view addSubview:textContainer];
    
    [textContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.controlView.mas_top);
    }];
    

    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"DD/MM/YYYY' at 'H:mm"];
    
    UILabel * startTime = [[UILabel alloc] init];
    startTime.text = [dateFormatter stringFromDate:self.event.startTime];
    startTime.textColor = [UIColor blackColor];
    
    UILabel * endTime = [[UILabel alloc] init];
    endTime.text = [dateFormatter stringFromDate:self.event.endTime];
    endTime.textColor = [UIColor blackColor];
    
    [textContainer addSubview:startTime];
    [textContainer addSubview:endTime];
    
    [startTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(textContainer).with.offset(40);
        make.top.equalTo(textContainer).with.offset(90);
    }];
    
    [endTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(startTime);
//        make.bottom.equalTo(textContainer).with.offset(50);
        make.top.equalTo(startTime.mas_bottom).with.offset(10);
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationItem setTitle:self.event.title];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
