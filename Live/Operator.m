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

NSString *const instrumentName = @"Operator";

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
    self.name = instrumentName;
    [self drawTitleIn:rectangle withMinimizeKnobVisible:YES inContext:context];
    
    int paddingHeight = rectangle.size.height * 0.01;
    CGRect displayRect;
    displayRect.origin.x = rectangle.origin.x + (rectangle.size.width / 3);
    displayRect.origin.y = rectangle.origin.y + (2*paddingHeight);
    displayRect.size.height = rectangle.size.height - (4*paddingHeight);
    displayRect.size.width = rectangle.size.width / 3;
    [self drawRectangeInSize:displayRect withRoundedEdges:10.0 withFillColor:[UIColor blackColor] inContext:context];
    
    //TODO move to super class
    int instrumentBarHeight = 35;
    
    
    CGRect oscRect;
    oscRect.origin.x = rectangle.origin.x + 4;
    oscRect.origin.y = rectangle.origin.y + instrumentBarHeight;
    oscRect.size.height = (rectangle.size.height - 2*instrumentBarHeight) / 4 ;
    oscRect.size.width = (rectangle.size.width / 3) * 0.97;
    
    [self drawOscInSize:oscRect withName:@"D" inContext:context];

    oscRect.origin.y = oscRect.origin.y + oscRect.size.height + (oscRect.size.height/8) ;
    [self drawOscInSize:oscRect withName:@"C" inContext:context];
    
    oscRect.origin.y = oscRect.origin.y + oscRect.size.height + (oscRect.size.height/8) ;
    [self drawOscInSize:oscRect withName:@"B" inContext:context];
    
    oscRect.origin.y = oscRect.origin.y + oscRect.size.height + (oscRect.size.height/8) ;
    [self drawOscInSize:oscRect withName:@"A" inContext:context];
    
    
    UIGraphicsPopContext();
}

-(void) drawOscInSize:(CGRect)rectangle
             withName:(NSString*)oscName
            inContext:(CGContextRef)context
{
    UIColor* rowUnselectedColor = [[UIColor alloc] initWithRed:197.0 / 255 green:201.0 / 255 blue:213.0 / 255 alpha:1.0];
    
    // background
    [self drawRectangeInSize:rectangle withRoundedEdges:10.0 withFillColor:rowUnselectedColor inContext:context];
    
    // first knob "Coarse"
    int knobSize = rectangle.size.height * 0.95;
    knobCoarseD = [Knob new];
    
    int distanceX = 15;
    [knobCoarseD drawAt:CGRectMake(rectangle.origin.x + distanceX,
                                   rectangle.origin.y, knobSize,knobSize)
              withLabel:@"Coarse" andValueLabel:@"1" inContext:context];
    
    knobFineD = [Knob new];
    distanceX += knobSize + 25;
    [knobFineD drawAt:CGRectMake(rectangle.origin.x + distanceX,
                                   rectangle.origin.y, knobSize,knobSize)
              withLabel:@"Fine" andValueLabel:@"0" inContext:context];
    
    knobLevelD = [Knob new];
    distanceX += knobSize + 60;
    [knobLevelD drawAt:CGRectMake(rectangle.origin.x + distanceX,
                                 rectangle.origin.y, knobSize,knobSize)
            withLabel:@"Level" andValueLabel:@"-inf dB" inContext:context];
    
    // rectangle switch "Fixed"
    [[UIColor darkGrayColor] setStroke];
    [[UIColor lightGrayColor] setFill];
    CGContextSetLineWidth(context, 2.0);
    CGRect switchFixed = CGRectMake(rectangle.size.width/2 + 10, rectangle.origin.y + (rectangle.size.height/2), 18, 18);
    CGContextFillRect(context, switchFixed);
    CGContextStrokeRect(context, switchFixed);
    
    // the string "Fixed"
    [[UIColor blackColor] setFill];
    NSString *switchFixedDescription = @"Fixed";
    CGPoint switchTextPosition = CGPointMake(rectangle.size.width/2, rectangle.origin.y);
    UIFont *switchTextFont = [UIFont systemFontOfSize:18];
    
    CGSize switchRectStringSize = [switchFixedDescription sizeWithFont:switchTextFont];
    CGRect switchRectString = CGRectMake(switchTextPosition.x, switchTextPosition.y,
                                         switchRectStringSize.width, switchRectStringSize.height);
    [switchFixedDescription drawInRect:switchRectString withFont:switchTextFont];
    
    // rectangle switch on/off 
    [[UIColor darkGrayColor] setStroke];
    [[UIColor orangeColor] setFill];
    CGContextSetLineWidth(context, 2.0);
    CGRect switchOnOff = CGRectMake(distanceX + (2*knobSize), rectangle.origin.y + (rectangle.size.height/3), 25, 25);
    CGContextFillRect(context, switchOnOff);
    CGContextStrokeRect(context, switchOnOff);

    
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
