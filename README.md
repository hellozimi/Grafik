Grafik
======

Grafik is a try to make a simple 2D render engine. It's a ARC and GLKit (iOS 5) project. The project is inspired by Cocos2d.

This is still under heavy development and I'm not even sure it will ever be ready for production.

*At the moment this project doesn't support custom sharders yet, though there is a class for it (GRProgram.h). This will be implemented soon.*

Example
=======

First you need to like the following frameworks in build phases.
    
    QuartzCore.framework
    GLKit.framework
    OpenGLES.framework
    

Next you need import the following headers to your `*-Prefix.pch` file.
    
    #ifdef __OBJC__
        #import <UIKit/UIKit.h>
        #import <Foundation/Foundation.h>
        #import <GLKit/GLKit.h>
        #import <QuartzCore/QuartzCore.h>
    #endif
    

And now you're ready to go, all you need is included in [/GrafikExample](https://github.com/hellozimi/Grafik/tree/master/GrafikExample).
	
	