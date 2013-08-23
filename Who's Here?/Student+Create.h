//
//  Student+Create.h
//  Who's Here?
//
//  Created by Samuel E. Giddins on 1/12/13.
//  Copyright (c) 2013 Samuel E. Giddins. All rights reserved.
//

#import "Student.h"

@interface Student (Create)

+ (Student *)studentWithName:(NSString *)name andClass:(StudentClass *)class;

@end
