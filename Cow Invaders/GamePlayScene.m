//
//  GamePlayScene.m
//  Cow Invaders
//
//  Created by Eric Hodgins on 2015-05-23.
//  Copyright (c) 2015 Eric Hodgins. All rights reserved.
//

#import "GamePlayScene.h"
#import "AlienNode.h"
#import "Farmer.h"
#import "ProjectileNode.h"
#import "GroundNode.h"
#import "Util.h"

@implementation GamePlayScene {
    float frameWidth;
}

-(void)didMoveToView:(SKView *)view {
    NSLog(@"move to view");
    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapsResponder:)];
    doubleTapRecognizer.numberOfTapsRequired = 2;
    doubleTapRecognizer.numberOfTouchesRequired = 1;
    
    [self.scene.view addGestureRecognizer:doubleTapRecognizer];
    
}

-(instancetype)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        NSLog(@"setup scene");
        // Setup the scene
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"GamePlayBackground"];
        background.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
        [self addChild:background];
        
        
        AlienNode *alien = [AlienNode alienAtPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))];
        [self addChild: alien];
        
        Farmer *farmer = [Farmer farmerAtPosition:CGPointMake(10, 60)];
        [self addChild: farmer];
        
        frameWidth = self.frame.size.width;
        self.physicsWorld.gravity = CGVectorMake(0, -3);
        self.physicsWorld.contactDelegate = self;
        
        GroundNode *ground = [GroundNode groundWithSize:CGSizeMake(frameWidth, 22)];
        [self addChild:ground];
        
    }
    
    return self;
}

-(void)tapsResponder: (UITapGestureRecognizer *)sender {
    if (sender.numberOfTapsRequired == 2) {
        NSLog(@"Two taps pushed");
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.farmerTouch = [touches anyObject];
    
    for (UITouch *touch in touches) {
        CGPoint position = [touch locationInNode:self];
        if (position.y >= 80) {
            [self shootProjectileTowardsPosition: position];
        }
    }
}


-(void)update:(NSTimeInterval)currentTime {

    if (self.lastUpdateTime == 0) {
        self.lastUpdateTime = currentTime;
    }
    
    NSTimeInterval timeDelta = currentTime - self.lastUpdateTime;
    
    if (self.farmerTouch) {
        [self moveFarmerTowardsPosition:[self.farmerTouch locationInNode:self] byTimeDelta:timeDelta];
    }
    
    self.lastUpdateTime = currentTime;
    
}

-(void)moveFarmerTowardsPosition:(CGPoint)position byTimeDelta:(NSTimeInterval)timeDelta {
    Farmer *farmer = (Farmer *)[self childNodeWithName:@"Farmer"];
    
    CGFloat distanceLeft = fabs(position.x - farmer.position.x);
    CGFloat distanceToTravel = timeDelta * FarmerSpeed;
    CGFloat xOffset;

    if (position.y < 80) {
        if (farmer.position.x >= position.x && distanceLeft > 4) {
            xOffset = farmer.position.x - distanceToTravel;
            farmer.position = CGPointMake(xOffset, farmer.position.y);
        } else if (farmer.position.x < position.x && distanceLeft > 4) {
            xOffset = farmer.position.x + distanceToTravel;
            farmer.position = CGPointMake(xOffset, farmer.position.y);
        }
    }

}

-(void)shootProjectileTowardsPosition:(CGPoint)position {
    
    Farmer *farmer = (Farmer *)[self childNodeWithName:@"Farmer"];
    
    ProjectileNode *projectile = [ProjectileNode projectileAtPosition:CGPointMake(farmer.position.x + 20, farmer.position.y + 10)];
    [projectile moveTowardsPosition:position frameWidth:frameWidth];
    [self addChild:projectile];
}


-(void)didBeginContact:(SKPhysicsContact *)contact {
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    } else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    if (firstBody.categoryBitMask == CollisionCategoryEnemy && secondBody.categoryBitMask == CollisionCategoryProjectile) {
        NSLog(@"Bam");
        AlienNode *alien = (AlienNode *)firstBody.node;
        ProjectileNode *projectile = (ProjectileNode *)secondBody.node;
        [alien removeFromParent];
        [projectile removeFromParent];
        
        [self createDebrisAtPosition:contact.contactPoint];
        
    } else if (firstBody.categoryBitMask == CollisionCategoryEnemy && secondBody.categoryBitMask == CollisionCategoryGround) {
        NSLog(@"Hit ground");
    }
}

-(void)createDebrisAtPosition:(CGPoint)position {
    NSInteger numberOfPieces = [Util randomWithMin:5 max:20];

    for (int i=0; i < numberOfPieces; i++) {
        NSInteger randomPiece = [Util randomWithMin:1 max:5];
        NSString *imageName = [NSString stringWithFormat:@"Debris_%d", randomPiece];
        
        SKSpriteNode *debris = [SKSpriteNode spriteNodeWithImageNamed:imageName];
        debris.position = position;
        [self addChild:debris];
        
        debris.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:debris.frame.size];
        debris.physicsBody.categoryBitMask = CollisionCategoryDebris;
        debris.physicsBody.contactTestBitMask = 0;
        debris.physicsBody.collisionBitMask = CollisionCategoryGround | CollisionCategoryDebris;
        debris.name = @"Debris";
        
        debris.physicsBody.velocity = CGVectorMake([Util randomWithMin:-150 max:150], [Util randomWithMin:150 max:350]);
        [debris runAction:[SKAction waitForDuration:3.0] completion:^{
            [debris removeFromParent];
        }];
    }
}


@end
