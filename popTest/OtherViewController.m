//
//  OtherViewController.m
//  popTest
//
//  Created by wujunyang on 16/2/15.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "OtherViewController.h"

@interface OtherViewController ()
@property(assign,nonatomic)BOOL isMenuOpen;
@property(strong,nonatomic)UIView *myMenuView;
@property(nonatomic)CGPoint VisiblePosition,HiddenPosition;
@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    _isMenuOpen=NO;
    self.VisiblePosition=CGPointMake(290, 100);
    self.HiddenPosition=CGPointMake(290, -80);
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"显示" style:UIBarButtonItemStylePlain
                                                                     target:self action:@selector(refreshPropertyList)];
    self.navigationItem.rightBarButtonItem = anotherButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refreshPropertyList
{
    if (_isMenuOpen) {
        [self hidePopup];
    }
    else
    {
        [self showPopup];
    }
}

//隐藏时响应
- (void)hidePopup
{
    _isMenuOpen = NO;
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.fromValue = @(1);
    opacityAnimation.toValue = @(0);
    [self.myMenuView.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
    
    POPBasicAnimation *positionAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
    positionAnimation.fromValue = [NSValue valueWithCGPoint:self.VisiblePosition];
    positionAnimation.toValue = [NSValue valueWithCGPoint:self.HiddenPosition];
    [self.myMenuView.layer pop_addAnimation:positionAnimation forKey:@"positionAnimation"];
    
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    
    scaleAnimation.fromValue  = [NSValue valueWithCGSize:CGSizeMake(1.0f, 1.0f)];
    scaleAnimation.toValue  = [NSValue valueWithCGSize:CGSizeMake(0.5f, 0.5f)];
    [self.myMenuView.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
}

//显示时响应
- (void)showPopup
{
    //初始化视图
    if (self.myMenuView==nil) {
        self.myMenuView=[[UIView alloc]initWithFrame:CGRectMake(0,0, 80, 50)];
        self.myMenuView.backgroundColor=[UIColor redColor];
        [self.view addSubview:self.myMenuView];
    }
    
    _isMenuOpen = YES;
    
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.fromValue = @(0);
    opacityAnimation.toValue = @(1);
    opacityAnimation.beginTime = CACurrentMediaTime() + 0.1;
    [self.myMenuView.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
    
    POPBasicAnimation *positionAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
    positionAnimation.fromValue = [NSValue valueWithCGPoint:self.HiddenPosition];
    positionAnimation.toValue = [NSValue valueWithCGPoint:self.VisiblePosition];
    [self.myMenuView.layer pop_addAnimation:positionAnimation forKey:@"positionAnimation"];
    
    
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.fromValue  = [NSValue valueWithCGSize:CGSizeMake(0.5, 0.5f)];
    scaleAnimation.toValue  = [NSValue valueWithCGSize:CGSizeMake(1.0f, 1.0f)];
    scaleAnimation.springBounciness = 20.0f;
    scaleAnimation.springSpeed = 20.0f;
    [self.myMenuView.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
}
@end
