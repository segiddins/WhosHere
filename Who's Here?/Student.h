//
//  Student.h
//  Who's Here?
//
//  Created by Samuel E. Giddins on 1/14/13.
//  Copyright (c) 2013 Samuel E. Giddins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class StudentClass;

@interface Student : NSManagedObject

@property (nonatomic, retain) NSNumber * attendance;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) StudentClass *studentClass;

@end
