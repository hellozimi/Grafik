//
//  GRWorld.m
//  Engine
//
//  Created by Simon Andersson on 7/22/12.
//  Copyright (c) 2012 Hiddencode.me. All rights reserved.
//

#import "GRWorld.h"
#import "GREngine.h"

@implementation GRWorld

- (id)init {
    self = [super init];
    
    if (self) {
        CGSize size = [GREngine sharedEngine].windowSize;
        self.contentSize = size;
        self.anchorPoint = CGPointMake(0.5, 0.5);
    }
    return self;
}

@end
