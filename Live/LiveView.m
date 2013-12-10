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

    
    // using OOP drawing
    instrumentPane = [[InstrumentPane alloc] init];
    //TODO set colour theme here
    CGRect rectangle = CGRectMake(2, 2, 1500, 440);
    // scale when necessary
    rectangle.size.width *= self.scale;
    rectangle.size.height *= self.scale;
    [instrumentPane drawIn:rectangle inContext:context];
    
    
    /*
    // test
    UIBezierPath* onKnob = [UIBezierPath bezierPathWithArcCenter:center radius:size startAngle:M_PI*2 endAngle:0 clockwise:YES];
    
    [onKnob setLineWidth:2.0];
    [[UIColor whiteColor] setStroke];
    [onKnob stroke];
    // test end
    */
}
@end