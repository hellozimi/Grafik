//
//  GRProgram.m
//  Grafik
//
//  Created by Simon Andersson on 6/21/12.
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

#import "GRProgram.h"

@interface GRProgram ()
- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type string:(NSString *)shaderString;
@end

@implementation GRProgram


- (id)initWithVertexShaderString:(NSString *)vertexShaderString fragmentShaderString:(NSString *)fragmentShaderString {
    self = [super init];
    
    if (self) {
        attributes_ = [[NSMutableArray alloc] init];
        uniforms_ = [[NSMutableArray alloc] init];
        program_ = glCreateProgram();
        
        if (![self compileShader:&vertexShader_ type:GL_VERTEX_SHADER string:vertexShaderString]) {
            NSLog(@"Failed to compile vertex shader");
        }
        
        if (![self compileShader:&fragmentShader_ type:GL_FRAGMENT_SHADER string:fragmentShaderString]) {
            NSLog(@"Failed to compile fragment shader");
        }
        
        glAttachShader(program_, vertexShader_);
        glAttachShader(program_, fragmentShader_);
    }
    
    return self;
}

- (void)dealloc {
    
    if (vertexShader_) {
        glDeleteShader(vertexShader_);
    }
    
    if (fragmentShader_) {
        glDeleteShader(fragmentShader_);
    }
    
    if (program_) {
        glDeleteProgram(program_);
    }
}

- (void)addAttribute:(NSString *)attribName {
    if (![attributes_ containsObject:attribName]) {
        [attributes_ addObject:attribName];
        glBindAttribLocation(program_, [attributes_ indexOfObject:attribName], [attribName UTF8String]);
    }
}

- (GLuint)attributeIndex:(NSString *)attribName {
    return [attributes_ indexOfObject:attribName];
}

- (GLuint)uniformIndex:(NSString *)uniformName {
    return glGetUniformLocation(program_, [uniformName UTF8String]);
}

- (BOOL)link {
    
    GLint status;
    
    glLinkProgram(program_);
    
    glGetProgramiv(program_, GL_LINK_STATUS, &status);
    if (status != GL_TRUE) {
        return NO;
    }
    
    if (vertexShader_) {
        glDeleteShader(vertexShader_);
        vertexShader_ = 0;
    }
    
    if (fragmentShader_) {
        glDeleteShader(fragmentShader_);
        fragmentShader_ = 0;
    }
    
    return YES;
}

- (void)use {
    glUseProgram(program_);
}

- (void)validate {
    GLint logLength;
    
    glValidateProgram(program_);
    glGetProgramiv(program_, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLint logLength;
        glGetProgramiv(program_, GL_INFO_LOG_LENGTH, &logLength);
        if (logLength > 0) {
            GLchar *log = (GLchar *)malloc(logLength);
            
            glGetProgramInfoLog(program_, logLength, &logLength, log);
            NSLog(@"Program validate log: %s", log);
            
            free(log);
        }
    }
}

- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type string:(NSString *)shaderString {
    
    GLint status;
    
    const char *source;
    source = (GLchar *)[shaderString UTF8String];
    
    if (!source) {
        NSLog(@"No valid shader source");
        return NO;
    }
    
    *shader = glCreateShader(type);
    glShaderSource(*shader, 1, &source, NULL);
    glCompileShader(*shader);
    
    glGetShaderiv(*shader, GL_COMPILE_STATUS, &status);
    
    if (status == GL_FALSE) {
        GLint logLength;
        glGetShaderiv(*shader, GL_INFO_LOG_LENGTH, &logLength);
        if (logLength > 0) {
            GLchar *log = (GLchar *)malloc(logLength);
            
            glGetShaderInfoLog(*shader, logLength, &logLength, log);
            NSLog(@"Shader compile log: %s", log);
            
            free(log);
        }
    }
    return status == GL_TRUE;
}

@end







