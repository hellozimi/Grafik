//
//  GRGLView.m
//  Engine
//
//  Created by Simon Andersson on 6/21/12.
//  Copyright (c) 2012 Hiddencode.me. All rights reserved.
//

#import "GRGLView.h"

@implementation GRGLView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        CAEAGLLayer *eaglLayer = (CAEAGLLayer *)self.layer;
        eaglLayer.opaque = YES;
        eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithBool:NO], kEAGLDrawablePropertyRetainedBacking,
                                        kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat, nil];
    }
    return self;
}

+ (Class)layerClass {
    return [CAEAGLLayer class];
}

@end
