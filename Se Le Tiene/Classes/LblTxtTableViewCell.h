//
//  LblTxtTableViewCell.h
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 1/26/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LblTxtTableViewCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UILabel *ttlLabel;
@property (nonatomic,strong) IBOutlet UITextField *txtLabel;
@property (nonatomic,strong) IBOutlet UIButton *btnLabel;

-(NSString*)getLbl;
-(int)validate;


@end
