//
//  Filter.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/14/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import "Filter.h"

@implementation Filter

-(id)init{
    self = [super init];
    if (self) {
        typeFil = 0;
        cityId = 0;
        cityName = @"";
        keyWord = @"";
        stars = 0;
    }
    return self;
}


//Getters
-(int)getTypeFil{
    return typeFil;
}
-(int)getCityId{
    return cityId;
}
-(NSString*)getCityName{
    return cityName;
}
-(NSString*)getKeyWord{
    return keyWord;
}
-(int)getStars{
    return stars;
}

//Setters
-(void)setTypeFil:(int)typeFilN{
    typeFil = typeFilN;
}
-(void)setCityId:(int)cityIdN{
    cityId = cityIdN;
}
-(void)setCityName:(NSString*)cityNameN{
    cityName = cityNameN;
}
-(void)setKeyWord:(NSString*)keyWordN{
    keyWord = keyWordN;
}
-(void)setStars:(int)starsN{
    stars = starsN;
}


-(void)setFilter{
    NSString *filter = @"";
    if ([keyWord isEqualToString:@""]&&stars==0) {
        
    }else{
    
        
        if (![keyWord isEqualToString:@""]) {
            filter = [NSString stringWithFormat:@"q=%@",keyWord];
        }

        if (stars>0&&![filter isEqualToString:@""]) {
            filter = [NSString stringWithFormat:@"%@&minStars=%d",filter,stars];
        }else{
            if (stars>0) {
                filter = [NSString stringWithFormat:@"minStars=%d",stars];
            }
        }
        
        
        if(typeFil==0&&![filter isEqualToString:@""]){
            filter = [NSString stringWithFormat:@"%@&type=product",filter];
        }else{
            if(typeFil==0){
                filter = [NSString stringWithFormat:@"type=product"];
            }if(typeFil==1&&![filter isEqualToString:@""]){
                filter = [NSString stringWithFormat:@"%@&type=service",filter];
            }else{
                if(typeFil==0){
                    filter = [NSString stringWithFormat:@"type=service"];
                }
            }
        }
    }
    filterStr = [NSString stringWithFormat:@"%@",filter];
    
    NSLog(@"Filter actualizado %@", filterStr);
}


@end
