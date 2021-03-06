//
//  LevelMenuScene.m
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LevelMenuScene.h"
#import "LevelEditorScene.h"
#import "MainMenuScene.h"
#import "GameScene.h"

@implementation LevelMenuScene
@synthesize pauseLabel;
@synthesize menu;
@synthesize lesUpper;

- (id)initWithLevelEditorScene:(LevelEditorScene *)les{
    self = [super init];
    if(self){
        self.lesUpper = les;
        
        self.pauseLabel = [[CCLabelTTF alloc] initWithString:@"Pause" fontName:@"Krungthep" fontSize:36.0f];
        [pauseLabel setPosition: ccp(240, 260)];
        [self addChild: pauseLabel];
        
        CCLabelTTF *returnToEditor = [[CCLabelTTF alloc] initWithString:@"Return to Editor" fontName:@"Krungthep" fontSize:32];
        CCMenuItemLabel *returnToEditorLabel = [[CCMenuItemLabel alloc] initWithLabel:returnToEditor target:self selector:@selector(returnToEditor)];
        
        CCLabelTTF *saveLevel = [[CCLabelTTF alloc] initWithString:@"Save Level" fontName:@"Krungthep" fontSize:32];
        CCMenuItemLabel *saveLevelLabel = [[CCMenuItemLabel alloc] initWithLabel:saveLevel target:self selector:@selector(saveLevel)];
        [saveLevelLabel setPosition: ccp(0, -40)];
        
        CCLabelTTF *testLevel = [[CCLabelTTF alloc] initWithString:@"Test Level" fontName:@"Krungthep" fontSize:32];
        CCMenuItemLabel *testLevelLabel = [[CCMenuItemLabel alloc] initWithLabel:testLevel target:self selector:@selector(testLevel)];
        [testLevelLabel setPosition: ccp(0, -80)];
        
        CCLabelTTF *exitGame = [[CCLabelTTF alloc] initWithString:@"Exit Editor" fontName:@"Krungthep" fontSize:32];
        CCMenuItemLabel *exitGameLabel = [[CCMenuItemLabel alloc] initWithLabel:exitGame target:self selector:@selector(exitGame)];
        [exitGameLabel setPosition: ccp(0, -120)];
        
        self.menu = [CCMenu menuWithItems:returnToEditorLabel, saveLevelLabel, testLevelLabel, exitGameLabel, nil];
        [self addChild: menu];
        
        [returnToEditor release];
        [returnToEditorLabel release];
        [exitGame release];
        [exitGameLabel release];
        [testLevel release];
        [testLevelLabel release];
    }
    return self;
}

- (void)onEnter{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    [super onEnter];
}

- (void)returnToEditor{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    [[CCDirector sharedDirector] popSceneWithTransition:[CCTransitionFade class] duration:0.5f];
}

- (void)saveLevel{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    [lesUpper promptSave];
}

- (void)testLevel{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    GameScene *gs = [[GameScene alloc] initWithLevel:[lesUpper currentMap] custom:YES testingLevel:YES];
    [[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:0.5f scene:gs]];
    [gs release];
}

- (void)exitGame{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    [[CCDirector sharedDirector] popScene]; // Back to LES
    [[CCDirector sharedDirector] popScene]; // Back to CLS
    [[CCDirector sharedDirector] popSceneWithTransition:[CCTransitionFade class] duration:0.5f]; // Back to MMS
}

@end
