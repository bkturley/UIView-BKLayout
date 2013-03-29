//
//  rootViewController.m
//  SampleProjectUIViewLayoutAdditions
//
//  Created by BKTurley on 3/28/13.
//  Copyright (c) 2013 BKTurley. All rights reserved.
//

#import "rootViewController.h"
#import "rootView.h"

@interface rootViewController ()
@property rootView * rootView;
@end

@implementation rootViewController


- (id)init
{
    self = [super init];
    if (self) {
            // Custom initialization
        self.rootView = [[rootView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
        self.view = self.rootView;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
