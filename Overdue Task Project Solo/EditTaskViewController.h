//
//  EditTaskViewController.h
//  Overdue Task Project Solo
//
//  Created by Brian Starr on 10/20/14.
//  Copyright (c) 2014 Brian Starr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditTaskViewController : UIViewController

- (IBAction)saveTaskButton:(UIBarButtonItem *)sender;


@property (strong, nonatomic) IBOutlet UITextField *editTaskNameTextField;
@property (strong, nonatomic) IBOutlet UITextView *editTaskDesctiptionTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *editTaskDatePicker;

@end
