//
//  MJCircleLayer.m
//  MJCircleView
//
//  Created by tenric on 13-6-29.
//  Copyright (c) 2013年 tenric. All rights reserved.
//

#import "MJCircleLayer.h"
#import "MJPasswordView.h"

@implementation MJCircleLayer

- (void)drawInContext:(CGContextRef)ctx
{
    CGRect circleFrame = self.bounds;
    
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithRoundedRect:circleFrame
                            cornerRadius:circleFrame.size.height / 2.0];
    
    CGContextSetFillColorWithColor(ctx, self.passwordView.circleFillColour.CGColor);
    CGContextAddPath(ctx, circlePath.CGPath);
    CGContextFillPath(ctx);
    

    if (self.highlighted)
    {
        CGContextSetFillColorWithColor(ctx, self.passwordView.circleFillColourHighlighted.CGColor);
        CGContextAddPath(ctx, circlePath.CGPath);
        CGContextFillPath(ctx);
    }
}


@end
