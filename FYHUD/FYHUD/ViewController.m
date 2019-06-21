//
//  ViewController.m
//  FYHUD
//
//  Created by wang on 2019/6/21.
//  Copyright © 2019 wang. All rights reserved.
//

#import "ViewController.h"
#import "FYHUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
     [FYHUD showWithTips:@"加载成功"];
}
- (IBAction)left:(id)sender {
    NSLog(@"点击了");
    [FYHUD show];
}

@end
