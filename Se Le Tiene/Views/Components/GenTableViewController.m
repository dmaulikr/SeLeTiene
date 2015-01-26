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
@synthesize modeTable,APIManagerClass,data,sections;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    data =[[NSMutableArray alloc] init];
    APIManagerClass = [[APIManager alloc] init];
    APIManagerClass.delegate = self;

    
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

-(void) reload{
    sections = [[NSMutableDictionary alloc] init]; ///Global Object
    BOOL found;
    for (NSDictionary *temp in data)
    {
        NSString *c = [temp[@"name"] substringToIndex:1];
        found = NO;
        for (NSString *str in [sections allKeys])
        {
            if ([str isEqualToString:c])
            {
                found = YES;
            }
        }
        if (!found)
        {
            [sections setValue:[[NSMutableArray alloc] init] forKey:c];
        }
    }
    for (NSDictionary *temp in data)
    {
        [[sections objectForKey:[temp[@"name"] substringToIndex:1]] addObject:temp];
    }
  //  [self.tableView reloadData];
    
    [(UITableView*)self.view reloadData];

}


-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[sections allKeys]count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return [data count];
    return [[sections valueForKey:[[[sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GenCell" forIndexPath:indexPath];
//    cell.textLabel.text = ((NSDictionary*)[data objectAtIndex:indexPath.row])[@"name"];
    cell.textLabel.text = ([[sections valueForKey:[[[sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row])[@"name"];
    return cell;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return[NSArray arrayWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
}



#pragma APIMANAGER

- (void) returnList:(id)responseObject :(NSString*)url
{
    NSLog(@"Retorno una lista %@", responseObject);
    for (id key in (NSDictionary*)responseObject) {
        NSDictionary *tmpObj = @{
                                    @"id":key[@"id"],
                                    @"name":key[@"name"]
                                };
        [data addObject:tmpObj];
    }
    [self reload];
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
