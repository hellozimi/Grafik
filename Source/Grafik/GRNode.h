//
//  GRNode.h
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

#import <Foundation/Foundation.h>
#import "GRTypes.h"

@class GRProgram;

@interface GRNode : NSObject {
    CGPoint anchorPoint_, anchorPointInPoints_;
    GLKVector2 position_;
    float rotation_;
    float scaleX_;
    float scaleY_;
    
    CGSize contentSize_;
    
    NSInteger zIndex_;
    
    BOOL visible_;
    
    NSMutableArray *children_;
    
    GRNode *parent_;
    
    BOOL isChildrenOrderDirty_;
}

@property (nonatomic, readwrite, assign) float rotation;
@property (nonatomic, readwrite, assign) float scaleX;
@property (nonatomic, readwrite, assign) float scaleY;
@property (nonatomic, readwrite, assign) CGSize contentSize;
@property (assign) BOOL visible;
@property (readonly) CGPoint anchorPointInPoints;
@property (nonatomic, readwrite) CGPoint anchorPoint;
@property (nonatomic, readwrite) GLKVector2 position;
@property (nonatomic) float scale;
@property (nonatomic, strong) NSMutableArray *children;
@property (nonatomic, assign) NSInteger zIndex;
@property (nonatomic, strong) GRNode *parent;

+ (GRNode *)node;
- (id)init;

- (GLKMatrix4)modelMatrix;
- (void)update:(float)dt;
- (void)render;

- (void)addChild:(GRNode *)node;
- (void)removeChild:(GRNode *)node;

- (void)visit;

@end
