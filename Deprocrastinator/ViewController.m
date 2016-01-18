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
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.things = [[NSMutableArray alloc]init];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@" %ld", (long)indexPath.row);
    [tableView cellForRowAtIndexPath:indexPath].textLabel.textColor = [UIColor greenColor];
    
}



@end
