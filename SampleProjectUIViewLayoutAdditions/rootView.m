//
//  rootView.m
//  SampleProjectUIViewLayoutAdditions
//
//  Created by BKTurley on 3/28/13.
//  Copyright (c) 2013 BKTurley. All rights reserved.
//

#import "rootView.h"

@interface rootView ()
@property UILabel * instructionLabel;
@property UIButton * closeAppButton;
@end


@implementation rootView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.instructionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 75)];
        self.instructionLabel.text = @"Where is the Button?";
        self.instructionLabel.textColor = [UIColor brownColor];        [self addSubview:self.instructionLabel];
        
        self.closeAppButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
        [self.closeAppButton addTarget:self action:@selector(closeAppButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.closeAppButton];
    }
    return self;
}

- (void) closeAppButtonTapped{
    if ([self.closeAppButton.backgroundColor isEqual:[UIColor clearColor]]){
        self.closeAppButton.backgroundColor = [UIColor brownColor];
    }else{
        self.closeAppButton.backgroundColor = [UIColor clearColor];
    }
}

#pragma mark helpers


@end
