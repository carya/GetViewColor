//
//  ViewController.m
//  GetViewColor
//
//  Created by MaohuaLiu on 14-10-28.
//  Copyright (c) 2014年 MaohuaLiu. All rights reserved.
//

#import "ViewController.h"
#import "LightControlPanel.h"

#define SCREEN_WIDTH                [[UIScreen mainScreen] bounds].size.width
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LightControlPanel *lightControlPanel = [[LightControlPanel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-235)/2, CGRectGetHeight(self.view.bounds)-120-235, 235, 235)];
    [self.view addSubview:lightControlPanel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
