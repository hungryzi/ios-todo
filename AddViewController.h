//
//  AddViewController.h
//  ToDo
//
//  Created by Zi on 2/5/14.
//  Copyright (c) 2014 Zi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AddViewControllerDelegate;
@interface AddViewController : UIViewController

@property (weak) id<AddViewControllerDelegate> delegate;
@end

@protocol AddViewControllerDelegate <NSObject>
@required
- (void) addViewController: (AddViewController*) viewController addedTaskWithName: (NSString *) name;

@end