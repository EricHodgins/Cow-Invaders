//
//  GamePlayScene.m
//  Cow Invaders
//
//  Created by Eric Hodgins on 2015-05-23.
//  Copyright (c) 2015 Eric Hodgins. All rights reserved.
//

#import "GamePlayScene.h"

@implementation GamePlayScene
{
    float standingPosition;
    float farmerSpeed;
}


-(instancetype)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        // Setup the scene
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"GamePlayBackground"];
        background.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
        [self addChild:background];
        
        self.alien = [SKSpriteNode spriteNodeWithImageNamed:@"Alien_1"];
        self.alien.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:self.alien];
        [self setupAnimation];
        
        self.farmer = [SKSpriteNode spriteNodeWithImageNamed:@"Farmer_1"];
        self.farmer.position = CGPointMake(10, 60);
        self.farmer.anchorPoint = CGPointMake(0.5, 0.5);
        standingPosition = self.farmer.position.x;
        farmerSpeed = 100;
        [self addChild: self.farmer];
        
        
    }
    
    return self;
}

-(void)setupAnimation {
    NSArray *textures = @[[SKTexture textureWithImageNamed:@"Alien_1"],
                          [SKTexture textureWithImageNamed:@"Alien_2"],
                          [SKTexture textureWithImageNamed:@"Alien_3"],
                          [SKTexture textureWithImageNamed:@"Alien_3"]];
    SKAction *animation = [SKAction animateWithTextures:textures timePerFrame:0.2];
    SKAction *repeatAction = [SKAction repeatActionForever:animation];
    [self.alien runAction:repeatAction];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        float distance;
        float time;
        CGPoint location = [touch locationInNode:self];
        distance = fabs(self.farmer.position.x - location.x);
        time = distance / farmerSpeed;
        SKAction *moveFarmer = [SKAction moveTo:CGPointMake(location.x, self.farmer.position.y) duration:time];
        [self.farmer runAction:moveFarmer];
    }
    

}

-(void)update:(NSTimeInterval)currentTime {
    //NSLog(@"%f", fmod(currentTime, 60));
}


@end
