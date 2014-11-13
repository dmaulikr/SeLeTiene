//
//  GenTableViewController.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/14/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import "GenTableViewController.h"

@interface GenTableViewController ()

@end

@implementation GenTableViewController
@synthesize modeTable,APIManagerClass,data;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (modeTable==1) {
        self.title = @"Ciudad";
        [APIManagerClass getCities];
    }else{
        if (modeTable==2) {
            self.title = @"Tipo Producto";
        }else{
            if (modeTable==3) {
                self.title =@"Tipo Servicio";
            }
        }
    }
    
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GenCell" forIndexPath:indexPath];
    cell.textLabel.text = [((NSDictionary*)[data objectAtIndex:indexPath.row]) valueForKey:@"name"];
    return cell;
}



#pragma APIMANAGER

-(void) returnList:(id)responseObject
{
    NSLog(@"Retorno una lista");
    for (id key in (NSDictionary*)responseObject) {
        NSDictionary *tmpObj = @{
                                    @"id":key[@"id"],
                                    @"name":key[@"name"]
                                };
        [data addObject:tmpObj];
    }
    [(UITableView*)self.view reloadData];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
