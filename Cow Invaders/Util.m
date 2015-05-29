//
//  Util.m
//  
//
//  Created by Eric Hodgins on 2015-05-28.
//
//

#import "Util.h"

@implementation Util

+(NSInteger)randomWithMin:(NSInteger)min max:(NSInteger)max {
    return arc4random() % (max - min) + min;
}

@end
