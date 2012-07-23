//
//  GRNode.h
//  Engine
//
//  Created by Simon Andersson on 7/18/12.
//  Copyright (c) 2012 Hiddencode.me. All rights reserved.
//

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
