//
//  UIView+BKLayout.m
//  weatherApp
//
//  Created by BKTurley on 3/25/13.
//  Copyright (c) 2013 BKTurley. All rights reserved.
//

#import "UIView+BKLayout.h"
#import "JRSwizzle.h"
#import <QuartzCore/QuartzCore.h>

#define USE_WHITELIST NO
#define DISPLAY_CLASSNAME YES
#define DISPLAY_OUTLINE YES

@implementation UIView (swizzle)

- (NSArray *) getWhiteList{
    return [[NSArray alloc] initWithObjects:@"UIButton", nil];
}

- (NSArray *) getBlackList{
    return [[NSArray alloc] initWithObjects:@"UIStatusBar",
                                            @"UIStatusBarWindow",
                                            @"UIStatusBarCorners",
                                            @"UIStatusBarBackgroundView",
                                            @"UIStatusBarForgroundView",
                                            @"UIStatusBarServiceItemView",
                                            @"UIStatusBarDataNetworkItemView",
                                            @"UIStatuBarBatteryItemView",
                                            @"UIStatuBarTimeItemView",
                                            @"UIWindow",
                                            nil];
}

+ (void) swizzle
{
    [UIView jr_swizzleMethod:@selector(initWithFrame:) withMethod:@selector(initWithFrame_swizzle:) error:nil];
}

- (id) initWithFrame_swizzle:(CGRect) frame
{
        //swizzle to origional implementation
	[UIView jr_swizzleMethod:@selector(initWithFrame:) withMethod:@selector(initWithFrame_swizzle:) error:nil];
    
        //get a default UIView
	id returnme = [self initWithFrame:frame];
    
    
    NSString *classNameString = [[returnme class] description];
    
    
    //populate whitelist
    NSArray * whiteList = [self getWhiteList];
    NSArray * blackList = [self getBlackList];

    
    //if on whitelist{
    
    BOOL onWhitelist = [whiteList containsObject:classNameString];
    BOOL onBlacklist = [blackList containsObject:classNameString];
    
    if(!onBlacklist){
        //add our label subview
        UILabel* classNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                            0,
                                                                            frame.size.width,
                                                                            frame.size.height)];


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
        
        [returnme addSubview:classNameLabel];
        
            // red boarder around all views
        self.layer.borderColor = [UIColor redColor].CGColor;
        self.layer.borderWidth = 1.0f;
    
    }
        //swizzle back to overridden implementaion
	[UIView jr_swizzleMethod:@selector(initWithFrame:) withMethod:@selector(initWithFrame_swizzle:) error:nil];

	return returnme;
}

@end
