//
//  ProjectileNode.m
//  
//
//  Created by Eric Hodgins on 2015-05-25.
//
//

#import "ProjectileNode.h"
#import "Util.h"

@implementation ProjectileNode

+(instancetype)projectileAtPosition:(CGPoint)position {
    ProjectileNode *projectile = [self spriteNodeWithImageNamed:@"Projectile"];
    projectile.position = position;
    projectile.name = @"Projectile";
    [projectile setupPhysicsBody];
    
    return projectile;
}

-(void)moveTowardsPosition:(CGPoint)position frameWidth:(float)frameWidth {
    float slope = (position.y - self.position.y) / (position.x - self.position.x);
    float offScreenX;
    if (position.x <= self.position.x) {
        offScreenX = -10;
    } else {
        offScreenX = frameWidth + 10;
    }
    
    float offScreenY = (slope * offScreenX) - (slope * self.position.x) + self.position.y;
    
    CGPoint pointOffScreen = CGPointMake(offScreenX, offScreenY);
    
    float distanceA = pointOffScreen.y - self.position.y;
    float distanceB = pointOffScreen.x - self.position.x;
    float distanceC = sqrtf(powf(distanceA, 2) + powf(distanceB, 2));
    
    float time = distanceC / 100;
    
    SKAction *moveProjectile = [SKAction moveTo:pointOffScreen duration:time];
    [self runAction:moveProjectile];
    
}

-(void)setupPhysicsBody {
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.categoryBitMask = CollisionCategoryProjectile;
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.contactTestBitMask = CollisionCategoryEnemy;
}

@end
