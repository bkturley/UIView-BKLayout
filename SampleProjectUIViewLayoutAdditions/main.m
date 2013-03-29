//
//  main.m
//  SampleProjectUIViewLayoutAdditions
//
//  Created by BKTurley on 3/28/13.
//  Copyright (c) 2013 BKTurley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+swizzle.h"
#import "AppDelegate.h"


int main(int argc, char *argv[])
{
    @autoreleasepool {
        #ifdef LAYOUT
            [UIView swizzle];
        #endif
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
