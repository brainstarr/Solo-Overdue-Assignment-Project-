//
//  AddTaskViewController.h
//  Overdue Task Project Solo
//
//  Created by Brian Starr on 10/20/14.
//  Copyright (c) 2014 Brian Starr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddTaskViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextView *detailsTextView;

- (IBAction)addTaskButton:(UIButton *)sender;
- (IBAction)cancelButton:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

@end
