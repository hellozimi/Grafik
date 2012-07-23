//
//  GRTypes.h
//  Engine
//
//  Created by Simon Andersson on 7/18/12.
//  Copyright (c) 2012 Hiddencode.me. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GLKVector2Zero GLKVector2Make(0, 0);

typedef struct {
    GLuint r;
    GLuint g;
    GLuint b;
} grColor3b;

typedef struct {
    GLuint r;
    GLuint g;
    GLuint b;
    GLuint a;
} grColor4b;

typedef CGPoint grVertex2f;

typedef struct {
    GLfloat u;
    GLfloat v;
} grTex2f;

typedef struct {
    grVertex2f tl;
    grVertex2f tr;
    grVertex2f bl;
    grVertex2f br;
} grQuad2;

typedef struct {
    grVertex2f pos;
    grColor4b color;
} grSpritePoint;

typedef struct {
    grVertex2f geoVertex;
    grVertex2f texVertex;
} grTexVertex;

typedef struct {
    grTexVertex tl;
    grTexVertex tr;
    grTexVertex bl;
    grTexVertex br;
} grTexQuad;
