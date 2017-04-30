//
//  OMCPlayingHintViewController.h
//  GlobalViewDemo
//
//  Created by GuochengLiu on 2017/4/29.
//  Copyright © 2017年 sumavision. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OMCPlayingHintViewControllerDelegate <NSObject>

- (void)shouldShowPlayingVC;

@end

@interface OMCPlayingHintViewController : UIViewController

@property (nonatomic, weak) id<OMCPlayingHintViewControllerDelegate> delegate;
@end
