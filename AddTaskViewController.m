//
//  AddTaskViewController.m
//  Overdue Task Project Solo
//
//  Created by Brian Starr on 10/20/14.
//  Copyright (c) 2014 Brian Starr. All rights reserved.
//

#import "AddTaskViewController.h"

@interface AddTaskViewController ()

@end

@implementation AddTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addTaskButtonPressed:(UIButton *)sender
{
    [self.delegate didAddTask:[self returnTaskObject]];
}

- (IBAction)cancelButtonPressed:(UIButton *)sender
{
    [self.delegate didCancel];
}

#pragma mark - Helper Methods

-(TaskObject *)returnTaskObject
{
    TaskObject *task = [[TaskObject alloc]init];
    task.taskName = self.nameTextField.text;
    task.taskDescription = self.detailsTextView.text;
    task.taskDate = self.datePicker.date;
    task.status = NO;
    
    return task;
}

@end
