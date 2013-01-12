//
//  LiveView.h
//  Live
//
//  Created by Marco Pehla on 02.11.12.
//  Copyright (c) 2012 tecgen.de. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiveView : UIView

@property (nonatomic) CGFloat scale;

-(void)pinch:(UIPinchGestureRecognizer *)gesture;

@end
