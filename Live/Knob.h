//
//  Knob.h
//  Live
//
//  Created by Marco Pehla on 12.01.13.
//  Copyright (c) 2013 tecgen.de. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Knob : NSObject

-(void) drawAt:(CGPoint)point
     withLabel:(NSString*)description
 andValueLabel:(NSString*)valueLabel
     inContext:(CGContextRef)context;

@end
