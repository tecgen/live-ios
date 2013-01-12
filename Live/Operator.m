//
//  Operator.m
//  Live
//
//  Created by Marco Pehla on 12.01.13.
//  Copyright (c) 2013 tecgen.de. All rights reserved.
//

#import "Operator.h"
#import "Knob.h"

@implementation Operator

Knob *knobCoarseD;
Knob *knobFineD;
Knob *knobLevelD;
BOOL switchFixedD;


- (id) init
{
    if (self = [super init]) {
        //engine = [Engine new];
        //tires[0] = [Tire new];
        
    }
    return (self);
}



-(void) drawIn:(CGRect) rectangle
     inContext:(CGContextRef)context
{
    UIGraphicsPushContext(context);
    
    //call its super method to draw the generic stuff
    // like title and on/off knob
    [super drawIn:rectangle inContext:context];
    
    // draw the specific stuff here
    
    // override concrete instrument name
    self.name = @"Operator";
    [self drawTitleIn:rectangle withMinimizeKnobVisible:YES inContext:context];
    
    int paddingHeight = 8;
    CGRect displayRect;
    displayRect.origin.x = rectangle.origin.x + (rectangle.size.width / 3);
    displayRect.origin.y = rectangle.origin.y + (2*paddingHeight);
    displayRect.size.height = rectangle.size.height -(4*paddingHeight);
    displayRect.size.width = rectangle.size.width / 3;
    [self drawRectangeInSize:displayRect withRoundedEdges:10.0 withFillColor:[UIColor blackColor] inContext:context];
    
    
    int instrumentBarHeight = 35;
    
    // osc D
    CGRect oscDRect;
    oscDRect.origin.x = rectangle.origin.x + 4;
    oscDRect.origin.y = rectangle.origin.y + instrumentBarHeight;
    oscDRect.size.height = (rectangle.size.height - instrumentBarHeight) / 4;
    oscDRect.size.width = (rectangle.size.width / 3) - 15;
    UIColor* rowUnselectedColor = [[UIColor alloc] initWithRed:197.0 / 255 green:201.0 / 255 blue:213.0 / 255 alpha:1.0];
    
    [self drawRectangeInSize:oscDRect withRoundedEdges:10.0 withFillColor:rowUnselectedColor inContext:context];
    
    /*
    // left knobs, row D
    CGPoint knob1Position;
    knob1Position.x = bgRect.origin.x + 35;
    knob1Position.y = bgRect.origin.y + instrumentBarHeight + 45;
    [self drawKnobAtPoint:knob1Position withLabel:@"Coarse" andValueLabel:@"1" inContext:context];
    
    CGPoint knob2Position;
    knob2Position.x = knob1Position.x + 100;
    knob2Position.y = knob1Position.y;
    [self drawKnobAtPoint:knob2Position withLabel:@"Fine" andValueLabel:@"0" inContext:context];
    
    CGPoint knob3Position;
    knob3Position.x = knob2Position.x + 140;
    knob3Position.y = knob2Position.y;
    [self drawKnobAtPoint:knob3Position withLabel:@"Level" andValueLabel:@"-inf dB" inContext:context];
    
    */
    
    
    knobCoarseD = [Knob new];
    
    int distanceX = 15;
    int distanceY = 60;
    [knobCoarseD drawAt:CGPointMake(rectangle.origin.x + distanceX, rectangle.origin.y + distanceY) withLabel:@"Coarse" andValueLabel:@"1" inContext:context];
    
    
    UIGraphicsPopContext();
}


-(void) setFilter: (int) frequency
{
    // set knob xyz value
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
