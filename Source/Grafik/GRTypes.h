//
//  GRTypes.h
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
