//
//  MJPathLayer.m
//  MJPasswordView
//
//  Created by tenric on 13-6-30.
//  Copyright (c) 2013年 tenric. All rights reserved.
//

#import "MJPathLayer.h"
#import "MJPasswordView.h"

@implementation MJPathLayer

- (void)drawInContext:(CGContextRef)ctx
{
    if(!self.passwordView.isTracking)
    {
        return;
    }
    
    NSArray* circleIds = self.passwordView.trackingIds;
    int circleId = [[circleIds objectAtIndex:0] intValue];
    CGPoint point = [self getPointWithId:circleId];
    CGContextSetLineWidth(ctx, kPathWidth);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextSetStrokeColor(ctx,CGColorGetComponents(self.passwordView.pathColour.CGColor));
    CGContextBeginPath(ctx);
    
    CGContextMoveToPoint(ctx, point.x, point.y);
    
    for (int i = 1; i < [circleIds count]; i++)
    {
        circleId = [[circleIds objectAtIndex:i] intValue];
        point = [self getPointWithId:circleId];
        CGContextAddLineToPoint(ctx, point.x, point.y);
    }
   
    point = self.passwordView.previousTouchPoint;
    CGContextAddLineToPoint(ctx, point.x, point.y);
// 下面这行的作用是将当前context的strokeColor设成pathColour，但是当前context是null
// 你可以调用UIGraphicsGetCurrentContext()看看返回值（就是当前context）是否为空，
// 删除掉下面这行就ok了，原因有二：
// 1、上面已经用CGContextSetStrokeColor设置过颜色了，没必要重新设一次
// 2、setStroke时UIKit的方法，默认会调用UIGraphicsGetCurrentContext(),而UIGraphicsGetCurrentContext()只能在UIView的drawRect方法里面调用，这里调用是错误的。
//    [self.passwordView.pathColour setStroke];
    CGContextDrawPath(ctx, kCGPathStroke);
}

- (CGPoint)getPointWithId:(int)circleId
{
    CGFloat x = kCircleLeftTopMargin+kCircleRadius+circleId%3*(kCircleRadius*2+kCircleBetweenMargin);
    CGFloat y = kCircleLeftTopMargin+kCircleRadius+circleId/3*(kCircleRadius*2+kCircleBetweenMargin);
    CGPoint point = CGPointMake(x, y);
    return point;
}

@end
