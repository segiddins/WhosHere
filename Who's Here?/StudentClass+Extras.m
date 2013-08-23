//
//  StudentClass+Extras.m
//  Who's Here?
//
//  Created by Samuel E. Giddins on 1/15/13.
//  Copyright (c) 2013 Samuel E. Giddins. All rights reserved.
//

#import "StudentClass+Extras.h"
#import "Student+Create.h"

@implementation StudentClass (Extras)

- (NSInteger)numAbsent
{
    NSInteger absent = 0;
    for (Student *student in self.students) {
        if ([student.attendance integerValue] == 2) {
            absent++;
        }
    }
    return absent;
}

@end
