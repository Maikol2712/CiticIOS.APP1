//
//  AlumnosTableViewController.m
//  FisrtAppiOS
//
//  Created by Pablo Formoso Estada on 10/05/13.
//  Copyright (c) 2013 Softwhipser. All rights reserved.
//
#import "Alumno.h"
#import "SWCellAlumno.h"
#import "WSAlumnosXML.h"
#import "AlumnosTableViewController.h"
#import "UIImageView+AFNetworking.h"
#import "SWAlumnoDetailViewController.h"

@interface AlumnosTableViewController ()

@end

@implementation AlumnosTableViewController

@synthesize alumnos;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
#ifndef NDEBUG
    NSLog(@"[%@] %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
#endif
    
    [super viewDidLoad];
    /*
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    alumnos = [NSArray arrayWithArray:
                                [NSKeyedUnarchiver unarchiveObjectWithData:
                                 [defaults objectForKey:@"array_alumnos"]]];
    */
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    WSAlumnosXML *ws = [[WSAlumnosXML alloc] init];
    [ws getAlumnos:self];
}

// Protocolo informal
- (void)updateView:(NSArray *)result {
#ifndef NDEBUG
    NSLog(@"[%@] %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
#endif
    
    alumnos = [NSArray arrayWithArray:result];
    [self.tableView reloadData];
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [alumnos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
#ifndef NDEBUG
    NSLog(@"[%@] %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
#endif
    
    static NSString *CellIdentifier = @"Cell";
    SWCellAlumno *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                            forIndexPath:indexPath];
    
    Alumno *tmp = [alumnos objectAtIndex:indexPath.row];
    
    [cell.nameLbl setText:[NSString stringWithFormat:@"%@ %@", tmp.name, tmp.lastname]];
    [cell.emailLbl setText:tmp.email];
    [cell.cityLbl setText:tmp.city];
#ifndef NDEBUG
    NSLog(@"[%@] %@ - %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), tmp.avatarUrl.absoluteString);
#endif
    [cell.avatarImageView setImageWithURL:tmp.avatarUrl
                         placeholderImage:[UIImage imageNamed:@"first.png"]];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
#ifndef NDEBUG
    NSLog(@"[%@] %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
#endif
    
    [self performSegueWithIdentifier:@"AlumnosDetail" sender:indexPath];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
#ifndef NDEBUG
    NSLog(@"[%@] %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
#endif
    NSIndexPath *indexPath = (NSIndexPath *)sender;
    Alumno *tmp = [alumnos objectAtIndex:indexPath.row];
    
    SWAlumnoDetailViewController *tmpController = segue.destinationViewController;
    tmpController.alumno = tmp;
}








@end
