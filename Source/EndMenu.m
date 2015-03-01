//
//  EndMenu.m
//  Escaper
//
//  Created by Jiate Li on 15/2/28.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "EndMenu.h"

@implementation EndMenu{
    CCLabelTTF *_currentScore;
}
- (void)didLoadFromCCB {
    // tell this scene to accept touches
    self.userInteractionEnabled = TRUE;
    _currentScore.string = [NSString stringWithFormat:@"%d", _finalScore];
}

- (void)reset{
    CCScene *gameplayScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

- (void)menu{
    CCScene *mainScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
}
@end
