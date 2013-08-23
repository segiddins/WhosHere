//
//  SEGStudentDetailTableViewController.h
//  Who's Here?
//
//  Created by Samuel E. Giddins on 1/12/13.
//  Copyright (c) 2013 Samuel E. Giddins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Student+Create.h"

@interface SEGStudentDetailTableViewController : UITableViewController <UIAlertViewDelegate>

@property (nonatomic) Student *student;
@property (weak, nonatomic) IBOutlet UITextView *notesView;
@property UITextField *studentNameField;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
