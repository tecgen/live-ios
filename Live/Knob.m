//
//  Knob.m
//  Live
//
//  Created by Marco Pehla on 12.01.13.
//  Copyright (c) 2013 tecgen.de. All rights reserved.
//

#import "Knob.h"

@implementation Knob


-(void) drawAt:(CGRect)rectangle
     withLabel:(NSString*)description
 andValueLabel:(NSString*)valueLabel
     inContext:(CGContextRef)context
{
    UIGraphicsPushContext(context);
    
    //debug knob rectangle size
    //CGContextAddRect(context, rectangle);
    
    // 3/4 of a circle as background circle, always visible
    int radius = (rectangle.size.width / 4);
    CGPoint centerOfKnob;
    centerOfKnob.x = rectangle.origin.x + radius;
    centerOfKnob.y = rectangle.origin.y + (rectangle.size.height/1.5);
    
    UIBezierPath* knobBG = [UIBezierPath bezierPathWithArcCenter:centerOfKnob radius:radius startAngle:M_PI_2 endAngle:0 clockwise:YES];
    
    [knobBG setLineWidth:4.0];
    [[UIColor blackColor] setStroke];
    [knobBG stroke];
    
    // circle to reflect the current value, always orange (or custom coloured)
    // TODO value dependend drawing
    /*
     UIBezierPath* knobFG = [UIBezierPath bezierPathWithArcCenter:centerOfKnob radius:radius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
     [knobFG setLineWidth:4.0];
     [[UIColor orangeColor] setStroke];
     [knobFG stroke];
    */
    
    // line, always black
    [[UIColor blackColor] setStroke];
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, centerOfKnob.x,centerOfKnob.y);
    CGContextAddLineToPoint(context, centerOfKnob.x-1, centerOfKnob.y+17);
    CGContextStrokePath(context);
    
    // value
    [[UIColor blackColor] set];
    CGPoint valuePosition = CGPointMake(centerOfKnob.x + 10, centerOfKnob.y + 4);
    UIFont *valueFont = [UIFont systemFontOfSize:18];
    
    CGSize valueRectStringSize = [valueLabel sizeWithFont:valueFont];
    CGRect valueRectString = CGRectMake(valuePosition.x, valuePosition.y, valueRectStringSize.width, valueRectStringSize.height);
    // fill text bg
    /*
     [[UIColor whiteColor] set];
     CGContextFillRect(context, valueRectString);
     [[UIColor blackColor] set];
     */
    [valueLabel drawInRect:valueRectString withFont:valueFont];
    
    // description
    CGPoint knobTextPosition = CGPointMake(rectangle.origin.x, rectangle.origin.y);
    UIFont *knobTextFont = [UIFont systemFontOfSize:18];
    
    CGSize knobRectStringSize = [description sizeWithFont:valueFont];
    CGRect knobRectString = CGRectMake(knobTextPosition.x, knobTextPosition.y, knobRectStringSize.width, knobRectStringSize.height);
    // fill text bg
    /*
     [[UIColor greenColor] set];
     CGContextFillRect(context, knobRectString);
     [[UIColor blackColor] set];
     */
    [description drawInRect:knobRectString withFont:knobTextFont];
    
    
    UIGraphicsPopContext();
}


@end
