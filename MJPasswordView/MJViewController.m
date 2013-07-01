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

@property (nonatomic,assign) ePasswordSate state;

@property (nonatomic,copy) NSString* password;

@property (nonatomic,retain) UIButton* clearButton;

@property (nonatomic,retain) UILabel* infoLabel;

@property (nonatomic,retain) MJPasswordView* passwordView;

@end

@implementation MJViewController

- (void)dealloc
{
    self.infoLabel = nil;
    self.passwordView = nil;
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.password = @"";
    self.state = ePasswordUnset;
    
    self.clearButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.clearButton.frame = CGRectMake(110, 20, 100, 30);
    [self.clearButton setTitle:@"清空密码" forState:UIControlStateNormal];
    [self.clearButton addTarget:self action:@selector(clearPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.clearButton];
    
    self.infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 300, 30)];
    self.infoLabel.backgroundColor = [UIColor clearColor];
    self.infoLabel.textAlignment = UITextAlignmentCenter;
    self.infoLabel.textColor = [UIColor redColor];
    [self.view addSubview:self.infoLabel];
    
    CGRect frame = CGRectMake(20, 100, kPasswordViewSideLength, kPasswordViewSideLength);
    self.passwordView = [[[MJPasswordView alloc] initWithFrame:frame] autorelease];
    self.passwordView.delegate = self;
    [self.view addSubview:self.passwordView];
    
    [self updateInfoLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateInfoLabel
{
    NSString* infoText;
    switch (self.state)
    {
        case ePasswordUnset:
            infoText = @"请滑动九宫格，设置密码";
            break;
            
        case ePasswordRepeat:
            infoText = [NSString stringWithFormat:@"请再次输入刚才的密码:%@",self.password];
            break;
            
        case ePasswordExist:
            infoText = [NSString stringWithFormat:@"密码设置成功，是:%@",self.password];
            break;
            
        default:
            break;
    }
    
    self.infoLabel.text = infoText;
}

- (void)clearPassword
{
    self.password = @"";
    self.state = ePasswordUnset;
    
    [self updateInfoLabel];
}

- (void)passwordView:(MJPasswordView*)passwordView withPassword:(NSString*)password
{
    switch (self.state)
    {
        case ePasswordUnset:
            self.password = password;
            self.state = ePasswordRepeat;
            break;
            
        case ePasswordRepeat:
            if ([password isEqualToString:self.password])
            {
                self.state = ePasswordExist;
                UIAlertView* view = [[UIAlertView alloc] initWithTitle:@"密码设置成功！" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [view show];
            }
            break;
            
        case ePasswordExist:
            if ([password isEqualToString:self.password])
            {
                UIAlertView* view = [[UIAlertView alloc] initWithTitle:@"密码正确！" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [view show];
            }
            else
            {
                UIAlertView* view = [[UIAlertView alloc] initWithTitle:@"密码错误，请重试！" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [view show];
            }
        
            break;
            
        default:
            break;
    }
    
    [self updateInfoLabel];
}
@end
