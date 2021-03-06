//
//  PauseScene.m
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PauseScene.h"
#import "MainMenuScene.h"
#import "GameScene.h"
#import "OptionsScene.h"

@implementation PauseScene
@synthesize pauseLabel;
@synthesize menu;
@synthesize gsUpper;

- (id)initWithGameScene:(GameScene *)gs{
    self = [super init];
    if(self){
        self.gsUpper = gs;
        
        self.pauseLabel = [[CCLabelTTF alloc] initWithString:@"Pause" fontName:@"Krungthep" fontSize:36.0f];
        [pauseLabel setPosition: ccp(240, 260)];
        [self addChild: pauseLabel];
        
        CCLabelTTF *returnToGame = [[CCLabelTTF alloc] initWithString:@"Return to Game" fontName:@"Krungthep" fontSize:32];
        CCMenuItemLabel *returnToGameLabel = [[CCMenuItemLabel alloc] initWithLabel:returnToGame target:self selector:@selector(returnToGame)];
        
        CCLabelTTF *restart = [[CCLabelTTF alloc] initWithString:@"Restart Level" fontName:@"Krungthep" fontSize:32];
        CCMenuItemLabel *restartLabel = [[CCMenuItemLabel alloc] initWithLabel:restart target:self selector:@selector(restartLevel)];
        [restartLabel setPosition: ccp(0, -40)];
        
        /*CCLabelTTF *options = [[CCLabelTTF alloc] initWithString:@"Options" fontName:@"Krungthep" fontSize:32];
        CCMenuItemLabel *optionsLabel = [[CCMenuItemLabel alloc] initWithLabel:options target:self selector:@selector(options)];
        [optionsLabel setPosition: ccp(0, -80)];*/
        
        CCLabelTTF *exitGame;
        
        if(gsUpper.testingLevel){
            exitGame = [[CCLabelTTF alloc] initWithString:@"Back to Editor" fontName:@"Krungthep" fontSize:32];
        }else{
            exitGame = [[CCLabelTTF alloc] initWithString:@"Exit Game" fontName:@"Krungthep" fontSize:32];
        }
        
        CCMenuItemLabel *exitGameLabel = [[CCMenuItemLabel alloc] initWithLabel:exitGame target:self selector:@selector(exitGame)];
        [exitGameLabel setPosition: ccp(0, -80)];
        
        self.menu = [CCMenu menuWithItems:returnToGameLabel, restartLabel, exitGameLabel, nil];
        [self addChild: menu];
        
        [returnToGame release];
        [returnToGameLabel release];
        [exitGame release];
        [exitGameLabel release];
        
        CCLabelTTF *warningLabel = [[CCLabelTTF alloc] initWithString:@"Warning: Clock is still running." fontName:@"Krungthep" fontSize:18.0f];
        [warningLabel setColor:ccc3(200, 200, 200)];
        [warningLabel setPosition: ccp(240.0f, 25.0f)];
        [self addChild: warningLabel];
        
    }
    return self;
}

- (void)onEnter{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    [super onEnter];
}

- (void)returnToGame{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    [[CCDirector sharedDirector] popSceneWithTransition:[CCTransitionFade class] duration:0.5f];
}

- (void)restartLevel{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    NSString *currentLevel = [gsUpper currentLevel];
    BOOL currentCustom = [gsUpper currentCustom];
    BOOL currentTesting = [gsUpper testingLevel];
    
    [[CCDirector sharedDirector] popScene];
    GameScene *gs = [[GameScene alloc] initWithLevel: currentLevel custom:currentCustom testingLevel:currentTesting];
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration:0.5f scene:gs]];
    [gs release];
}

- (void)exitGame{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    if(gsUpper.testingLevel){
        [[CCDirector sharedDirector] popScene]; // Back to GameScene
        [[CCDirector sharedDirector] popScene]; // Back to LMS
        [[CCDirector sharedDirector] popSceneWithTransition:[CCTransitionFade class] duration:0.5f]; // Back to LES
    }else{
        [[CCDirector sharedDirector] popScene]; // Back to GameScene
        [[CCDirector sharedDirector] popScene]; // Back to CLS
        [[CCDirector sharedDirector] popSceneWithTransition:[CCTransitionFade class] duration:0.5f]; // Back to MMS

    }
}
@end
