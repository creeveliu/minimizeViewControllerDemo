//
//  OMCPlayingManager.m
//  GlobalViewDemo
//
//  Created by GuochengLiu on 2017/4/30.
//  Copyright © 2017年 sumavision. All rights reserved.
//

#import "OMCPlayingManager.h"

@implementation OMCPlayingManager

+ (instancetype)sharedManager
{
    static OMCPlayingManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[OMCPlayingManager alloc] init];
    });
    return sharedMyManager;
}

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}


@end
