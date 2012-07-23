//
//  GREngine.h
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
