//
//  Instrument.m
//  Live
//
//  Created by Marco Pehla on 12.01.13.
//  Copyright (c) 2013 tecgen.de. All rights reserved.
//

#import "Instrument.h"

@implementation Instrument

@synthesize name = _name;
@synthesize patch = _patch;

-(void) drawIn:(CGRect) rectangle
     inContext:(CGContextRef)context
{
    
    UIGraphicsPushContext(context);
    
    self.name = @"Generic Instrument";
    self.patch = @"Default Patch";
    
    //draw all the generic instrument stuff here
    
    // default instrument background
    UIColor* bgColor = [[UIColor alloc] initWithRed:119.0 / 255 green:143.0 / 255 blue:186.0 / 255 alpha:1.0];
    
    // 197 201 213 grau
    // 255 255 255 weiss
    
    [self drawRectangeInSize:rectangle withRoundedEdges:10.0 withFillColor:bgColor inContext:context];
    
    UIGraphicsPopContext();
}

-(void) drawTitleIn:(CGRect) rectangle
withMinimizeKnobVisible:(BOOL) minimizeKnobVisible
          inContext:(CGContextRef)context;
{
    // instument on/off knob
    int smallKnobRadius = 10;
    
    CGPoint onKnobCenter;
    onKnobCenter.x = rectangle.origin.x + 18;
    onKnobCenter.y = rectangle.origin.y + 15;
    
    UIBezierPath* onKnob = [UIBezierPath bezierPathWithArcCenter:onKnobCenter radius:smallKnobRadius startAngle:M_PI*2 endAngle:0 clockwise:YES];
    
    [onKnob setLineWidth:2.0];
    [[UIColor blackColor] setStroke];
    [onKnob stroke];
    
    if(minimizeKnobVisible == YES) {
        // minimize knob
        CGPoint minimizeKnobCenter = CGPointMake(onKnobCenter.x + 25, onKnobCenter.y);
        UIBezierPath* minimizeKnob = [UIBezierPath bezierPathWithArcCenter:minimizeKnobCenter radius:smallKnobRadius startAngle:M_PI*2 endAngle:0 clockwise:YES];
    
        [minimizeKnob setLineWidth:2.0];
        [[UIColor blackColor] setStroke];
        [minimizeKnob stroke];
    }
    
    // instrument name label
    NSString* instrumentName = self.name;
    CGPoint instNameLabelPosition = CGPointMake(rectangle.origin.x + (5*smallKnobRadius) + 10, rectangle.origin.y + 4);
    
    UIFont *instNameLabelFont = [UIFont boldSystemFontOfSize:19];
    CGSize valueRectStringSize = [instrumentName sizeWithFont:instNameLabelFont];
    CGRect valueRectString = CGRectMake(instNameLabelPosition.x, instNameLabelPosition.y, valueRectStringSize.width, valueRectStringSize.height);
    [[UIColor blackColor] setFill];
    [instrumentName drawInRect:valueRectString withFont:instNameLabelFont];
    
    
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
