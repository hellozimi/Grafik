//
//  GRProgram.h
//  Engine
//
//  Created by Simon Andersson on 6/21/12.
//  Copyright (c) 2012 Hiddencode.me. All rights reserved.
//

#import <Foundation/Foundation.h>

#define STRINGIZE(x) #x
#define STRINGIZE2(x) STRINGIZE(x)
#define SHADER_STRING(text) @ STRINGIZE2(text)

@interface GRProgram : NSObject {
    NSMutableArray *attributes_;
    NSMutableArray *uniforms_;
    
    GLuint program_;
    GLuint vertexShader_;
    GLuint fragmentShader_;
}

- (id)initWithVertexShaderString:(NSString *)vertexShaderString fragmentShaderString:(NSString *)fragmentShaderString;

- (void)addAttribute:(NSString *)attribName;
- (GLuint)attributeIndex:(NSString *)attribName;
- (GLuint)uniformIndex:(NSString *)uniformName;
- (BOOL)link;
- (void)use;
- (void)validate;

@end
