//
//  GRContext.h
//  Engine
//
//  Created by Simon Andersson on 6/21/12.
//  Copyright (c) 2012 Hiddencode.me. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRContext : NSObject {
    
    EAGLContext *context_;
    
}

@property (nonatomic, retain) EAGLContext *context;

+ (GRContext *)sharedContext;
+ (void)useContext;
- (void)presentBufferForDisplay;

@end
