//
//  GRContext.m
//  Grafik
//
//  Created by Simon Andersson on 6/21/12.
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

#import "GRContext.h"

@implementation GRContext
@synthesize context = context_;

+ (GRContext *)sharedContext {
    static dispatch_once_t pred;
    
    static GRContext *CONTEXT_INSTANCE = NULL;
    
    dispatch_once(&pred, ^{
        CONTEXT_INSTANCE = [[GRContext alloc] init];
    });
    
    return CONTEXT_INSTANCE;
}

+ (void)useContext {
    EAGLContext *context = [[GRContext sharedContext] context];
    if ([EAGLContext currentContext] != context) {
        [EAGLContext setCurrentContext:context];
    }
}

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)presentBufferForDisplay {
    [self.context presentRenderbuffer:GL_RENDERBUFFER];
}

- (EAGLContext *)context {
    if (context_ == nil) {
        context_ = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
        [EAGLContext setCurrentContext:context_];
    }
    
    return context_;
}

@end
