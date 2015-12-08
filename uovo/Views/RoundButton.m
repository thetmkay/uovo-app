//
//  RoundButton.m
//  uovo
//
//  Created by George Nishimura on 08/12/2015.
//  Copyright © 2015 ytil. All rights reserved.
//

#import "RoundButton.h"

@implementation RoundButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithText:(NSString *)titleText{
    self = [super init];
    NSLog(@"titleText: %@", titleText);

    [self setTitle:titleText forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.contentMode = UIViewContentModeScaleAspectFill;
    self.clipsToBounds = YES;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@100);
        make.height.equalTo(@100);
//        make.centerX.centerY.equalTo(self.titleLabel);
    }];
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self addMaskToBounds:self.frame];
}

#pragma mark - Circular mask - taken from AMBCircularButton https://github.com/alvaromb/AMBCircularButton/blob/master/AMBCircularButton/AMBCircularButton.m

- (void)addMaskToBounds:(CGRect)maskBounds
{
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];

    CGPathRef maskPath = CGPathCreateWithEllipseInRect(maskBounds, NULL);
    maskLayer.bounds = maskBounds;
    maskLayer.path = maskPath;
    maskLayer.fillColor = [UIColor blackColor].CGColor;
    CGPathRelease(maskPath);
    
    CGPoint point = CGPointMake(maskBounds.size.width/2, maskBounds.size.height/2);
    maskLayer.position = point;
    
    [self.layer setMask:maskLayer];
}

@end
