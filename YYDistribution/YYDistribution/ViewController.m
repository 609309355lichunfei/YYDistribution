//
//  ViewController.m
//  YYDistribution
//
//  Created by 李春菲 on 17/7/3.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "ViewController.h"
#import "JSPSHomeViewController.h"
#import "JSPSMainViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIButton *changeBT;

@property (strong, nonatomic) JSPSHomeViewController *homeViewController;
@property (strong, nonatomic) JSPSMainViewController *mainViewController;
@property (strong, nonatomic) UIViewController *currentVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self registUI];
    
}

- (void)registUI {
    self.homeViewController = [[JSPSHomeViewController alloc] init];
    [self.homeViewController willMoveToParentViewController:self];
    [self addChildViewController:self.homeViewController];
    [self.homeViewController didMoveToParentViewController:self];
    self.homeViewController.view.frame = self.mainView.bounds;
    [self.mainView addSubview:self.homeViewController.view];
    _currentVC = _homeViewController;
    
    self.mainViewController = [[JSPSMainViewController alloc] init];
    
}

- (IBAction)changeControllerAction:(id)sender {
    if (_currentVC == _homeViewController) {
        [self replaceController:_currentVC newController:_mainViewController];
        [self.changeBT setTitle:@"订单处理" forState:(UIControlStateNormal)];
    } else {
        [self replaceController:_currentVC newController:_homeViewController];
        [self.changeBT setTitle:@"个人中心" forState:(UIControlStateNormal)];
    }
}

#pragma mark - 页面切换
- (void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController
{
    CGRect rect = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
    [self addChildViewController:newController];
    [newController didMoveToParentViewController:self];
    [oldController willMoveToParentViewController:nil];
    [oldController removeFromParentViewController];
    [oldController.view removeFromSuperview];
    newController.view.frame = rect;
    [_mainView  addSubview:newController.view];
    _currentVC = newController;
    [_mainView sendSubviewToBack:newController.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
