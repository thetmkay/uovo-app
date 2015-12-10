//
//  EventCell.m
//  uovo
//
//  Created by George Nishimura on 08/12/2015.
//  Copyright © 2015 ytil. All rights reserved.
//

#import "EventCell.h"

@implementation EventCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)formatForEvent:(Event *)event {
    NSDateFormatter * timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"H:mm"];
    
    NSString * startTime = [timeFormatter stringFromDate: event.startTime] ;
    NSString * endTime = [timeFormatter stringFromDate:event.endTime];
    
    self.textLabel.text = event.name;
    self.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", startTime, endTime];
    
    NSInteger index = 7;
    if(event.colorId != nil && [event.colorId integerValue] > 0) {
        index = [event.colorId integerValue] - 1;
    }
    
    self.backgroundColor = [[UIColor calendarColors] objectAtIndex:index];
}

@end
