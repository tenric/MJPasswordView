//
//  MJPasswordView.m
//  MJPasswordView
//
//  Created by 倪敏杰 on 13-6-29.
//  Copyright (c) 2013年 倪敏杰. All rights reserved.
//

#import "MJPasswordView.h"
#import "MJCircleLayer.h"
#import "MJPathLayer.h"

@interface MJPasswordView()

@property (nonatomic,retain) MJPathLayer* pathLayer;

- (void) setLayerFrames;

@end

@implementation MJPasswordView

- (void) dealloc
{
    self.circleLayers = nil;
    self.circleFillColour = nil;
    self.trackingIds = nil;
    self.pathLayer = nil;
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor yellowColor];
        self.circleFillColour = [UIColor blueColor];
        self.circleFillColourHighlighted = [UIColor redColor];
        self.pathColour = [UIColor grayColor];
        
        self.circleLayers = [NSMutableArray arrayWithCapacity:9];
        self.trackingIds = [NSMutableArray arrayWithCapacity:9];
        MJCircleLayer* circleLayer;
        for (int i = 0; i < 3; i++)
        {
            for (int j = 0; j < 3; j++)
            {
                circleLayer = [MJCircleLayer layer];
                circleLayer.passwordView = self;
                [self.circleLayers addObject:circleLayer];
                [self.layer addSublayer:circleLayer];
            }
        }
        
        self.pathLayer = [MJPathLayer layer];
        self.pathLayer.passwordView = self;
        [self.layer addSublayer:self.pathLayer];
        
        [self setLayerFrames];
    }
    return self;
}

- (void) setLayerFrames
{
    CGPoint point;
    MJCircleLayer* circleLayer;
    for (int i = 0; i < 3; i++)
    {
        for (int j = 0; j < 3; j++)
        {
            CGFloat x = kCircleLeftTopMargin+kCircleRadius+j*(kCircleRadius*2+kCircleBetweenMargin);
            CGFloat y = kCircleLeftTopMargin+kCircleRadius+i*(kCircleRadius*2+kCircleBetweenMargin);
            point = CGPointMake(x, y);
            circleLayer = [self.circleLayers objectAtIndex:i*3+j];
            circleLayer.frame = CGRectMake(x-kCircleRadius, y-kCircleRadius, kCircleRadius*2, kCircleRadius*2);
            
            [circleLayer setNeedsDisplay];
        }
    }
    
    self.pathLayer.frame = self.bounds;
    [self.pathLayer setNeedsDisplay];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];

    self.isTracking = NO;
    
    UITouch* touch = [touches anyObject];
    
    self.previousTouchPoint = [touch locationInView:self];
    
    MJCircleLayer* circleLayer;
    for (int i = 0; i < 9; i++)
    {
        circleLayer = [self.circleLayers objectAtIndex:i];
        if ([self containPoint:_previousTouchPoint inCircle:circleLayer.frame])
        {
            circleLayer.highlighted = YES;
            [circleLayer setNeedsDisplay];
            self.isTracking = YES;
            [self.trackingIds addObject:[NSNumber numberWithInt:i]];
            break;
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    if (self.isTracking)
    {
        UITouch* touch = [touches anyObject];
        
        self.previousTouchPoint = [touch locationInView:self];
        
        MJCircleLayer* circleLayer;
        for (int i = 0; i < 9; i++)
        {
            circleLayer = [self.circleLayers objectAtIndex:i];
            if ([self containPoint:_previousTouchPoint inCircle:circleLayer.frame])
            {
                if (![self hasVistedCircle:i])
                {
                    circleLayer.highlighted = YES;
                    [circleLayer setNeedsDisplay];
                    [self.trackingIds addObject:[NSNumber numberWithInt:i]];
                    break;
                }
            }
        }
        [self.pathLayer setNeedsDisplay];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    NSString* password = [self getPassword:self.trackingIds];
    
    if (password.length > kMinPasswordLength)
    {
        [self.delegate passwordView:self withPassword:password];
    }
    
    
    [self resetTrackingState];
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    [self resetTrackingState];
}

- (BOOL)hasVistedCircle:(int)circleId
{
    BOOL hasVisit = NO;
    for (NSNumber* number in self.trackingIds)
    {
        if ([number intValue] == circleId)
        {
            hasVisit = YES;
            break;
        }
    }
    return hasVisit;
}

- (void)resetTrackingState
{
    self.isTracking = NO;
    
    MJCircleLayer* circleLayer;
    for (int i = 0; i < 9; i++)
    {
        circleLayer = [self.circleLayers objectAtIndex:i];
        if (circleLayer.highlighted == YES)
        {
            circleLayer.highlighted = NO;
            [circleLayer setNeedsDisplay];
        }
    }
    [self.trackingIds removeAllObjects];
    
    [self.pathLayer setNeedsDisplay];
}

- (BOOL)containPoint:(CGPoint)point inCircle:(CGRect)rect
{
    CGPoint center = CGPointMake(rect.origin.x+rect.size.width/2, rect.origin.y+rect.size.height/2);
    BOOL isContain = ((center.x-point.x)*(center.x-point.x)+(center.y-point.y)*(center.y-point.y)-kCircleRadius*kCircleRadius)<0;
    return isContain;
}

- (NSString*)getPassword:(NSArray*)array
{
    NSMutableString* password = [[[NSMutableString alloc] initWithCapacity:9] autorelease];
    for (int i = 0; i < [array count]; i++)
    {
        NSNumber* number = [array objectAtIndex:i];
        [password appendFormat:@"%d",[number intValue]];
    }
    return password;
}
@end
