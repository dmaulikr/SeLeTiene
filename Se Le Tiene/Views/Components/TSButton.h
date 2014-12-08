//
//  TSButton.h
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/14/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import <UIKit/UIKit.h>




@class TSButton;

@protocol TSButtonDelegate <NSObject>
@optional
- (void) changeState:(BOOL)value;
@end

@interface TSButton : UIButton{
    BOOL val;
}
@property (nonatomic, weak) id <TSButtonDelegate> delegate;
-(void)setState:(BOOL)stateBtn;


@end
