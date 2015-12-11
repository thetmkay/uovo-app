//
//  EventCell.h
//  uovo
//
//  Created by George Nishimura on 08/12/2015.
//  Copyright © 2015 ytil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import "UIColor+UVColor.h"
#import "Masonry/Masonry.h"

@interface EventCell : UITableViewCell

@property UILabel * nameLabel;
@property UILabel * statusLabel;
@property UIView * statusIndicator;
@property UIView * textView;

- (void)formatForEvent:(Event *)event;

@end
