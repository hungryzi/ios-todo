//
//  TaskViewController.h
//  ToDo
//
//  Created by Zi on 2/5/14.
//  Copyright (c) 2014 Zi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddViewController.h"
@interface TaskViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, AddViewControllerDelegate>

- (void) saveToDisk;
- (void) loadFromDisk;

@end
