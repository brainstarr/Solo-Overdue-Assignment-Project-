//
//  TaskObject.m
//  Overdue Task Project Solo
//
//  Created by Brian Starr on 10/20/14.
//  Copyright (c) 2014 Brian Starr. All rights reserved.
//

#import "TaskObject.h"

@implementation TaskObject

- (id)initWithData:(NSDictionary *)data
{
    self = [super init];
    
    if (self){
        self.taskName = data[TASK_NAME];
        self.taskDescription = data[TASK_DESCRIPTION];
        self.taskDate = data[TASK_DATE];
        self.status = [data[COMPLETION] boolValue];
    }
    
    return self;
}

- (id)init
{
    self = [self initWithData:nil];
    
    return self;
}

@end
