//
//  AddViewController.m
//  ToDo
//
//  Created by Zi on 2/5/14.
//  Copyright (c) 2014 Zi. All rights reserved.
//

#import "AddViewController.h"
@interface AddViewController ()
@property (strong) UITextField *textField;
@property (strong) UILabel *addLabel;
@end

@implementation AddViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Add";
    self.textField = [[UITextField alloc] initWithFrame: CGRectMake(0, self.navigationController.navigationBar.frame.size.height + 20, 320, 40)];
    self.textField.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview: self.textField];
    
    self.addLabel = [[UILabel alloc] initWithFrame: CGRectMake(100, 120,  40, 20)];
    [self.view addSubview: self.addLabel];
    self.addLabel.text = @"Add";
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(addLabelTapped:)];
    tapGesture.numberOfTapsRequired = 2;
    
    [self.addLabel addGestureRecognizer: tapGesture];
    self.addLabel.userInteractionEnabled = YES;
    
    
    
//    self.addButton = [[UIButton alloc] initWithFrame: CGRectMake(100, 100, 40, 20)];
//    self.addButton.backgroundColor = [UIColor blackColor];
//    [self.addButton setTitle: @"Add" forState: UIControlStateNormal];
//    [self.addButton sizeToFit];
//    [self.addButton addTarget: self action: @selector(addButtonTapped:) forControlEvents: UIControlEventTouchUpInside];
//    // Do any additional setup after loading the view.
//    [self.view addSubview: self.addButton];
}

- (void) addLabelTapped: (UITapGestureRecognizer *) gesture {
    if (self.delegate && [self.delegate respondsToSelector: @selector(addViewController:addedTaskWithName:)]) {
        [self.delegate addViewController: self addedTaskWithName: self.textField.text];
    }
    
    NSDictionary *userInfo = @{@"name":  self.textField.text};
    [[NSNotificationCenter defaultCenter] postNotificationName: @"addNewTask" object: nil userInfo:userInfo];
    [self.navigationController popViewControllerAnimated: YES];
}

- (void) addButtonTapped: (UIButton *) button {
    if (self.delegate && [self.delegate respondsToSelector: @selector(addViewController:addedTaskWithName:)]) {
        [self.delegate addViewController: self addedTaskWithName: self.textField.text];
    }
    
    NSDictionary *userInfo = @{@"name":  self.textField.text};
    [[NSNotificationCenter defaultCenter] postNotificationName: @"addNewTask" object: nil userInfo:userInfo];
    [self.navigationController popViewControllerAnimated: YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
