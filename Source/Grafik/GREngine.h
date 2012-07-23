//
//  GREngine.h
//  Engine
//
//  Created by Simon Andersson on 7/22/12.
//  Copyright (c) 2012 Hiddencode.me. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRGLView;
#import "GRTypes.h"

@interface GREngine : NSObject {
    NSMutableArray *updateTargets_, *renderTargets_;
    
    GLuint renderbuffer_;
    GLuint framebuffer_;
    
    GLint backingWidth_;
    GLint backingHeight_;
    
    GLKMatrix4 projMatrix_;
    
    CGSize viewSize_;
    
    float tick_;
}

@property (nonatomic, strong) GRGLView *glView;
@property (nonatomic, assign) float frameInterval;

@property (nonatomic, assign) grColor4b clearColor;

@property (nonatomic, strong) GLKBaseEffect *baseEffect;
@property (nonatomic, readonly) CGSize windowSize;

@property (nonatomic, readonly) GLKMatrix4 projectionMatrix;

@property (nonatomic, readonly) float tick;

+ (GREngine *)sharedEngine;
- (void)scheduleForUpdate:(id)target selector:(SEL)selector;
- (void)scheduleForRender:(id)target selector:(SEL)selector;

@end

@interface GRScheduleTarget : NSObject

@property (assign) id target;
@property (assign) SEL selector;

+ (GRScheduleTarget *)targetWithTarget:(id)target selector:(SEL)selector;

@end
