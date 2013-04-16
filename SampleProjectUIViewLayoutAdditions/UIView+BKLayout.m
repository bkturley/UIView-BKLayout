//
//  UIView+BKLayout.m
//  weatherApp
//
//  Created by BKTurley on 3/25/13.
//

#import "UIView+BKLayout.h"
#import "JRSwizzle.h"
#import <QuartzCore/QuartzCore.h>

#pragma mark - LAYOUT CONFIGURATION

    // only show layout additions for UIViews on a whitelist?
#define USE_WHITELIST YES
#define USE_BLACKLIST YES
    // include outline annotation?
#define DISPLAY_OUTLINE YES

    // display classname annotation?

#define DISPLAY_CLASSNAME YES
#define CLASSNAME_ALPHA 1


@implementation UIView (swizzle)

- (NSArray *) createWhiteList{
    return [[NSArray alloc] initWithObjects:@"UIButton",
                                            nil];
}

- (NSArray *) createBlackList{
    return [[NSArray alloc] initWithObjects:@"UIStatusBar",
                                            @"UIStatusBarWindow",
                                            @"UIStatusBarCorners",
                                            @"UIStatusBarBackgroundView",
                                            @"UIStatusBarForegroundView",
                                            @"UIStatusBarServiceItemView",
                                            @"UIStatusBarDataNetworkItemView",
                                            @"UIStatusBarBatteryItemView",
                                            @"UIStatusBarTimeItemView",
                                            @"UIWindow",
                                            nil];
}

+ (void) swizzle{
    [UIView jr_swizzleMethod:@selector(initWithFrame:) withMethod:@selector(initWithFrame_swizzle:) error:nil];
}

- (id) initWithFrame_swizzle:(CGRect) frame{
        //swizzle to origional implementation
	[UIView jr_swizzleMethod:@selector(initWithFrame:) withMethod:@selector(initWithFrame_swizzle:) error:nil];
    
        //get a default UIView
	UIView * returnme = [self initWithFrame:frame];
    
    [self drawAnnotationsIfNeeded:returnme];
    
        //swizzle back to overridden implementaion
    [UIView jr_swizzleMethod:@selector(initWithFrame:) withMethod:@selector(initWithFrame_swizzle:) error:nil];

	return returnme;
}

- (void)drawAnnotationsIfNeeded:(UIView*)annotateMe{
    
    static NSArray * blackList;
    static NSArray * whiteList;

    [self createAccessListsWithWhiteList:whiteList andBlacklist:blackList];

    NSString *classNameString = [[annotateMe class] description];
    BOOL onBlacklist = [blackList containsObject:classNameString];
    
    if(!onBlacklist){
        
        BOOL onWhitelist = [whiteList containsObject:classNameString];
        
        if(USE_WHITELIST && onWhitelist){
            [self addSubview:[self createClassNameLabelForUIView:self]];
            [self drawOutlineIfNeeded];
            
        }else if(!USE_WHITELIST){
            [self addSubview:[self createClassNameLabelForUIView:self]];
            [self drawOutlineIfNeeded];
        }
    }
}

- (void) createAccessListsWithWhiteList:(NSArray *)whitelist andBlacklist:(NSArray *)blacklist{
    static BOOL firstRun = YES;
    if(firstRun){
        if(USE_BLACKLIST)
            blacklist = [self createBlackList];
        if(USE_WHITELIST)
            whitelist = [self createWhiteList];
        firstRun = NO;
    }
}

- (void) drawOutlineIfNeeded{
    if(DISPLAY_OUTLINE){
        self.layer.borderColor = [UIColor redColor].CGColor;
        self.layer.borderWidth = 1.0f;
    }
}

- (UILabel *)createClassNameLabelForUIView:(UIView *)view{
    
    NSString *classNameString =  NSStringFromClass([view class]);
    
    UILabel* classNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(
                                                                        0,
                                                                        0,
                                                                        view.frame.size.width,
                                                                        view.frame.size.height)];
    
    classNameLabel.text = classNameString;
    classNameLabel.alpha = CLASSNAME_ALPHA;
    
        //if super.backgroundcolor isn't a shade of red
    classNameLabel.textColor = [UIColor redColor];
        //else
        //classNameLabel.textColor = [UIColor whiteColor];
    
    classNameLabel.font = [UIFont fontWithName:@"Marker Felt" size:18];
    classNameLabel.backgroundColor = [UIColor clearColor];
    classNameLabel.adjustsFontSizeToFitWidth = YES;
    
    [classNameLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    

    return classNameLabel;
}

@end
