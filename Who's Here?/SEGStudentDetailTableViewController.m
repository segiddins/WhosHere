//
//  SEGStudentDetailTableViewController.m
//  Who's Here?
//
//  Created by Samuel E. Giddins on 1/12/13.
//  Copyright (c) 2013 Samuel E. Giddins. All rights reserved.
//

#import "SEGStudentDetailTableViewController.h"
#import "StudentClass.h"

@interface SEGStudentDetailTableViewController ()

@end

@implementation SEGStudentDetailTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (nil == self.student.name) {
        UIAlertView *nameView = [[UIAlertView alloc] initWithTitle:@"New Student!" message:@"Please enter the new student's name" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Done", nil];
        [nameView setAlertViewStyle:UIAlertViewStylePlainTextInput];
        [nameView show];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    GAI_REPORT_SCREEN(@"Individual Student");
    self.navigationController.toolbarHidden = YES;
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        self.student.name = [alertView textFieldAtIndex:0].text;
        [self saveStudent];
        [self.tableView reloadData];
    }
    self.navigationItem.title = self.student.name;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return (section == 0) ? 3 : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    // Configure the cell...
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            self.studentNameField = [[UITextField alloc] init];
            NSLog(@"%f,%f,%f,%f", cell.bounds.origin.x, cell.bounds.origin.y, cell.bounds.size.width, cell.bounds.size.height);
            self.studentNameField.text = self.student.name;
            [cell addSubview:self.studentNameField];
            self.studentNameField.frame = CGRectMake(20, 10, cell.bounds.size.width - 50, cell.bounds.size.height - 15);
        } else if (indexPath.row == 1) {
            cell.textLabel.text = _student.studentClass.name;
        } else if (indexPath.row == 2) {
            UITextView *textView = self.notesView;
            textView.text = self.student.notes;
        }
    }
}

- (void)backPressed
{
    UITextView *textView = self.notesView;
    if (!self.student.isDeleted) {
        self.student.notes = textView.text;
        self.student.name = self.studentNameField.text;
        self.navigationItem.title = self.student.name;
    }
    [self saveStudent];
}

- (void)saveStudent
{
    // Save the context.
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self backPressed];
    [super viewWillDisappear:animated];
}

- (IBAction)removeStudent:(id)sender {
    NSLog(@"removing student");
    [self.managedObjectContext deleteObject:self.student];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
