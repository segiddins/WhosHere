//
//  SEGDetailViewController.h
//  Who's Here?
//
//  Created by Samuel E. Giddins on 1/11/13.
//  Copyright (c) 2013 Samuel E. Giddins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudentClass+Extras.h"
#import "Student.h"
#import "SEGStudentDetailTableViewController.h"

@interface SEGDetailViewController : UIViewController <UISplitViewControllerDelegate, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) StudentClass *detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (strong, nonatomic) SEGStudentDetailTableViewController *studentController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

#define ABSENT_COLOR [UIColor colorWithRed:0.800 green:0.000 blue:0.000 alpha:1.000]
#define HERE_COLOR [UIColor colorWithRed:0.200 green:0.600 blue:0.200 alpha:1.000]
