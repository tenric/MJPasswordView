//
//  MJPasswordView.h
//  MJPasswordView
//
//  Created by 倪敏杰 on 13-6-29.
//  Copyright (c) 2013年 倪敏杰. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kPasswordViewSideLength 280.0
#define kCircleRadius 30.0
#define kCircleLeftTopMargin 10.0
#define kCircleBetweenMargin 40.0

#define kPathWidth 6.0

#define kMinPasswordLength 3

typedef enum ePasswordSate {
    ePasswordUnset,
    ePasswordRepeat,
    ePasswordExist
}ePasswordSate;

@class MJPasswordView;

@protocol MJPasswordDelegate <NSObject>

- (void)passwordView:(MJPasswordView*)passwordView withPassword:(NSString*)password;

@end

@interface MJPasswordView : UIView

@property (nonatomic,assign) id<MJPasswordDelegate> delegate;

@property (nonatomic,retain) UIColor* circleFillColour;
@property (nonatomic,retain) UIColor* circleFillColourHighlighted;

@property (nonatomic,retain) UIColor* pathColour;

@property (nonatomic,assign) CGPoint previousTouchPoint;
@property (nonatomic,assign) BOOL isTracking;

@property (nonatomic,retain) NSMutableArray* circleLayers;
@property (nonatomic,retain) NSMutableArray* trackingIds;

@end
