//
//  EventCell.m
//  uovo
//
//  Created by George Nishimura on 08/12/2015.
//  Copyright © 2015 ytil. All rights reserved.
//

#import "EventCell.h"

@implementation EventCell

const NSInteger INDICATOR_SIZE = 14;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    
    self.nameLabel = [[UILabel alloc] init];
    [self.nameLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:16]];
    self.nameLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    
    self.statusLabel = [[UILabel alloc] init];
    [self.statusLabel setFont: [UIFont fontWithName:@"Helvetica Neue" size:11]];
    
    self.statusIndicator = [[UIView alloc] init];
    self.statusIndicator.frame = CGRectMake(0,0,INDICATOR_SIZE,INDICATOR_SIZE);
    self.statusIndicator.layer.cornerRadius = INDICATOR_SIZE/2;
    
    self.textView = [[UIView alloc] init];
    
    [self.textView addSubview:self.nameLabel];
    [self.textView addSubview:self.statusLabel];
    
    [self addSubview:self.textView];
    [self addSubview:self.statusIndicator];
    
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)constrainSubviews{
    
    

    
    NSInteger topOffset = 10;
    NSInteger leftOffset = 25;
    
    [self.statusIndicator mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo([NSNumber numberWithInteger:INDICATOR_SIZE]);
        make.centerY.equalTo(self);
        make.left.equalTo(self).with.offset(20);
        make.right.equalTo(self.textView.mas_left);
    }];
    
    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.top.equalTo(self).with.offset(topOffset);
    }];
    
    [self.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView);
        make.left.equalTo(self.textView).with.offset(leftOffset);
    }];
    
    [self.statusLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).with.offset(5);
        make.left.equalTo(self.textView).with.offset(leftOffset);
    }];
    
}

- (void)formatForEvent:(Event *)event {
    
    NSDateFormatter * timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"H:mm"];
    
    NSString * startTime;
    NSString * endTime;
    

    self.nameLabel.text = event.name;
    
    
    switch ([event getStatus]) {
        case Skipped:
            self.statusLabel.text = @"Skipped";
            self.statusIndicator.backgroundColor = [UIColor uovoRed];
            break;
        case CheckedOut:
            startTime = [timeFormatter stringFromDate: event.checkInTime];
            endTime = [timeFormatter stringFromDate:event.checkOutTime];
            self.statusLabel.text = [NSString stringWithFormat:@"%@ - %@", startTime, endTime];
            self.statusIndicator.backgroundColor = [UIColor uovoGreen];
            break;
        case CheckedIn:
            startTime = [timeFormatter stringFromDate: event.checkInTime];
            self.statusLabel.text = [NSString stringWithFormat:@"Checked in at %@", startTime];
            self.statusIndicator.backgroundColor = [UIColor uovoOrange];
            break;
        case Idle:
        default:
            startTime = [timeFormatter stringFromDate: event.startTime];
            endTime = [timeFormatter stringFromDate:event.endTime];
            self.statusLabel.text = [NSString stringWithFormat:@"%@ - %@", startTime, endTime];
            self.statusIndicator.backgroundColor = [UIColor uovoGrey];
            break;
    }
    
    [self constrainSubviews];
}

@end
