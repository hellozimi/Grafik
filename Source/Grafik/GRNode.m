//
//  GRNode.m
//  Grafik
//
//  Created by Simon Andersson on 7/18/12.
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

#import "GRNode.h"

@interface GRNode ()
- (void)allocateChildren;
- (void)reorderByZIndex;
- (void)_setZIndex:(NSInteger)index;
@end

@implementation GRNode
@synthesize scaleX = scaleX_;
@synthesize scaleY = scaleY_;
@synthesize scale = scale_;
@synthesize rotation = rotation_;
@synthesize position = position_;
@synthesize anchorPoint = anchorPoint_;
@synthesize contentSize = contentSize_;
@synthesize anchorPointInPoints = anchorPointInPoints_;
@synthesize visible = visible_;
@synthesize zIndex = zIndex_;
@synthesize children = children_;
@synthesize parent = parent_;

- (id)init {
    self = [super init];
    if (self) {
        
        rotation_ = 0;
        scaleX_ = scaleY_ = 1;
        position_ = GLKVector2Zero;
        visible_ = YES;
        anchorPoint_ = anchorPointInPoints_ = CGPointZero;
        zIndex_ = 0;
        
    }
    return self;
}

+ (id)node {
    return [[self alloc] init];
}

- (GLKMatrix4)modelMatrix {
    
    GLKMatrix4 modelMatrix = GLKMatrix4Identity;
    
    if (!CGPointEqualToPoint(CGPointZero, anchorPoint_)) {
        modelMatrix = GLKMatrix4Translate(modelMatrix, position_.x + anchorPointInPoints_.x, position_.y + anchorPointInPoints_.y, 0);
    }
    else {
        modelMatrix = GLKMatrix4Translate(modelMatrix, position_.x, position_.y, 0);
    }
    
    modelMatrix = GLKMatrix4Scale(modelMatrix, scaleX_, scaleY_, 1);
    modelMatrix = GLKMatrix4Rotate(modelMatrix, rotation_, 0, 0, -1);
    
    if (!CGPointEqualToPoint(CGPointZero, anchorPoint_)) {
        modelMatrix = GLKMatrix4Translate(modelMatrix, -anchorPointInPoints_.x, -anchorPointInPoints_.y, 0);
    }
    return modelMatrix;
}

- (void)setScale:(float)scale {
    scaleX_ = scaleY_ = scale;
}

- (void)setAnchorPoint:(CGPoint)anchorPoint {
    if (!CGPointEqualToPoint(anchorPoint, anchorPoint_)) {
        anchorPoint_ = anchorPoint;
        anchorPointInPoints_ = CGPointMake(contentSize_.width * anchorPoint.x, contentSize_.height * anchorPoint.y);
    }
}

- (void)allocateChildren {
    children_ = [[NSMutableArray alloc] initWithCapacity:2];
}

- (void)_setZIndex:(NSInteger)index {
    
    zIndex_ = index;
}

- (void)setZIndex:(NSInteger)zIndex {
    
    [self _setZIndex:zIndex];
    
    isChildrenOrderDirty_ = YES;
    
    if (parent_) {
        [parent_ reorderChild:self zOrder:zIndex];
    }
}

- (NSComparisonResult)compareZ:(GRNode *)node {
    return (node.zIndex > self.zIndex ? NSOrderedDescending : (node.zIndex < self.zIndex ? NSOrderedAscending : NSOrderedSame));
}

- (void)reorderByZIndex {
    
    if (isChildrenOrderDirty_) {
        [children_ sortUsingSelector:@selector(compareZ:)];
        
        isChildrenOrderDirty_ = NO;
    }
    
}

- (void)reorderChild:(GRNode *)node zOrder:(NSInteger)z {
    isChildrenOrderDirty_ = YES;
    
    [node _setZIndex:z];
}

- (void)addChild:(GRNode *)node {
    
    if (node == nil) {
        return;
    }
    
    if (!children_) {
        [self allocateChildren];
    }
    
    node.parent = self;
    
    [children_ addObject:node];
    
    isChildrenOrderDirty_ = YES;
}

- (void)removeChild:(GRNode *)node {
    [children_ removeObject:node];
    
    node.parent = nil;
    
    isChildrenOrderDirty_ = YES;
}

- (void)visit {
    
    if (!self.visible) {
        return;
    }
    
    if (children_) {
        [self reorderByZIndex];
        NSInteger i = 0;
        
        for (i = 0; i < children_.count; i++) {
            GRNode *node = [children_ objectAtIndex:i];
            if (node.zIndex < 0) {
                [node visit];
            }
            else {
                break;
            }
        }
        //[self update:0];
        [self render];
        
        for (i = 0; i < children_.count; i++) {
            GRNode *node = [children_ objectAtIndex:i];
            [node visit];
        }
    }
    else {
        //[self update:0];
        [self render];
    }
}

- (void)update:(float)dt {
    if (children_) {
        NSInteger i = 0;
        
        for (i = 0; i < children_.count; i++) {
            GRNode *node = [children_ objectAtIndex:i];
            [node update:dt];
        }
    }
}
- (void)render { }

@end
