//
//  ViewController.m
//  ToDo
//
//  Created by Zi on 2/5/14.
//  Copyright (c) 2014 Zi. All rights reserved.
//

#import "ViewController.h"
#import "TaskViewController.h"
@interface ViewController ()
@property TaskViewController *taskViewController;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.taskViewController = [TaskViewController new];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController: self.taskViewController];
    
    [self.view addSubview: navigationController.view];
    navigationController.view.layer.borderColor = [UIColor redColor].CGColor;
    navigationController.view.layer.borderWidth = 1;
    [self addChildViewController: navigationController];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
