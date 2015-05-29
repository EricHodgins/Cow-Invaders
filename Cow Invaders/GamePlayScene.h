//
//  GamePlayScene.h
//  Cow Invaders
//
//  Created by Eric Hodgins on 2015-05-23.
//  Copyright (c) 2015 Eric Hodgins. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GamePlayScene : SKScene <SKPhysicsContactDelegate>

@property (nonatomic, weak) UITouch *farmerTouch;
@property (nonatomic) NSTimeInterval lastUpdateTime;

@end
