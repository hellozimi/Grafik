//
//  GRAction.m
//  Grafik
//
//  Created by Simon Andersson on 7/19/12.
//  Copyright (c) 2012 Hiddencode.me. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining
//  a copy of this software and associated documentation files (the
//  "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to
//  the following conditions:
//  
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
//  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
//  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

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