//
//  ViewController.m
//  TDActionSheet
//
//  Created by Su Jiandong on 15/11/4.
//  Copyright © 2015年 Su Jiandong. All rights reserved.
//

#import "ViewController.h"
#import "TDActionSheet.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)show:(id)sender {
    NSArray *titles = @[@"12345",@"23456",@"34567",@"45678"];
    TDActionSheet *actionSheet = [[TDActionSheet alloc] initWithTitles:titles callBack:^(NSInteger buttonIndex) {
        NSLog(@"buttonIndex = %lu",buttonIndex);
    }];
    [actionSheet show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
