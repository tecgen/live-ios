//
//  Operator.h
//  Live
//
//  Created by Marco Pehla on 12.01.13.
//  Copyright (c) 2013 tecgen.de. All rights reserved.
//

#import "Instrument.h"

@interface Operator : Instrument

FOUNDATION_EXPORT NSString *const instrumentName;

-(void) setFilter: (NSInteger) frequency;

@end
