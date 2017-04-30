//
//  OMCPlayingViewController.h
//  GlobalViewDemo
//
//  Created by GuochengLiu on 2017/4/30.
//  Copyright © 2017年 sumavision. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OMCPlayingViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *mediaURLLabel;
@property (copy, nonatomic) NSString *mediaURL;

- (instancetype)initWithMediaURL:(NSString *)mediaURL;

@end
