//
//  LiveView.m
//  Live
//
//  Created by Marco Pehla on 02.11.12.
//  Copyright (c) 2012 tecgen.de. All rights reserved.
//

#import "LiveView.h"
#import "InstrumentPane.h"

#define DEFAULT_SCALE 0.90

@implementation LiveView

@synthesize scale = _scale;


InstrumentPane *instrumentPane;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
    }
    return self;
}

-(CGFloat)scale
{
    
    if(!_scale) {
        return DEFAULT_SCALE;
    } else {
        return _scale;
    }
}

-(void)setScale:(CGFloat)scale
{
    if(_scale != scale) {
        _scale = scale;
        //NSLog(@"scale: %f", _scale);
        [self setNeedsDisplay];
    }
}


-(void)pinch:(UIPinchGestureRecognizer *)gesture
{
        if(gesture.state == UIGestureRecognizerStateChanged ||
           gesture.state == UIGestureRecognizerStateEnded) {
            
            self.scale *= gesture.scale;
            
            // reset gesture value for next gesture detection
            gesture.scale = 1;
        }
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

-(void) drawKnobAtPoint:(CGPoint)point
              withLabel:(NSString*)description
               andValueLabel:(NSString*)valueLabel
              inContext:(CGContextRef)context
{
    UIGraphicsPushContext(context);
    
    // 3/4 of a circle as background circle, always visible
    CGPoint centerOfKnob;
    centerOfKnob.x = point.x;
    centerOfKnob.y = point.y;
    int radius = 18;
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
    CGPoint knobTextPosition = CGPointMake(centerOfKnob.x+7, centerOfKnob.y-38);
    UIFont *knobTextFont = [UIFont systemFontOfSize:18];
    
    CGSize knobRectStringSize = [description sizeWithFont:valueFont];
    CGRect knobRectString = CGRectMake(knobTextPosition.x - (radius*1.5), knobTextPosition.y - (radius/4), knobRectStringSize.width, knobRectStringSize.height);
    // fill text bg
    /*
    [[UIColor greenColor] set];
    CGContextFillRect(context, knobRectString);
    [[UIColor blackColor] set];
    */
    [description drawInRect:knobRectString withFont:knobTextFont];
    
    
    UIGraphicsPopContext();
}

-(void) drawInstrumentOnKnobAtPoint:(CGPoint)point
                          inContext:(CGContextRef)context
{
    UIGraphicsPushContext(context);

    //TODO copy paste
    
    UIGraphicsPopContext();
}

-(void) drawOperatorOscAtPoint:(CGPoint)point
                     inContext:(CGContextRef)context
{
    UIGraphicsPushContext(context);
    
    
    //TODO copy paste
    
    UIGraphicsPopContext();
}

-(void) drawInstrumentsAtPoint:(CGPoint)point
                    inContext:(CGContextRef)context
{
    UIGraphicsPushContext(context);
    
    // instruments pane background
    UIColor* backgroundColor = [[UIColor alloc] initWithRed:111.0 / 255 green:124.0 / 255 blue:145.0 / 255 alpha:1.0];
    CGRect instrumentPanelBG;
    instrumentPanelBG.origin.x = point.x;
    instrumentPanelBG.origin.y = point.y;
    instrumentPanelBG.size.height = 370;
    instrumentPanelBG.size.width = 1050;
    [self drawRectangeInSize:instrumentPanelBG withRoundedEdges:10.0 withFillColor:backgroundColor inContext:context];
    
    // TODO: MIDI input LEDs
    
    
    // Operator
    CGRect bgRect;
    int paddingHeight = 8;
    bgRect.origin.x = instrumentPanelBG.origin.x + 25;
    bgRect.origin.y = instrumentPanelBG.origin.y + paddingHeight;
    bgRect.size.height = instrumentPanelBG.size.height - (2*paddingHeight);
    bgRect.size.width = 1050;
    UIColor* bgColor = [[UIColor alloc] initWithRed:119.0 / 255 green:143.0 / 255 blue:186.0 / 255 alpha:1.0];
    
    // 197 201 213 grau
    // 255 255 255 weiss
    
    [self drawRectangeInSize:bgRect withRoundedEdges:10.0 withFillColor:bgColor inContext:context];
    
    CGRect displayRect;
    displayRect.origin.x = bgRect.origin.x + 410;
    displayRect.origin.y = bgRect.origin.y + paddingHeight;
    displayRect.size.height = bgRect.size.height -(2*paddingHeight);
    displayRect.size.width = 540;
    [self drawRectangeInSize:displayRect withRoundedEdges:10.0 withFillColor:[UIColor blackColor] inContext:context];
    
    // instument on/off knob
    CGPoint onKnobCenter;
    onKnobCenter.x = bgRect.origin.x + 18;
    onKnobCenter.y = bgRect.origin.y + 15;
    int smallKnobRadius = 10;
    UIBezierPath* onKnob = [UIBezierPath bezierPathWithArcCenter:onKnobCenter radius:smallKnobRadius startAngle:M_PI*2 endAngle:0 clockwise:YES];
    
    [onKnob setLineWidth:1.0];
    [[UIColor blackColor] setStroke];
    [onKnob stroke];
    
    
    // instrument name label
    int instrumentBarHeight = 35;
    NSString* instrumentName = @"Operator";
    CGPoint instNameLabelPosition = CGPointMake(bgRect.origin.x + 60, bgRect.origin.y + 4);
    UIFont *instNameLabelFont = [UIFont boldSystemFontOfSize:19];
    CGSize valueRectStringSize = [instrumentName sizeWithFont:instNameLabelFont];
    CGRect valueRectString = CGRectMake(instNameLabelPosition.x, instNameLabelPosition.y, valueRectStringSize.width, valueRectStringSize.height);
    [instrumentName drawInRect:valueRectString withFont:instNameLabelFont];
    
    
    // osc D
    CGRect oscDRect;
    oscDRect.origin.x = bgRect.origin.x + 4;
    oscDRect.origin.y = bgRect.origin.y + instrumentBarHeight;
    oscDRect.size.height = (bgRect.size.height - instrumentBarHeight) / 4;
    oscDRect.size.width = 395;
    UIColor* rowUnselectedColor = [[UIColor alloc] initWithRed:197.0 / 255 green:201.0 / 255 blue:213.0 / 255 alpha:1.0];
    
    [self drawRectangeInSize:oscDRect withRoundedEdges:10.0 withFillColor:rowUnselectedColor inContext:context];
    
    
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
    
    UIGraphicsPopContext();
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGPoint center;
    center.x = self.bounds.origin.x + self.bounds.size.width/2;
    center.y = self.bounds.origin.y + self.bounds.size.height/2;
    
    CGFloat size = self.bounds.size.width / 2;
    if(self.bounds.size.height < self.bounds.size.width) {
        size = self.bounds.size.height / 2;
    }
    size *= self.scale;

    
    CGPoint instrumentPosition;
    instrumentPosition.x = 2;
    //instrumentPosition.y = 480;
    instrumentPosition.y = size + 100;
    
    [self drawInstrumentsAtPoint:instrumentPosition inContext:context];

    // using OOP drawing
    instrumentPane = [InstrumentPane new];
    //TODO set colour theme here
    CGRect rectangle = CGRectMake(2, 2, 1500, 350);
    // scale when necessary
    rectangle.size.width *= self.scale;
    rectangle.size.height *= self.scale;
    [instrumentPane drawIn:rectangle inContext:context];
    
    
    
    // test
    UIBezierPath* onKnob = [UIBezierPath bezierPathWithArcCenter:center radius:size startAngle:M_PI*2 endAngle:0 clockwise:YES];
    
    [onKnob setLineWidth:2.0];
    [[UIColor whiteColor] setStroke];
    [onKnob stroke];
    // test end
    
    
    
}


@end
