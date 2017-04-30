//
//  OMCPlayingViewController.m
//  GlobalViewDemo
//
//  Created by GuochengLiu on 2017/4/30.
//  Copyright © 2017年 sumavision. All rights reserved.
//

#import "OMCPlayingViewController.h"
#import "OMCPlayingManager.h"

@interface OMCPlayingViewController ()

@end

@implementation OMCPlayingViewController

- (instancetype)initWithMediaURL:(NSString *)mediaURL
{
    self = [self init];
    if (self) {
        self.mediaURL = mediaURL;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [OMCPlayingManager sharedManager].playingVC = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mediaURLLabel.text = _mediaURL;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)minimize
{
    CGRect frame = self.view.frame;
    CGSize size = frame.size;
    
    frame.origin.y = size.height;
    [self viewWillDisappear:YES];
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame = frame;
    } completion:^(BOOL finished) {
        if (finished) {
            [self viewDidDisappear:YES];
        }
    }];
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        [OMCPlayingManager sharedManager].playingVC = nil;
    }];
}


- (IBAction)minimize:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{

    }];
}

@end
