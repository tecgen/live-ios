//
//  IntrumentPane.m
//  Live
//
//  Created by Marco Pehla on 12.01.13.
//  Copyright (c) 2013 tecgen.de. All rights reserved.
//

#import "InstrumentPane.h"
#import "Instrument.h"
#import "Operator.h"

#define MAX_NUMBER_OF_MIDI_EFX 3
#define MAX_NUMBER_OF_AUDIO_EFX 4

@implementation InstrumentPane

//MIDIEfx *midiEfx[MAX_NUMBER_OF_MIDI_EFX];
Instrument *instrument;
//AudioEfx *audioEfx[MAX_NUMBER_OF_AUDIO_EFX];


-(void) drawIn:(CGRect) rectangle
     inContext:(CGContextRef)context
{
    UIGraphicsPushContext(context);
    
    // draw the background
    UIColor* backgroundColor = [[UIColor alloc] initWithRed:111.0 / 255 green:124.0 / 255 blue:145.0 / 255 alpha:1.0];
    
    CGRect bgRectangle = CGRectMake(rectangle.origin.x, rectangle.origin.y, rectangle.size.width, rectangle.size.height);
    
    [self drawRectangeInSize:bgRectangle withRoundedEdges:10.0 withFillColor:backgroundColor inContext:context];
    
    CGRect margin;
    margin.size.width = rectangle.size.width / 40;
    margin.size.height = rectangle.size.height / 20;
    
    // arrange the instruments one after the other
    //midiEfx[1] = [[Scale alloc] init];
    instrument = [[Operator alloc] init];
    
    CGRect instrumentRectangle;
    instrumentRectangle.origin.x = rectangle.origin.x + margin.size.width;
    instrumentRectangle.origin.y = rectangle.origin.y + margin.size.height;
    instrumentRectangle.size.width = rectangle.size.width - (2 * margin.size.width);
    instrumentRectangle.size.height = rectangle.size.height - (2 * margin.size.height);
    
    [instrument drawIn:instrumentRectangle inContext:context];
    
    //audioEfx[1] = [[EQ8 alloc] init];
    //audioEfx[2] = [[Compressor alloc] init];
    
    UIGraphicsPopContext();
}

// TODO move to an helper class or generic super class?
-(void) drawRectangeInSize:(CGRect)rectangle
          withRoundedEdges:(float)cornerRadius
             withFillColor:(UIColor*)fillColor
                 inContext:(CGContextRef)context
{
    UIGraphicsPushContext(context);
    
    // rectangle with rounded edges
    CGContextSetLineWidth(context, 5.0);
    [fillColor setFill];
    [fillColor setStroke];
    UIBezierPath* roundedRect = [UIBezierPath bezierPathWithRoundedRect:rectangle cornerRadius:cornerRadius];
    [roundedRect setLineWidth:5.0];
    [roundedRect fill];
    [roundedRect stroke];
    
    UIGraphicsPopContext();
}

@end
