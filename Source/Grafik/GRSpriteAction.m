//
//  GRAction.m
//  Engine
//
//  Created by Simon Andersson on 7/19/12.
//  Copyright (c) 2012 Hiddencode.me. All rights reserved.
//

#import "GRSpriteAction.h"

@implementation GRSpriteAction
@synthesize frames = frames_;
@synthesize animationInterval = animationInterval_;
+ (id)action {
    return [[self alloc] init];
}

- (id)init {
    self = [super init];
    if (self) {
        self.animationInterval = 0.25;
        frames_ = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addSpriteFrame:(GRSpriteFrame *)spriteFrame {
    if ([spriteFrame isKindOfClass:[GRSpriteFrame class]]) {
        [frames_ addObject:spriteFrame];
    }
}

@end

@implementation GRSpriteFrame
@synthesize size = size_, offset = offset_; 

+ (id)spriteFrame {
    return [[self alloc] init];
}

+ (id)spriteFrameWithOffset:(CGPoint)offset size:(CGSize)size {
    GRSpriteFrame *spriteFrame = [[self alloc] init];
    spriteFrame.offset = offset;
    spriteFrame.size = size;
    return spriteFrame;
}

@end