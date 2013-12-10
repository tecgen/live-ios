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
@synthesize size = _size;

-(void) drawIn:(CGRect) rectangle
     inContext:(CGContextRef)context
{
    
    UIGraphicsPushContext(context);
    
    self.name = @"Generic Instrument";
    self.patch = @"Default Patch";
    [self setSize:&rectangle];
    
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
    int smallKnobRadius = 12;
    
    // black outline
    CGPoint onKnobCenter;
    onKnobCenter.x = rectangle.origin.x + 18;
    onKnobCenter.y = rectangle.origin.y + 15;
    
    UIBezierPath* onKnobOutline = [UIBezierPath bezierPathWithArcCenter:onKnobCenter
                                                          radius:smallKnobRadius
                                                      startAngle:M_PI * 2
                                                        endAngle:0 clockwise:YES];
    
    [onKnobOutline setLineWidth:1.0];
    [[UIColor blackColor] setStroke];
    [onKnobOutline stroke];
    
    // green inline
    UIBezierPath* onKnob = [UIBezierPath bezierPathWithArcCenter:onKnobCenter
                                                          radius:(smallKnobRadius-3)
                                                      startAngle:M_PI * 2
                                                        endAngle:0 clockwise:YES];
    [onKnob setLineWidth:4.0];
    [[UIColor greenColor] setStroke];
    [[UIColor lightGrayColor] setFill];
    [onKnob stroke];
    [onKnob fill];
    
    // green line in the middle 
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 2.5);
    CGContextMoveToPoint(context, onKnobCenter.x,onKnobCenter.y - (smallKnobRadius / 2));
    CGContextAddLineToPoint(context, onKnobCenter.x, onKnobCenter.y + (smallKnobRadius / 2));
    CGContextStrokePath(context);
    
    
    if(minimizeKnobVisible == YES) {
        // minimize knob
        int smallKnobRadiusMinimize = 10;
        
        CGPoint minimizeKnobCenter = CGPointMake(onKnobCenter.x + 30, onKnobCenter.y);
        UIBezierPath* minimizeKnob = [UIBezierPath bezierPathWithArcCenter:minimizeKnobCenter radius:smallKnobRadiusMinimize startAngle:M_PI*2 endAngle:0 clockwise:YES];
    
        [minimizeKnob setLineWidth:3.0];
        [[UIColor darkGrayColor] setStroke];
        [[UIColor lightGrayColor] setFill];
        
        [minimizeKnob stroke];
        [minimizeKnob fill];
        
    }
    
    // instrument name label
    NSString* instrumentName = self.name;
    CGPoint instNameLabelPosition = CGPointMake(rectangle.origin.x + (5*smallKnobRadius) + 6, rectangle.origin.y + 4);

    //UIFont *instNameLabelFont = [UIFont boldSystemFontOfSize:20];
    UIFont *instNameLabelFont = [UIFont fontWithName:@"Arial-BoldItalicMT" size:20.0];
    CGSize valueRectStringSize = [instrumentName sizeWithFont:instNameLabelFont];
    CGRect valueRectString = CGRectMake(instNameLabelPosition.x, instNameLabelPosition.y, valueRectStringSize.width, valueRectStringSize.height);
    [[UIColor blackColor] setFill];
    [instrumentName drawInRect:valueRectString withFont:instNameLabelFont];
    
    
}

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

-(NSInteger) instrumentBarHeight
{
    
    NSInteger *result = (NSInteger) CGRectGetHeight(*[self size]) / 10;
    
    return result;
}

@end
