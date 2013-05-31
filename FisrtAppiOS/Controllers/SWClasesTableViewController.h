//
//  SWClasesViewController.h
//  FisrtAppiOS
//
//  Created by Pablo Formoso Estada on 23/05/13.
//  Copyright (c) 2013 Softwhipser. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWClasesTableViewController : UITableViewController

@property (nonatomic, retain) NSMutableArray *clases;
- (IBAction)editMode:(id)sender;

@end
