//
//  ViewController.m
//  GrafikExample
//
//  Created by Simon Andersson on 7/23/12.
//  Copyright (c) 2012 Hiddencode.me. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[GRContext sharedContext] context];
    
    glView_ = [[GRGLView alloc] initWithFrame:CGRectMake(0, 0, 480, 320)];
    
    [self.view addSubview:glView_];
    
    [[GREngine sharedEngine] setGlView:glView_];
    
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

@end
