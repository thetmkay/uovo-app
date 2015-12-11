//
//  UIColor+UVColor.m
//  uovo
//
//  Created by George Nishimura on 10/12/2015.
//  Copyright © 2015 ytil. All rights reserved.
//

#import "UIColor+UVColor.h"

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

@implementation UIColor (UVColor)

+(UIColor *)uovoGreen{
    return UIColorFromRGB(0x51b749);
}

+(UIColor *)uovoOrange{
    return UIColorFromRGB(0xffb878);
}

+(UIColor *)uovoGrey{
    return UIColorFromRGB(0xe1e1e1);
}

+(UIColor *)uovoRed{
    return UIColorFromRGB(0xdc2127);
}

+(NSArray *) calendarColors {
    return [NSArray arrayWithObjects:
     UIColorFromRGB(0xa4bdfc) //1 - violet
     ,UIColorFromRGB(0x7ae7bf) //2 - mint
     ,UIColorFromRGB(0xdbadff) //3 - purple
     ,UIColorFromRGB(0xff887c) //4 - pink
     ,UIColorFromRGB(0xfbd75b) //5 - yellow
     ,UIColorFromRGB(0xffb878) //6 - orange
     ,UIColorFromRGB(0x46d6db) //7 - cyan
     ,UIColorFromRGB(0xe1e1e1) //8 - grey
     ,UIColorFromRGB(0x5484ed) //9 - blue
     ,UIColorFromRGB(0x51b749) //10 - green
     ,UIColorFromRGB(0xdc2127) //11 - red
     , nil];
}

@end
