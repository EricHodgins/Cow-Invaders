//
//  Farmer.m
//  Cow Invaders
//
//  Created by Eric Hodgins on 2015-05-23.
//  Copyright (c) 2015 Eric Hodgins. All rights reserved.
//

#import "Farmer.h"

@implementation Farmer
{
    float farmerSpeed;
}

+ (instancetype)farmerAtPosition:(CGPoint)position {
    
    Farmer *farmer = [Farmer spriteNodeWithImageNamed:@"Farmer_1"];
    farmer.position = position;
    farmer.anchorPoint = CGPointMake(0.5, 0.5);
    farmer.name = @"Farmer";
    farmer.zPosition = 2;
    
    return farmer;
    
}



@end
