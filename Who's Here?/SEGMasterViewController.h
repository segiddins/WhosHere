//
//  SEGMasterViewController.h
//  Who's Here?
//
//  Created by Samuel E. Giddins on 1/11/13.
//  Copyright (c) 2013 Samuel E. Giddins. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SEGDetailViewController;

#import <CoreData/CoreData.h>

@interface SEGMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) SEGDetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
