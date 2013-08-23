//
//  Student+Create.m
//  Who's Here?
//
//  Created by Samuel E. Giddins on 1/12/13.
//  Copyright (c) 2013 Samuel E. Giddins. All rights reserved.
//

#import "Student+Create.h"

@implementation Student (Create)

+ (Student *)studentWithName:(NSString *)name andClass:(StudentClass *)class
{
    Student *student = [[Student alloc] init];
    student.name = name;
    student.studentClass = class;
    return student;
}

@end
