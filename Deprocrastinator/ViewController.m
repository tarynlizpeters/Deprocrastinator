//
//  ViewController.m
//  Deprocrastinator
//
//  Created by Taryn Parker on 1/18/16.
//  Copyright © 2016 Mobile Makers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *things;
@property NSMutableArray *colors;
@property BOOL editing;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.things = [NSMutableArray arrayWithObjects:@"Task 1", @"Task 2", nil];
    self.colors = [NSMutableArray arrayWithObjects:[UIColor blackColor],[UIColor blackColor], nil];
    self.editing = NO;
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.things.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId"];
    cell.textLabel.text = [self.things objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [self.colors objectAtIndex:indexPath.row];
    return cell;
    
}

- (IBAction)onAddButtonPressed:(UIBarButtonItem *)sender {
    
    if (![self.textField.text isEqualToString:@"" ]) {
        [self.things addObject:self.textField.text];
        [self.tableView reloadData];
        self.textField.text = @"";
        [self.textField resignFirstResponder];
        [self.colors addObject:[UIColor blackColor]];

    }
    
}
- (IBAction)onEditButtonPressed:(UIBarButtonItem *)sender {
    
    if (self.editing == YES) {
        sender.title = @"Edit";
        self.editing = NO;
        [self.tableView setEditing:NO animated:YES];
    }
    else {
        sender.title = @"Done";
        self.editing = YES;
        [self.tableView setEditing:YES animated:YES];

    }
    
    
}

- (IBAction)onSwipeRight:(UISwipeGestureRecognizer *)sender {
    //setting swipe parameters
    
    CGPoint point = [sender locationInView:self.tableView];
    NSLog(@"%f",point.x);
    NSIndexPath *swipedRow = [self.tableView indexPathForRowAtPoint:point];
    
    //changing colors on swipe
    
    if ([self.tableView cellForRowAtIndexPath:swipedRow].textLabel.textColor == [UIColor blackColor]) {
        
        [self.colors replaceObjectAtIndex:swipedRow.row withObject:[UIColor redColor]];
        [self.tableView cellForRowAtIndexPath:swipedRow].textLabel.textColor = [UIColor redColor];
    
    } else  if ([self.tableView cellForRowAtIndexPath:swipedRow].textLabel.textColor == [UIColor redColor]){
        
        [self.tableView cellForRowAtIndexPath:swipedRow].textLabel.textColor = [UIColor yellowColor];
        [self.colors replaceObjectAtIndex:swipedRow.row withObject:[UIColor yellowColor]];
        
    } else  if ([self.tableView cellForRowAtIndexPath:swipedRow].textLabel.textColor == [UIColor yellowColor]){
        
        [self.tableView cellForRowAtIndexPath:swipedRow].textLabel.textColor = [UIColor greenColor];
        [self.colors replaceObjectAtIndex:swipedRow.row withObject:[UIColor greenColor]];
        
    } else {
        [self.tableView cellForRowAtIndexPath:swipedRow].textLabel.textColor = [UIColor blackColor];
        [self.colors replaceObjectAtIndex:swipedRow.row withObject:[UIColor blackColor]];
    }


}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //when does it show the delete button?
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Are you sure?"
                                                                       message:@"This cannot be undone"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    [self.things removeObjectAtIndex:indexPath.row];
            //add colors or else the next one stays green
                    [tableView reloadData];
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];

        [self presentViewController:alert animated:YES completion:nil];
    }
    
    
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES; //this says we can edit the cells - tableview asks the view controller
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //called when a user selects a row and it pulls the row. here we are changing it to green
    NSLog(@" %ld", (long)indexPath.row);
    if (self.editing == YES) {
        [self.things removeObjectAtIndex:indexPath.row];
        [self.colors removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
    }
    else {
        [tableView cellForRowAtIndexPath:indexPath].textLabel.textColor = [UIColor greenColor];
        [self.colors replaceObjectAtIndex:indexPath.row withObject:[UIColor greenColor]];
   
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES; //allows the rows to be moved around

    
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSString *moveObject = [self.things objectAtIndex:sourceIndexPath.row];
    [self.things removeObjectAtIndex:sourceIndexPath.row];
    [self.things insertObject:moveObject atIndex:destinationIndexPath.row];
    
}



@end
