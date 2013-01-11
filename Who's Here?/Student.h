//
//  Student.h
//  Who's Here?
//
//  Created by Samuel E. Giddins on 1/11/13.
//  Copyright (c) 2013 Samuel E. Giddins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Student : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * attendance;
@property (nonatomic, retain) NSSet *studentClass;
@end

@interface Student (CoreDataGeneratedAccessors)

- (void)addStudentClassObject:(NSManagedObject *)value;
- (void)removeStudentClassObject:(NSManagedObject *)value;
- (void)addStudentClass:(NSSet *)values;
- (void)removeStudentClass:(NSSet *)values;

@end
