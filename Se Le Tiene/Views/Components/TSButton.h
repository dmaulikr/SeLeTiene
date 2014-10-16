//
//  TSButton.h
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/14/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSButton : UIButton{
    BOOL val;
}
-(void)setState:(BOOL)stateBtn;

@end
