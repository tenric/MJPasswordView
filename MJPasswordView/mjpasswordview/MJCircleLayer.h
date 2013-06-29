//
//  MJCircleLayer.h
//  MJCircleView
//
//  Created by 倪敏杰 on 13-6-29.
//  Copyright (c) 2013年 倪敏杰. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@class MJPasswordView;

@interface MJCircleLayer : CALayer

@property (nonatomic,assign) BOOL highlighted;
@property (nonatomic,assign) MJPasswordView* passwordView;

@end
