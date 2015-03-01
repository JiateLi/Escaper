//
//  Gameplay.m
//  Escaper
//
//  Created by Jiate Li on 15/2/21.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "Gameplay.h"
#import "Grid.h"

@implementation Gameplay{
    Grid *_grid;
    CCTimer *_timer;
    CCLabelTTF *_stepLabel;
    CCLabelTTF *_timeLabel;
}

// is called when CCB file has completed loading
- (void)didLoadFromCCB {
    // tell this scene to accept touches
    self.userInteractionEnabled = TRUE;
    if (self) {
        _timer = [[CCTimer alloc] init];
    }

    //CCScene *level = [CCBReader loadAsScene:@"Levels/Level1"];
    //[_levelNode addChild:level];
    
}

- (void)menu{
    CCScene *mainScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
}

- (void)play
{
    //this tells the game to call a method called 'step' every half second.
    [self schedule:@selector(step) interval:0.5f];
    _grid.isOver = NO;
}

- (void)pause
{
    [self unschedule:@selector(step)];
    _grid.isOver = YES;
}

// this method will get called every half second when you hit the play button and will stop getting called when you hit the pause button
- (void)step
{
    [_grid evolveStep];
    _stepLabel.string = [NSString stringWithFormat:@"%d", _grid.totalCount];
    _timeLabel.string = [NSString stringWithFormat:@"%d", _grid.restStep];
    if(_grid.isOver == YES){
        [self unschedule:@selector(step)];
    }
}


// called on every touch in this scene
-(void) touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    //CGPoint touchLocation = [touch locationInNode:_contentNode];
    
}




@end
