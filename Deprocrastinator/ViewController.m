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
@property BOOL editing;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.things = [NSMutableArray arrayWithObjects:@"thing 1", @"thing 2", nil ];
    self.editing = NO;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.things.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId"];
    cell.textLabel.text = [self.things objectAtIndex:indexPath.row];
    
    return cell;
}

- (IBAction)onAddButtonPressed:(UIBarButtonItem *)sender {
    
    if (![self.textField.text isEqualToString:@"" ]) {
        [self.things addObject:self.textField.text];
        [self.tableView reloadData];
        self.textField.text = @"" ;
        [self.textField resignFirstResponder];
    }
    
}
- (IBAction)onEditButtonPressed:(UIBarButtonItem *)sender {
    
    if (self.editing == YES) {
        sender.title = @"Edit";
        self.editing = NO;
    }
    else {
        sender.title = @"Done";
        self.editing = YES;
    }
    
    
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.things removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
    }
    
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@" %ld", (long)indexPath.row);
    if (self.editing == YES) {
        [self.things removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
    }
    else {
        [tableView cellForRowAtIndexPath:indexPath].textLabel.textColor = [UIColor greenColor];
   
    }
        
}



@end
