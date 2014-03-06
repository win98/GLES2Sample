/*
 
 File: GLTexture.h
 Abstract: Creates OpenGL 2D textures from images or text.
 
 Version: 1.7
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple Inc.
 ("Apple") in consideration of your agreement to the following terms, and your
 use, installation, modification or redistribution of this Apple software
 constitutes acceptance of these terms.  If you do not agree with these terms,
 please do not use, install, modify or redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and subject
 to these terms, Apple grants you a personal, non-exclusive license, under
 Apple's copyrights in this original Apple software (the "Apple Software"), to
 use, reproduce, modify and redistribute the Apple Software, with or without
 modifications, in source and/or binary forms; provided that if you redistribute
 the Apple Software in its entirety and without modifications, you must retain
 this notice and the following text and disclaimers in all such redistributions
 of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may be used
 to endorse or promote products derived from the Apple Software without specific
 prior written permission from Apple.  Except as expressly stated in this notice,
 no other rights or licenses, express or implied, are granted by Apple herein,
 including but not limited to any patent rights that may be infringed by your
 derivative works or by other works in which the Apple Software may be
 incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE MAKES NO
 WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION THE IMPLIED
 WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND OPERATION ALONE OR IN
 COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL OR
 CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
 GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, MODIFICATION AND/OR
 DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED AND WHETHER UNDER THEORY OF
 CONTRACT, TORT (INCLUDING NEGLIGENCE), STRICT LIABILITY OR OTHERWISE, EVEN IF
 APPLE HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2008 Apple Inc. All Rights Reserved.
 
 */

#import <UIKit/UIKit.h>
#import <OpenGLES/ES1/gl.h>

//CONSTANTS:

typedef enum {
	kGLTexturePixelFormat_Automatic = 0,
	kGLTexturePixelFormat_RGBA8888,
	kGLTexturePixelFormat_RGB565,
	kGLTexturePixelFormat_A8,
} GLTexturePixelFormat;

//CLASS INTERFACES:

/*
 This class allows to easily create OpenGL 2D textures from images, text or raw data.
 The created GLTexture object will always have power-of-two dimensions.
 Depending on how you create the GLTexture object, the actual image area of the texture might be smaller than the texture dimensions i.e. "contentSize" != (pixelsWide, pixelsHigh) and (maxS, maxT) != (1.0, 1.0).
 Be aware that the content of the generated textures will be upside-down!
 */
@interface SGEGLTexture : NSObject
{
@private
	GLuint						_name;
	CGSize						_size;
	NSUInteger					_width,
	_height;
	GLTexturePixelFormat		_format;
	GLfloat						_maxS,
	_maxT;
}
- (id) initWithData:(const void*)data pixelFormat:(GLTexturePixelFormat)pixelFormat pixelsWide:(NSUInteger)width pixelsHigh:(NSUInteger)height contentSize:(CGSize)size;

@property(readonly) GLTexturePixelFormat pixelFormat;
@property(readonly) NSUInteger pixelsWide;
@property(readonly) NSUInteger pixelsHigh;

@property(readonly) GLuint name;

@property(readonly, nonatomic) CGSize contentSize;
@property(readonly) GLfloat maxS;
@property(readonly) GLfloat maxT;

@property(readonly) float width;
@property(readonly) float height;
@property BOOL highDefinition;

@end

/*
 Drawing extensions to make it easy to draw basic quads using a GLTexture object.
 These functions require GL_TEXTURE_2D and both GL_VERTEX_ARRAY and GL_TEXTURE_COORD_ARRAY client states to be enabled.
 */
@interface SGEGLTexture (Drawing)
- (void) drawAtPoint:(CGPoint)point;
- (void) drawAtPoint:(CGPoint)point withRotation:(CGFloat)rotation withScale:(CGFloat)scale;
- (void) drawInRect:(CGRect)dest withClip:(CGRect)src withRotation:(CGFloat)rotation;
- (void) drawInRect:(CGRect)rect;
- (void) drawInVertices:(GLfloat*) vertices;

- (void) drawFrame:(CGRect)imageFrame withAnchorPoint:(CGPoint)anchorPoint atPoint:(CGPoint)destPoint
	  withRotation:(float)rotAngle withScaleX:(float)scaleX withScaleY:(float)scaleY;
- (void) drawFrame:(CGRect)imageFrame withAnchorPoint:(CGPoint)anchorPoint;
@end

/*
 Extensions to make it easy to create a GLTexture object from an image file.
 Note that RGBA type textures will have their alpha premultiplied - use the blending mode (GL_ONE, GL_ONE_MINUS_SRC_ALPHA).
 */
@interface SGEGLTexture (Image)
- (id) initWithImage:(UIImage *)uiImage;
@end

