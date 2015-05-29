//
//  Util.h
//  
//
//  Created by Eric Hodgins on 2015-05-28.
//
//

#import <Foundation/Foundation.h>

static const int FarmerSpeed = 100;

typedef NS_OPTIONS(uint32_t, CollisionCategory) {
    CollisionCategoryEnemy      = 1 << 0,
    CollisionCategoryProjectile = 1 << 1,
    CollisionCategoryGround     = 1 << 2,
    CollisionCategoryDebris     = 1 << 3
};

@interface Util : NSObject

+(NSInteger) randomWithMin:(NSInteger)min max:(NSInteger)max;

@end
