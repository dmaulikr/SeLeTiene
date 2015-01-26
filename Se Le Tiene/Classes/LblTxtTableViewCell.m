//
//  LblTxtTableViewCell.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 1/26/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

#import "LblTxtTableViewCell.h"

@implementation LblTxtTableViewCell

- (void)awakeFromNib {
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    
    self.txtLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.txtLabel.layer.cornerRadius = 5.0f;
    self.txtLabel.layer.borderWidth = 2.0f;
    self.txtLabel.leftView = paddingView;
    self.txtLabel.leftViewMode = UITextFieldViewModeAlways;
    self.txtLabel.layer.backgroundColor = [UIColor whiteColor].CGColor;
    
    self.btnLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.btnLabel.layer.cornerRadius = 5.0f;
    self.btnLabel.layer.borderWidth = 2.0f;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(int)validate{
    return 1;
}

@end
