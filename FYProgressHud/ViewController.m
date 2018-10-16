//
//  ViewController.m
//  FYProgressHud
//
//  Created by wang on 2018/10/15.
//  Copyright © 2018 wang. All rights reserved.
//

#import "ViewController.h"
#import "HUD/MBProgressHUD+FYHUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [MBProgressHUD fy_showOnlyText:@"ceshi" view:self.view];
//    [MBProgressHUD fy_showLoadingGif:@"201802061132011" view:self.view duration:8];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//    });
}


@end
