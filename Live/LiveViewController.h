//
//  LiveViewController.h
//  Live
//
//  Created by Marco Pehla on 16.10.12.
//  Copyright (c) 2012 tecgen.de. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiveViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *display;

// TODO the model should be referenced here instead of the integer

// to hold the value of the knob one of the APC 40
@property (nonatomic) int knob1Value;
//TODO:add more for every or generate it somehow...

@end
