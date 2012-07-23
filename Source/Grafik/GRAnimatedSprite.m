//
//  GRAnimatedSprite.m
//  Engine
//
//  Created by Simon Andersson on 7/19/12.
//  Copyright (c) 2012 Hiddencode.me. All rights reserved.
//

#import "GRAnimatedSprite.h"
#import "GRSpriteAction.h"

@implementation GRAnimatedSprite
@synthesize textureInfo = textureInfo_;

- (id)initWithFile:(NSString *)filename baseEffect:(GLKBaseEffect *)baseEffect size:(CGSize)size {
    self = [super init];
    if (self) {
        effect_ = baseEffect;
        
        actions_ = [[NSMutableDictionary alloc] init];
        
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], GLKTextureLoaderOriginBottomLeft, nil];
        NSError *error = nil;
        
        NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:nil];
        textureInfo_ = [GLKTextureLoader textureWithContentsOfFile:path options:options error:&error];
        
        if (self.textureInfo == nil) {
            NSLog(@"Error: %@", [error localizedDescription]);
            return nil;
        }
        
        self.contentSize = size;
        
        grTexQuad quad;
        quad.bl.geoVertex = CGPointMake(0, 0);
        quad.br.geoVertex = CGPointMake(self.contentSize.width, 0);
        quad.tl.geoVertex = CGPointMake(0, self.contentSize.height);
        quad.tr.geoVertex = CGPointMake(self.contentSize.width, self.contentSize.height);
        
        quad.bl.texVertex = CGPointMake(0, 0);
        quad.br.texVertex = CGPointMake(1, 0);
        quad.tl.texVertex = CGPointMake(0, 1);
        quad.tr.texVertex = CGPointMake(1, 1);
        
        quad_ = quad;
        
    }
    return self;
}

- (void)addAction:(GRSpriteAction *)action forKey:(NSString *)key {
    [actions_ setObject:action forKey:key];
}

- (void)runAction:(NSString *)name {
    [self runAction:name repeat:YES];
}

- (void)runAction:(NSString *)name repeat:(BOOL)yesOrNo {
    currentAction_ = [actions_ objectForKey:name];
    
    timeElapsed_ = 0;
    currentFrame_ = 0;
    
    [self updateSheet];
}

- (void)update:(float)dt {
    
    if (!currentAction_) {
        return;
    }
    
    timeElapsed_ += dt;
    
    if (timeElapsed_ >= currentAction_.animationInterval) {
        timeElapsed_ = 0;
        currentFrame_++;
        
        [self updateSheet];
    }
}

- (void)updateSheet {
    
    if ([self numFrames] == 0) {
        return;
    }
    
    int timedFrame = currentFrame_ % [self numFrames];
    GRSpriteFrame *frame = [currentAction_.frames objectAtIndex:timedFrame];
    
    float width = self.textureInfo.width;
    //float height = self.textureInfo.height;
    
    float offsetX = frame.offset.x;
    //float offsetY = frame.offset.y;
    
    float tw = frame.size.width / width;
    //float th = frame.size.height / height;
    float tx = (offsetX / width) + tw;
    //float ty = (offsetY / height) + th;
    
    quad_.bl.texVertex = CGPointMake(tx - tw, 0);
    quad_.br.texVertex = CGPointMake(tx, 0);
    quad_.tl.texVertex = CGPointMake(tx - tw, 1);
    quad_.tr.texVertex = CGPointMake(tx, 1);
}

- (int)numFrames {

    return currentAction_.frames.count;
}

- (void)render {
    
    if (!currentAction_) {
        return;
    }
    
    effect_.texture2d0.name = self.textureInfo.name;
    effect_.texture2d0.enabled = YES;
    
    //glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    //glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    
    effect_.transform.modelviewMatrix = [self modelMatrix];
    
    [effect_ prepareToDraw];
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    
    long offset = (long)&quad_;
    glVertexAttribPointer(GLKVertexAttribPosition, 2, GL_FLOAT, GL_FALSE, sizeof(grTexVertex), (void *)(offset + offsetof(grTexVertex, geoVertex)));
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(grTexVertex), (void *) (offset + offsetof(grTexVertex, texVertex)));
    
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
}



@end
