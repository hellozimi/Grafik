//
//  GRSprite.m
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

#import "GRSprite.h"

@interface GRSprite ()
/*@property (strong) GLKBaseEffect *effect;
@property (assign) TexturedQuad quad;
@property (strong) GLKTextureInfo *textureInfo;*/
@end

@implementation GRSprite
@synthesize textureInfo = textureInfo_;

- (id)initWithFile:(NSString *)filename baseEffect:(GLKBaseEffect *)baseEffect {
    self = [super init];
    if (self) {
        effect_ = baseEffect;
        
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], GLKTextureLoaderOriginBottomLeft, nil];
        NSError *error = nil;
        
        NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:nil];
        textureInfo_ = [GLKTextureLoader textureWithContentsOfFile:path options:options error:&error];
        
        if (self.textureInfo == nil) {
            NSLog(@"Error: %@", [error localizedDescription]);
            return nil;
        }
        
        self.contentSize = CGSizeMake(self.textureInfo.width, self.textureInfo.height);
        
        grTexQuad quad;
        quad.bl.geoVertex = CGPointMake(0, 0);
        quad.br.geoVertex = CGPointMake(self.textureInfo.width, 0);
        quad.tl.geoVertex = CGPointMake(0, self.textureInfo.height);
        quad.tr.geoVertex = CGPointMake(self.textureInfo.width, self.textureInfo.height);
        
        quad.bl.texVertex = CGPointMake(0, 0);
        quad.br.texVertex = CGPointMake(1, 0);
        quad.tl.texVertex = CGPointMake(0, 1);
        quad.tr.texVertex = CGPointMake(1, 1);
        
        quad_ = quad;
        
    }
    return self;
}

- (void)render {
    
    if (!visible_) {
        return;
    }
    
    effect_.texture2d0.name = self.textureInfo.name;
    effect_.texture2d0.enabled = YES;
    
    effect_.transform.modelviewMatrix = [self modelMatrix];
    
    [effect_ prepareToDraw];
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    
    long offset = (long)&quad_;
    glVertexAttribPointer(GLKVertexAttribPosition, 2, GL_FLOAT, GL_FALSE, sizeof(grTexVertex), (void *)(offset + offsetof(grTexVertex, geoVertex)));
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(grTexVertex), (void *) (offset + offsetof(grTexVertex, texVertex)));
    
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
}

/*@synthesize effect = effect_;
@synthesize quad = quad_;
@synthesize textureInfo = textureInfo_;
@synthesize position = position_;
@synthesize contentSize = contentSize_;

- (id)initWithFile:(NSString *)filename baseEffect:(GLKBaseEffect *)baseEffect {
    self = [super init];
    
    if (self) {
        self.effect = baseEffect;
        
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], GLKTextureLoaderOriginBottomLeft, nil];
        NSError *error = nil;
        
        NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:nil];
        self.textureInfo = [GLKTextureLoader textureWithContentsOfFile:path options:options error:&error];
        
        if (self.textureInfo == nil) {
            NSLog(@"Error: %@", [error localizedDescription]);
            return nil;
        }
        
        self.contentSize = CGSizeMake(self.textureInfo.width, self.textureInfo.height);
        
        TexturedQuad newQuad;
        newQuad.bl.geometryVertex = CGPointMake(0, 0);
        newQuad.br.geometryVertex = CGPointMake(self.textureInfo.width, 0);
        newQuad.tl.geometryVertex = CGPointMake(0, self.textureInfo.height);
        newQuad.tr.geometryVertex = CGPointMake(self.textureInfo.width, self.textureInfo.height);
        
        newQuad.bl.textureVertex = CGPointMake(0, 0);
        newQuad.br.textureVertex = CGPointMake(1, 0);
        newQuad.tl.textureVertex = CGPointMake(0, 1);
        newQuad.tr.textureVertex = CGPointMake(1, 1);
        
        self.quad = newQuad;
    }
    
    return self;
}

- (GLKMatrix4)modelMatrix {
    GLKMatrix4 modelMatrix = GLKMatrix4Identity;
    modelMatrix = GLKMatrix4Translate(modelMatrix, self.position.x, self.position.y, 0);
    return modelMatrix;

}

- (void)render {
    
    self.effect.texture2d0.name = self.textureInfo.name;
    self.effect.texture2d0.enabled = YES;
    self.effect.transform.modelviewMatrix = [self modelMatrix];
    
    [self.effect prepareToDraw];
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    
    long offset = (long)&quad_;
    glVertexAttribPointer(GLKVertexAttribPosition, 2, GL_FLOAT, GL_FALSE, sizeof(TexturedVertex), (void *)(offset + offsetof(TexturedVertex, geometryVertex)));
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(TexturedVertex), (void *) (offset + offsetof(TexturedVertex, textureVertex)));
    
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
}*/

@end
