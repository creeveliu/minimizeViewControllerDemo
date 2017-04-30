//
//  OMCPlayingHintViewController.m
//  GlobalViewDemo
//
//  Created by GuochengLiu on 2017/4/29.
//  Copyright © 2017年 sumavision. All rights reserved.
//

#import "OMCPlayingHintViewController.h"
#import "OMCPlayingManager.h"

@interface OMCPlayingHintViewController ()
@property (weak, nonatomic) IBOutlet UILabel *playingLabel;

@end

@implementation OMCPlayingHintViewController
{
    UIVisualEffectView *_blurView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    _blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    [self.view insertSubview:_blurView atIndex:0];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)]];
    
    [[OMCPlayingManager sharedManager] addObserver:self forKeyPath:@"playingVC.mediaURL" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:nil];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    self.playingLabel.text = [OMCPlayingManager sharedManager].playingVC.mediaURL;
}

- (void)didTap:(UITapGestureRecognizer *)sender
{
    [self.delegate shouldShowPlayingVC];
}


- (void)viewWillLayoutSubviews
{
    _blurView.frame = self.view.bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{
    [[OMCPlayingManager sharedManager] removeObserver:self forKeyPath:@"playingVC.mediaURL"];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
