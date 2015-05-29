//
//  ProjectileNode.h
//  
//
//  Created by Eric Hodgins on 2015-05-25.
//
//

#import <SpriteKit/SpriteKit.h>

@interface ProjectileNode : SKSpriteNode

+ (instancetype)projectileAtPosition:(CGPoint)position;
-(void)moveTowardsPosition:(CGPoint)position frameWidth:(float)frameWidth;

@end
