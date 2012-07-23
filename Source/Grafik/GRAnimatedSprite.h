//
//  GRAnimatedSprite.h
//  Engine
//
//  Created by Simon Andersson on 7/19/12.
//  Copyright (c) 2012 Hiddencode.me. All rights reserved.
//

#import "GRNode.h"
@class GRSpriteAction;

@interface GRAnimatedSprite : GRNode {
    GLKTextureInfo *textureInfo_;
    GLKBaseEffect *effect_;
    grTexQuad quad_;
    
    NSMutableDictionary *actions_;
    
    int currentFrame_;
    float timeElapsed_;
    
    GRSpriteAction *currentAction_;
}

@property (strong, nonatomic) GLKTextureInfo *textureInfo;

- (id)initWithFile:(NSString *)filename baseEffect:(GLKBaseEffect *)baseEffect size:(CGSize)size;

- (void)addAction:(GRSpriteAction *)action forKey:(NSString *)key;
- (void)runAction:(NSString *)name;
- (void)runAction:(NSString *)name repeat:(BOOL)yesOrNo;

@end
