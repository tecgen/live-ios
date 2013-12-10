//
//  Instrument.h
//  Live
//
//  Created by Marco Pehla on 12.01.13.
//  Copyright (c) 2013 tecgen.de. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Instrument : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *patch;
@property (nonatomic) CGRect *size;

-(void) drawIn:(CGRect) rectangle
     inContext:(CGContextRef)context;

-(void) drawTitleIn:(CGRect) rectangle
withMinimizeKnobVisible:(BOOL) minimizeKnobVisible
          inContext:(CGContextRef)context;

-(void) drawRectangeInSize:(CGRect)rectangle
          withRoundedEdges:(float)cornerRadius
             withFillColor:(UIColor*)fillColor
                 inContext:(CGContextRef)context;

-(NSInteger) instrumentBarHeight;

@end
