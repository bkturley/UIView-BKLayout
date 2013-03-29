//
//  UIView+_swizzle.m
//  weatherApp
//
//  Created by BKTurley on 3/25/13.
//  Copyright (c) 2013 BKTurley. All rights reserved.
//

#import "UIView+swizzle.h"
#import "JRSwizzle.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (swizzle)
+ (void) swizzle
{
    [UIView jr_swizzleMethod:@selector(initWithFrame:) withMethod:@selector(initWithFrame_swizzle:) error:nil];
    
        //[UIView jr_swizzleMethod:@selector(layoutSubviews) withMethod:@selector(layoutSubviews_swizzle) error:nil];
}

- (id) initWithFrame_swizzle:(CGRect) frame
{
        //swizzle to origional implementation
	[UIView jr_swizzleMethod:@selector(initWithFrame:) withMethod:@selector(initWithFrame_swizzle:) error:nil];
    
        //get a default UIView
	id result = [self initWithFrame:frame];
    
        //add our label subview
    UILabel* classNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                        0,
                                                                        frame.size.width,   frame.size.height) ];

    
    NSString *classNameString = [[result class] description];
    classNameLabel.text = classNameString;
    classNameLabel.alpha = .6;
    
    //if super.backgroundcolor isn't a shade of red
    classNameLabel.textColor = [UIColor redColor];
    //else
    //classNameLabel.textColor = [UIColor whiteColor];
    
    classNameLabel.font = [UIFont fontWithName:@"Marker Felt" size:18];
    classNameLabel.backgroundColor = [UIColor clearColor];
    classNameLabel.adjustsFontSizeToFitWidth = YES;

    [classNameLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    
    [result addSubview:classNameLabel];
    
    
        // red boarder around all views
    self.layer.borderColor = [UIColor redColor].CGColor;
    self.layer.borderWidth = 1.0f;
    
        //swizzle back to overridden implementaion
	[UIView jr_swizzleMethod:@selector(initWithFrame:) withMethod:@selector(initWithFrame_swizzle:) error:nil];

        //@TODO -
        //[self setBackgroundColor:[UIColor randomColor]];
        // or
        //[self setBackgroundColor:[UIColor prevcolor++]];

	return result;
}

//-(void) layoutSubviews_swizzle{
//    [UIView jr_swizzleMethod:@selector(layoutSubviews) withMethod:@selector(layoutSubviews_swizzle) error:nil];
//    
//        //do stuff
//    
//    
//    [UIView jr_swizzleMethod:@selector(layoutSubviews) withMethod:@selector(layoutSubviews_swizzle) error:nil];
//}

@end
