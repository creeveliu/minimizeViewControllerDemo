//
//  ViewController.m
//  GlobalViewDemo
//
//  Created by GuochengLiu on 2017/4/29.
//  Copyright © 2017年 sumavision. All rights reserved.
//

#import "ViewController.h"
#import "OMCPlayingHintViewController.h"
#import "OMCPlayingManager.h"

@interface ViewController ()

@property (strong, nonatomic) OMCPlayingHintViewController *playingHintVC;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[OMCPlayingManager sharedManager] addObserver:self forKeyPath:@"playingVC" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"playingVC"]) {
        if ([OMCPlayingManager sharedManager].playingVC) {
            [self showHintVC];
        } else {
            [self hideHintVC];
        }
    }
}

- (IBAction)goPlay:(id)sender {
    OMCPlayingViewController *playingVC = [[OMCPlayingViewController alloc] initWithMediaURL:_textField.text];
    [self presentViewController:playingVC animated:YES completion:nil];
    [self.view endEditing:YES];
}

- (void)hideHintVC
{
    [self.playingHintVC willMoveToParentViewController:nil];
    if (self.playingHintVC.view.superview) {
        [self.playingHintVC.view removeFromSuperview];
    }
    [self.playingHintVC removeFromParentViewController];
}

- (void)showHintVC
{
    [self.playingHintVC willMoveToParentViewController:self.tabBarController];
    [self.playingHintVC removeFromParentViewController];
    [self.tabBarController.view addSubview:self.playingHintVC.view];
    [self.playingHintVC didMoveToParentViewController:self.tabBarController];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGFloat hintHeight = 44;
    CGSize size = self.tabBarController.view.frame.size;
    _playingHintVC.view.frame = CGRectMake(0, size.height - 49 - hintHeight, size.width, hintHeight);
    
    for (UIView *subView in _playingHintVC.view.subviews) {
        if ([subView isKindOfClass:[UIVisualEffectView class]]) {
            [subView setFrame:_playingHintVC.view.bounds];
        }
    }
}

- (OMCPlayingHintViewController *)playingHintVC
{
    if (_playingHintVC == nil) {
        _playingHintVC = [[OMCPlayingHintViewController alloc] init];
        [_playingHintVC setDelegate:(id<OMCPlayingHintViewControllerDelegate>)self];
    }
    return _playingHintVC;
}

- (void)shouldShowPlayingVC
{
    if ([OMCPlayingManager sharedManager].playingVC) {
        [self presentViewController:[OMCPlayingManager sharedManager].playingVC animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[OMCPlayingManager sharedManager] removeObserver:self forKeyPath:@"playingVC"];
}



@end
