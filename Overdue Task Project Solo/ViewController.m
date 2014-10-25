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



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    NSArray *tasksAsPropertyLists = [[NSUserDefaults standardUserDefaults]arrayForKey:TASK_OBJECTS_KEY];
    
    for (NSDictionary *dictionary in tasksAsPropertyLists)
    {
        TaskObject *task = [self taskObjectForDictionary:dictionary];
        [self.tasks addObject:task];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark - navigation


- (IBAction)addTaskButton:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"toAddTaskVC" sender:nil];
}

- (IBAction)reorderButton:(UIBarButtonItem *)sender {
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[AddTaskViewController class]])
    {
        AddTaskViewController *addTaskVC = segue.destinationViewController;
        addTaskVC.delegate = self;
    }
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

-(NSMutableArray *)tasks
{
    if (!_tasks){
        _tasks = [[NSMutableArray alloc] init];
    }
    
    return _tasks;
}

-(TaskObject *)taskObjectForDictionary:(NSDictionary *)dictionary
{
    TaskObject *task = [[TaskObject alloc]initWithData:dictionary];
    
    return task;
}

- (BOOL)isDateGreaterThanDate:(NSDate*)date and:(NSDate*)toDate
{
    NSTimeInterval firstinterval = [date timeIntervalSince1970];
    NSTimeInterval secondInterval = [toDate timeIntervalSince1970];
    
    if (firstinterval > secondInterval) return YES;
    else return NO;
}

-(void)updateCompletionOfTask:(TaskObject *)task forIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableArray *updatedTaskObjects = [[[NSUserDefaults standardUserDefaults]arrayForKey:TASK_OBJECTS_KEY]mutableCopy];
    if (!updatedTaskObjects) updatedTaskObjects = [[NSMutableArray alloc]init];
    
    [updatedTaskObjects removeObjectAtIndex:indexPath.row];
    
    if (task.status == NO) task.status = YES;
    else task.status = NO;
    [updatedTaskObjects insertObject:[self taskObjectAsPropertyList:task] atIndex:indexPath.row];
    
    [[NSUserDefaults standardUserDefaults]setObject:updatedTaskObjects forKey:TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self.tableView reloadData];
    
}

#pragma Datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tasks count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    TaskObject *task = self.tasks[indexPath.row];
    cell.textLabel.text = task.taskName;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:@"MM-DD-YY"];
    NSString *stringFromDate = [formatter stringFromDate:task.taskDate];
    cell.detailTextLabel.text = stringFromDate;
    
    BOOL isOverdue = [self isDateGreaterThanDate:[NSDate date] and:task.taskDate];
    
    if (task.status == YES) cell.backgroundColor = [UIColor greenColor];
    else if (isOverdue == YES) cell.backgroundColor = [UIColor redColor];
    else cell.backgroundColor = [UIColor yellowColor];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TaskObject *taskToBeUpdated = self.tasks[indexPath.row];
    
    [self updateCompletionOfTask:taskToBeUpdated forIndexPath:indexPath];
}

@end
