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

@interface UIView()
    //@property (nonatomic) NSArray * whiteList; //class names that should be displayed
@end

@implementation UIView (swizzle)

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
    

    //populate whitelist
    NSArray * whiteList = [[NSArray alloc] initWithObjects:
                                                      @"UIButton",
                                                      nil];
    
    NSString *classNameString = [[returnme class] description];
    
    //if on whitelist{
    
    BOOL onWhitelist = [whiteList containsObject:classNameString];
    
    if(onWhitelist){
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
