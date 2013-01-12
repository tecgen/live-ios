//
//  LiveViewController.m
//  Live
//
//  Created by Marco Pehla on 16.10.12.
//  Copyright (c) 2012 tecgen.de. All rights reserved.
//

#import "LiveViewController.h"
#import "LiveView.h"

@interface LiveViewController ()
@property (nonatomic, weak) IBOutlet LiveView *liveView;
@end

@implementation LiveViewController

@synthesize knob1Value = _knob1Value;
@synthesize liveView = _liveView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * only self implemented to be able to add the gesture recognizer
 */
-(void)setLiveView:(LiveView *)liveView
{
    _liveView = liveView;
    // wire up an gesture recognizer to public operation pinch of class LiveView
    [self.liveView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.liveView action:@selector(pinch:)]];
    
}

/*
// implemented by ourself to overide the setter in order to
// be able to hook model changes to the refesh routine for the
// display
- (void)knob1Value:(int)value
{
    
    _knob1Value = value;
    [self.liveView setNeedsDisplay];
}
*/

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    // Support all orientations.
    return YES;
}


@end
