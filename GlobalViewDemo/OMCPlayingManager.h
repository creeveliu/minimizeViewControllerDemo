//
//  OMCPlayingManager.h
//  GlobalViewDemo
//
//  Created by GuochengLiu on 2017/4/30.
//  Copyright © 2017年 sumavision. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OMCPlayingViewController.h"

@interface OMCPlayingManager : NSObject

@property (nonatomic, strong) OMCPlayingViewController *playingVC;

+ (instancetype)sharedManager;


@end
