//
//  TitleScene.m
//  Cow Invaders
//
//  Created by Eric Hodgins on 2015-05-23.
//  Copyright (c) 2015 Eric Hodgins. All rights reserved.
//

#import "TitleScene.h"
#import "GamePlayScene.h"

@implementation TitleScene

-(instancetype)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        // Setup the scene
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"StartScene"];
        background.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
        [self addChild:background];
        
    }
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    GamePlayScene *gamePlayScene = [GamePlayScene sceneWithSize:self.frame.size];
    SKTransition *transition = [SKTransition fadeWithDuration:2.0];
    [self.view presentScene:gamePlayScene transition:transition];
}

@end
