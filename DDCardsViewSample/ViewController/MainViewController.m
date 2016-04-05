//
//  MainViewController.m
//  DraggableViewSample
//
//  Created by daiki ichikawa on 2016/03/31.
//  Copyright © 2016年 Daiki Ichikawa. All rights reserved.
//

#import "MainViewController.h"
#import "DDMainView.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view = [[DDMainView alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
