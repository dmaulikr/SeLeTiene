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
    switch (modeTable) {
        case 1:
            self.title = @"Departamento";
            [APIManagerClass getDepartments];
        break;
        case 2:
            self.title = @"Tipo Producto";
        break;
        case 3:
            self.title =@"Tipo Servicio";
        break;
        case 4:
            self.title = @"Ciudad";
            [APIManagerClass getCities:[NSString stringWithFormat:@"%@",depto[@"id"]].intValue];
        break;
        default: break;
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
    cell.tag = [NSString stringWithFormat:@"%@", ([[sections valueForKey:[[[sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row])[@"id"]].intValue;
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
    NSDictionary *response = responseObject;
    if (modeTable==4) {
        response = response[@"cities"];
    }
    
    for (id key in response) {
        NSDictionary *tmpObj = @{
                                    @"id":key[@"id"],
                                    @"name":key[@"name"]
                                };
        [data addObject:tmpObj];
    }
    [self reload];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (modeTable == 1) {
        UITableViewCell *a = [self.tableView cellForRowAtIndexPath:indexPath];
        depto = @{
             @"id":[NSString stringWithFormat:@"%d",a.tag],
             @"name":a.textLabel.text
             };
    }
    if (modeTable == 4) {
        UITableViewCell *a = [self.tableView cellForRowAtIndexPath:indexPath];
        city = @{
                  @"id":[NSString stringWithFormat:@"%d",a.tag],
                  @"name":a.textLabel.text
                  };
    }
    if (modeTable == 1 || modeTable == 4) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
