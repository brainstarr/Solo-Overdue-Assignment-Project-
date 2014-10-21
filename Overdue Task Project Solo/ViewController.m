//
//  ViewController.m
//  Overdue Task Project Solo
//
//  Created by Brian Starr on 10/20/14.
//  Copyright (c) 2014 Brian Starr. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(NSMutableArray *)tasks
{
    if (!_tasks){
        _tasks = [[NSMutableArray alloc] init];
    }
    
    return _tasks;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


- (IBAction)addTaskButton:(UIBarButtonItem *)sender {
}

- (IBAction)reorderButton:(UIBarButtonItem *)sender {
}

#pragma mark - AddTaskVC Delegate

-(void)didAddTask:(TaskObject *)task
{
    [self.tasks addObject:task];
    
    NSMutableArray *taskObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECTS_KEY]mutableCopy];
    if (!taskObjectsAsPropertyLists) taskObjectsAsPropertyLists = [[NSMutableArray alloc]init];
    
    [taskObjectsAsPropertyLists addObject:[self taskObjectAsPropertyList:task]];
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyLists forKey:TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissViewControllerAnimated: YES completion:nil];
    [self.tableView reloadData];
}

-(void)didCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - helper methods

-(NSDictionary *)taskObjectAsPropertyList:(TaskObject *)taskobject
{
    NSDictionary *dictionary = @{TASK_NAME : taskobject.taskName , TASK_DESCRIPTION : taskobject.description , TASK_DATE : taskobject.taskDate , COMPLETION : @(taskobject.status)};
    
    return dictionary;
}

@end
