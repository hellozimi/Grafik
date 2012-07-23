//
//  GRAction.h
//  Engine
//
//  Created by Simon Andersson on 7/19/12.
//  Copyright (c) 2012 Hiddencode.me. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GRSpriteAction;

@interface GRSpriteAction : NSObject {
    NSMutableArray *frames_;
}

@property (strong, nonatomic) NSMutableArray *frames;
@property (assign) float animationInterval;

+ (id)action;
- (void)addSpriteFrame:(GRSpriteAction *)spriteFrame;

@end

@interface GRSpriteFrame : NSObject {
    CGPoint offset_;
    CGSize size_;
}

@property (assign) CGPoint offset;
@property (assign) CGSize size;

+ (id)spriteFrame;
+ (id)spriteFrameWithOffset:(CGPoint)offset size:(CGSize)size;

@end
