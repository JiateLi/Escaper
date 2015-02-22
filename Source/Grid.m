//
//  Grid.m
//  Escaper
//
//  Created by Jiate Li on 15/2/21.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "Grid.h"
#import "Creature.h"
static const int GRID_ROWS = 8;
static const int GRID_COLUMNS = 10;

@implementation Grid {
    NSMutableArray *_gridArray;
    float _cellWidth;
    float _cellHeight;
    int _timeCount;
    CCNode *_actor;
}

- (void)onEnter
{
    [super onEnter];
    //[self onEnter];
    [self setupGrid];
    //self.userInteractionEnabled
}

- (void)setupGrid
{
    _timeCount = 0;
    _cellWidth = self.contentSize.width / GRID_COLUMNS;
    _cellHeight = self.contentSize.height / GRID_ROWS;
    
    NSLog(@"cellHeight = %f",_cellHeight);
    NSLog(@"cellWidth = %f",_cellWidth);
    float x = 0;
    float y = 0;
    
    _gridArray = [NSMutableArray array];
    
    for (int i = 0; i < GRID_ROWS; i++) {
        _gridArray[i] = [NSMutableArray array];
        
        x = 0;
        for (int j = 0; j < GRID_COLUMNS; j++) {
            Creature *creature = [[Creature alloc] initCreature];
            creature.anchorPoint = ccp(0, 0);
            creature.position = ccp(x, y);
            [self addChild:creature];
            _gridArray[i][j] = creature;
            
            x+=_cellWidth;
        }
        
        y += _cellHeight;
    }
    _actor.position = ccp(20,288);
}

- (void)evolveStep
{
    _timeCount++;
    if(_timeCount == 1){
        [self updateCreatures];
    }
    else if(_timeCount == 2){
        [self closeCreatures];
    }
    
    if(_timeCount == 6){
        [self checkIfDeadOrSucceed];
        _timeCount = 0;
    }
}

- (void)updateCreatures
{
    for (int i = 0; i < [_gridArray count]; i++)
    {
        for (int j = 0; j < [_gridArray[i] count]; j++)
        {
            Creature *currentCreature = _gridArray[i][j];
            currentCreature.isAlive = NO;
            [currentCreature setIsVisible:NO];
            int random = [self getRandomNumberBetweenMin:0 andMax:100];
            //NSLog(@"random = %i",random);
            if(random < 15){
                currentCreature.isAlive = YES;
                [currentCreature setIsVisible:YES];
            }
        }
    }
}

- (int) getRandomNumberBetweenMin:(int)min andMax:(int)max

{
    return ( (arc4random() % (max-min+1)) + min );
}

- (void)closeCreatures
{
    for (int i = 0; i < [_gridArray count]; i++)
    {
        for (int j = 0; j < [_gridArray[i] count]; j++)
        {
            Creature *currentCreature = _gridArray[i][j];
            [currentCreature setIsVisible:NO];
        }
    }
}

- (void)checkIfDeadOrSucceed
{
    //NSLog(@"X location is = %f",_actor.position.x);
    //NSLog(@"Y location is = %f",_actor.position.y);
    for (int i = 0; i < [_gridArray count]; i++)
    {
        for (int j = 0; j < [_gridArray[i] count]; j++)
        {
            Creature *currentCreature = _gridArray[i][j];
            if(currentCreature.isAlive == YES && _actor.position.x >= j * _cellWidth && _actor.position.x <= (j+1) * _cellWidth
               && _actor.position.y >= i * _cellHeight && _actor.position.y <= (i+1) * _cellHeight){
                NSLog(@"Over");
            }
        }
    }
}

@end

