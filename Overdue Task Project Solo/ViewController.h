//
//  ViewController.h
//  Overdue Task Project Solo
//
//  Created by Brian Starr on 10/20/14.
//  Copyright (c) 2014 Brian Starr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddTaskViewController.h"

@interface ViewController : UIViewController <AddTaskViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *tasks;

- (IBAction)addTaskButton:(UIBarButtonItem *)sender;
- (IBAction)reorderButton:(UIBarButtonItem *)sender;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

