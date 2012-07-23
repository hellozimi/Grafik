//
//  GRSprite.h
//  Engine
//
//  Created by Simon Andersson on 7/18/12.
//  Copyright (c) 2012 Hiddencode.me. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GRNode.h"

@interface GRSprite : GRNode {
    GLKTextureInfo *textureInfo_;
    GLKBaseEffect *effect_;
    grTexQuad quad_;
}

@property (strong, nonatomic) GLKTextureInfo *textureInfo;

- (id)initWithFile:(NSString *)filename baseEffect:(GLKBaseEffect *)baseEffect;

@end
