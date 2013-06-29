//
//  MJViewController.m
//  MJPasswordView
//
//  Created by 倪敏杰 on 13-6-29.
//  Copyright (c) 2013年 倪敏杰. All rights reserved.
//

#import "MJViewController.h"
#import "MJPasswordView.h"

@interface MJViewController ()

@property (nonatomic,retain) MJPasswordView* passwordView;

@end

@implementation MJViewController

- (void)dealloc
{
    self.passwordView = nil;
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CGRect frame = CGRectMake(20, 100, kPasswordViewSideLength, kPasswordViewSideLength);
    self.passwordView = [[[MJPasswordView alloc] initWithFrame:frame] autorelease];
    [self.view addSubview:self.passwordView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
