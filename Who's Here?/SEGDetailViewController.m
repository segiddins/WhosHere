//
//  SEGDetailViewController.m
//  Who's Here?
//
//  Created by Samuel E. Giddins on 1/11/13.
//  Copyright (c) 2013 Samuel E. Giddins. All rights reserved.
//

#import "SEGDetailViewController.h"
#import "SEGStudentDetailTableViewController.h"
#import "SEGStudentCell.h"
#import <UI7Kit/UI7Color.h>
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"

@interface SEGDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (void)configureView;
@end

@implementation SEGDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {

        self.navigationItem.title = self.detailItem.name;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.toolbarItems = @[
    [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
    [[UIBarButtonItem alloc] initWithTitle:@"0 Absent" style:UIBarButtonItemStyleBordered target:nil action:nil],
    [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
        [[UIBarButtonItem alloc] initWithTitle:@"Start Over"
                                         style:UIBarButtonItemStyleBordered
                                        target:self
                                        action:@selector(startOver:)]];
    for (UIBarButtonItem *barItem in self.toolbarItems) {
        if (![barItem.title isEqualToString:@"Start Over"]) barItem.enabled = NO;
        [barItem setTitleTextAttributes:@{UITextAttributeTextShadowColor : [UIColor clearColor], UITextAttributeTextColor : [UI7Color defaultTintColor]} forState:UIControlStateNormal];
    }
    GAI_REPORT_SCREEN(@"Individual Class");
	// Do any additional setup after loading the view, typically from a nib.
    [self controllerDidChangeContent:self.fetchedResultsController];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self configureView];
    self.fetchedResultsController = [self fetchedResultsController];
    [self.tableView reloadData];
    self.navigationController.toolbarHidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startOver:(id)sender
{
    for (Student *student in self.detailItem.students) {
        student.attendance = [NSNumber numberWithInt:0];
    }
    [self controllerDidChangeContent:self.fetchedResultsController];
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    barButtonItem.title = self.detailItem.name;
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

- (void)insertNewObject:(id)sender
{
    
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    
    NSManagedObjectModel *managedObjectModel =
    [[context persistentStoreCoordinator] managedObjectModel];
    NSEntityDescription *entity =
    [[managedObjectModel entitiesByName] objectForKey:@"Student"];
    Student *newStudent = [[Student alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
    
    
    
    
    
    // If appropriate, configure the new managed object.
    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
    newStudent.name = nil;
    [newStudent setStudentClass:self.detailItem];
    SEGLog(@"creating new Student");
    
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        SEGLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    [self performSegueWithIdentifier:@"Student Detail" sender:newStudent];
    [self controllerDidChangeContent:self.fetchedResultsController];
}

#pragma mark - UITableView Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SEGLog(@"index path: %@", indexPath);
    Student *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    object.attendance = @((object.attendance.intValue + 1)%3);
    [self controllerDidChangeContent:self.fetchedResultsController];
}

#pragma mark - UITableView DataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    SEGLog(@"%d sections", [[self.fetchedResultsController sections] count]);
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    SEGLog(@"%d rows in section", [sectionInfo numberOfObjects]);
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SEGStudentCell *studentCell = [tableView dequeueReusableCellWithIdentifier:@"Student Cell" forIndexPath:indexPath];
    [self configureCell:studentCell atIndexPath:indexPath];
    return studentCell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    SEGStudentCell *cell = (SEGStudentCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"will begin editing %@", cell);
    cell.studentAttendance.bounds = CGRectOffset(cell.studentAttendance.bounds, -30.0f, 0.0f);
}

- (void) tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    SEGStudentCell *cell = (SEGStudentCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    cell.studentAttendance.bounds = CGRectOffset(cell.studentAttendance.bounds, +30.0f, 0.0f);
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        SEGLog(@"deleted student");
    }
    [self.tableView reloadData];
}

- (void)configureCell:(SEGStudentCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Student *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.studentName.text = object.name;
    cell.studentAttendance.text = @"";
    if ([object.attendance intValue] == 1) { //if here
        cell.studentAttendance.text = @"Here";
        cell.studentAttendance.textColor = HERE_COLOR;
    } else if ([object.attendance intValue] == 2) {
        cell.studentAttendance.text = @"Absent";
        cell.studentAttendance.textColor = ABSENT_COLOR;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    SEGLog(@"controller did change content");
    UIBarButtonItem *absent = [self.toolbarItems objectAtIndex:1];
    [absent setTitle:[NSString stringWithFormat:@"%d Absent", [self.detailItem numAbsent]]];
    SEGLog(@"%@", absent.title);
    [self.tableView reloadData];
    
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"studentClass == %@", self.detailItem];
    fetchRequest.predicate = predicate;
    
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return _fetchedResultsController;
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Student Detail"]) {
        
        SEGLog(@"Student Detail segue... w/ sender: %@", sender);

        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];

        ((SEGStudentDetailTableViewController *)[segue destinationViewController]).student = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        if ([sender respondsToSelector:@selector(setNotes:)]) {
            ((SEGStudentDetailTableViewController *)[segue destinationViewController]).student = sender;
        }
        ((SEGStudentDetailTableViewController *)[segue destinationViewController]).managedObjectContext = self.managedObjectContext;
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    SEGStudentDetailTableViewController *sdc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([SEGStudentDetailTableViewController class])];
    sdc.student = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    sdc.managedObjectContext = self.managedObjectContext;
    [self.navigationController pushViewController:sdc animated:YES];
}

@end
