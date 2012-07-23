//
//  GREngine.m
//  Grafik
//
//  Created by Simon Andersson on 7/22/12.
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

#import "GREngine.h"
#import "GRContext.h"
#import "GRGLView.h"

static GREngine *ENGINE_INSTANCE = NULL;

@interface GREngine ()
- (void)performSelector:(SEL)aSelector target:(id)aTarget primitive:(void *)p;
- (void)createFramebuffers;

@end

@implementation GREngine {
    CADisplayLink *displayLink_;
}

@synthesize glView = glView_;
@synthesize baseEffect = baseEffect_;
@synthesize projectionMatrix = projMatrix_;
@synthesize tick = tick_;
@synthesize clearColor = clearColor_;
@synthesize frameInterval;
@synthesize windowSize;

+ (GREngine *)sharedEngine {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ENGINE_INSTANCE = [[self alloc] init];
    });
    
    return ENGINE_INSTANCE;
}

- (id)init {
    self = [super init];
    if (self) {
        updateTargets_ = [[NSMutableArray alloc] init];
        renderTargets_ = [[NSMutableArray alloc] init];
        
        displayLink_ = [CADisplayLink displayLinkWithTarget:self selector:@selector(gameLoop:)];
        displayLink_.frameInterval = 2;
        [displayLink_ addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        
        baseEffect_ = [[GLKBaseEffect alloc] init];
        
        projMatrix_ = GLKMatrix4MakeOrtho(0, 320, 0, 320, -1024, 1024);
        baseEffect_.transform.projectionMatrix = projMatrix_;
        
        clearColor_.r = 0.0;
        clearColor_.g = 0.0;
        clearColor_.b = 0.0;
        clearColor_.a = 1.0;
    }
    return self;
}

- (void)createFramebuffers {
    
    glGenRenderbuffers(1, &renderbuffer_);
    glBindRenderbuffer(GL_RENDERBUFFER, renderbuffer_);
    
    [[[GRContext sharedContext] context] renderbufferStorage:GL_RENDERBUFFER fromDrawable:(CAEAGLLayer *)glView_.layer];
    
    glGenFramebuffers(1, &framebuffer_);
    glBindFramebuffer(GL_FRAMEBUFFER, framebuffer_);
    
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, renderbuffer_);
    
    
    glBindRenderbuffer(GL_RENDERBUFFER, renderbuffer_);
    [[[GRContext sharedContext] context] renderbufferStorage:GL_RENDERBUFFER fromDrawable:(CAEAGLLayer *)glView_.layer];
    
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &backingWidth_);
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &backingHeight_);
    
    if (glCheckFramebufferStatus(GL_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE)
    {
        NSLog(@"Failed to make complete framebuffer object %x", glCheckFramebufferStatus(GL_FRAMEBUFFER));
    }
    
    glViewport(0, 0, backingWidth_, backingHeight_);
}

- (void)setGlView:(GRGLView *)glView {
    glView_ = glView;
    
    viewSize_ = glView.frame.size;
    
    [self createFramebuffers];
}

- (void)performSelector:(SEL)aSelector target:(id)aTarget primitive:(void *)p {
    
    NSInvocation *invoc = [NSInvocation invocationWithMethodSignature:[aTarget methodSignatureForSelector:aSelector]];
    [invoc setSelector:aSelector];
    [invoc setTarget:aTarget];
    
    [invoc setArgument:p atIndex:2];
    [invoc performSelector:@selector(invoke) withObject:nil];
}

- (CGSize)windowSize {
    return viewSize_;
}

- (void)gameLoop:(CADisplayLink *)displayLink {
    
    if (!glView_) {
        return;
    }
    tick_ = displayLink.duration * displayLink.frameInterval;
    
    // UPDATE
    for (GRScheduleTarget *target in updateTargets_) {
        if ([target.target respondsToSelector:target.selector]) {
            float time = tick_;
            
            [self performSelector:target.selector target:target.target primitive:&time];
        }
    }
    
    glClearColor(clearColor_.r, clearColor_.g, clearColor_.b, clearColor_.a);
    glClear(GL_COLOR_BUFFER_BIT);
    
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glEnable(GL_BLEND);
    
    // Render
    for (GRScheduleTarget *target in renderTargets_) {
        if ([target.target respondsToSelector:target.selector]) {
            float time = tick_;
            [self performSelector:target.selector target:target.target primitive:&time];
        }
    }
    
    glBindRenderbuffer(GL_RENDERER, renderbuffer_);
    
    [[GRContext sharedContext] presentBufferForDisplay];
}

- (void)scheduleForUpdate:(id)target selector:(SEL)selector {
    GRScheduleTarget *targetToSchedule = [GRScheduleTarget targetWithTarget:target selector:selector];
    [updateTargets_ addObject:targetToSchedule];
}

- (void)scheduleForRender:(id)target selector:(SEL)selector {
    GRScheduleTarget *targetToSchedule = [GRScheduleTarget targetWithTarget:target selector:selector];
    [renderTargets_ addObject:targetToSchedule];
}

- (void)unsheduleTarget:(id)target {
    [self unscheduleUpdateForTarget:self];
    [self unscheduleRenderForTarget:target];
}

- (void)unscheduleRenderForTarget:(id)target {
    if ([renderTargets_ containsObject:target]) {
        [renderTargets_ removeObject:target];
    }
}

- (void)unscheduleUpdateForTarget:(id)target {
    if ([updateTargets_ containsObject:target]) {
        [updateTargets_ removeObject:target];
    }
}

- (void)setFrameInterval:(float)_frameInterval {
    displayLink_.frameInterval = _frameInterval;
}

@end

@implementation GRScheduleTarget
@synthesize target = target_, selector = selector_;

+ (GRScheduleTarget *)targetWithTarget:(id)target selector:(SEL)selector {
    GRScheduleTarget *tgt = [[self alloc] init];
    tgt.target = target;
    tgt.selector = selector;
    
    return tgt;
}

@end