//
//  GRContext.m
//  Engine
//
//  Created by Simon Andersson on 6/21/12.
//  Copyright (c) 2012 Hiddencode.me. All rights reserved.
//

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
