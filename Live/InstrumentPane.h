//
//  IntrumentPane.h
//  Live
//
//  Created by Marco Pehla on 12.01.13.
//  Copyright (c) 2013 tecgen.de. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InstrumentPane : NSObject

-(void) drawIn:(CGRect) rectangle
     inContext:(CGContextRef)context;

@end
