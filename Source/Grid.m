//
//  Grid.m
//  Escaper
//
//  Created by Jiate Li on 15/2/21.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "Grid.h"
#import "Creature.h"
#import "EndMenu.h"
static const int GRID_ROWS = 8;
static const int GRID_COLUMNS = 10;

@implementation Grid {
    NSMutableArray *_gridArray;
    float _cellWidth;
    float _cellHeight;
    int _timeCount;
    //int _totalCount;
    CCNode *_actor;
}

- (void)onEnter {
    [super onEnter];
    //[self onEnter];
    [self setupGrid];
    //self.userInteractionEnabled
    UISwipeGestureRecognizer *swipeLeft= [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeLeft)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [[[CCDirector sharedDirector]view]addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight= [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeRight)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [[[CCDirector sharedDirector]view]addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer *swipeUp= [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeUp)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [[[CCDirector sharedDirector]view]addGestureRecognizer:swipeUp];
    
    UISwipeGestureRecognizer *swipeDown= [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeDown)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [[[CCDirector sharedDirector]view]addGestureRecognizer:swipeDown];
    _isOver = YES;
}

- (void)setupGrid {
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
    
    _totalStep = 0;
    _restStep = 6;
    _totalCount = 0;
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    // play background sound
    [audio playBg:@"nyancat.mp3" loop:YES];
}

- (void)evolveStep {
    _timeCount++;
    //随机产生不能走的格子
    if(_timeCount == 1){
        [self updateCreatures];
    }
    //不能走的格子提示消失
    else if(_timeCount == 2){
        [self closeCreatures];
    }
    //检测是否走在不该走的格子上了
    if(_timeCount == 5){
        [self checkIfDeadOrSucceed];
        _timeCount = 0;
        _restStep = 6;
        _totalCount++;
    }
}

- (void)updateCreatures {
    for (int i = 0; i < [_gridArray count]; i++)
    {
        for (int j = 0; j < [_gridArray[i] count]; j++)
        {
            Creature *currentCreature = _gridArray[i][j];
            currentCreature.isAlive = NO;
            [currentCreature setIsVisible:NO];
            int random = [self getRandomNumberBetweenMin:0 andMax:100];
            //NSLog(@"random = %i",random);
            if(random < 50){
                currentCreature.isAlive = YES;
                [currentCreature setIsVisible:YES];
            }
        }
        
    }
    Creature *nowCreature = _gridArray[(int)(_actor.position.y/_cellHeight)][(int)(_actor.position.x/_cellWidth)];
    nowCreature.isAlive = YES;
    [nowCreature setIsVisible:YES];
}
//产生随机个数的不能走的格子
- (int) getRandomNumberBetweenMin:(int)min andMax:(int)max {
    return ( (arc4random() % (max-min+1)) + min );
}

- (void)closeCreatures {
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
    //succeed, then game over
   // if(_actor.position.x >= 9 * _cellWidth && _actor.position.x <= 10 * _cellWidth
    //   && _actor.position.y >= 0 * _cellHeight && _actor.position.y <= 1 * _cellHeight){
      //  NSLog(@"Succeed");
    //}
    //NSLog(@"X location is = %f",_actor.position.x);
    //NSLog(@"Y location is = %f",_actor.position.y);
    for (int i = 0; i < [_gridArray count]; i++)
    {
        for (int j = 0; j < [_gridArray[i] count]; j++)
        {
            Creature *currentCreature = _gridArray[i][j];
            //character dies, then game over
            if(currentCreature.isAlive == YES && _actor.position.x >= j * _cellWidth && _actor.position.x <= (j+1) * _cellWidth
               && _actor.position.y >= i * _cellHeight && _actor.position.y <= (i+1) * _cellHeight){
                //NSLog(@"Over");
                self.paused = YES;
                _isOver = YES;
                EndMenu *popup = (EndMenu *)[CCBReader load:@"EndMenu" owner:self];
                popup.finalScore = _totalCount;
                popup.positionType = CCPositionTypeNormalized;
                popup.position = ccp(0.5, 0.5);
                [self addChild:popup];
            }
        }
    }
}


- (void)swipeLeft {
    [self move:ccp(-1, 0)];
}

- (void)swipeRight {
    [self move:ccp(1, 0)];
}

- (void)swipeDown {
    [self move:ccp(0, -1)];
}

- (void)swipeUp {
    [self move:ccp(0, 1)];
}

- (void)move:(CGPoint)direction{
    if(_isOver == NO){
    BOOL isIndexValid;
    isIndexValid = [self isIndexValidForX:((int)(_actor.position.x / _cellWidth) + direction.x) andY:((int)(_actor.position.y / _cellHeight) + direction.y)];
    if(isIndexValid && _restStep > 0){
        _totalStep++;
        _restStep--;
        _actor.position = ccp(_actor.position.x + direction.x * _cellWidth,
                              _actor.position.y + direction.y * _cellHeight);
        int random = [self getRandomNumberBetweenMin:0 andMax:100];
        //产生随机数，一定记录随意移动
        if(random < 50){
            int horizonalMove = [self getRandomNumberBetweenMin:(0-_actor.position.x/_cellWidth) andMax:(GRID_COLUMNS - _actor.position.x/_cellWidth)];
            int verticalMove = [self getRandomNumberBetweenMin:(0-_actor.position.y/_cellHeight) andMax:(GRID_ROWS - _actor.position.y/_cellHeight)];
            _actor.position = ccp(_actor.position.x + horizonalMove * _cellWidth,
                                  _actor.position.y + verticalMove * _cellHeight);
        }
    }
    }
}

- (BOOL)isIndexValidForX:(int)x andY:(int)y {
    BOOL isIndexValid = YES;
    if(x < 0 || y < 0 || x >= GRID_COLUMNS || y >= GRID_ROWS)
    {
        isIndexValid = NO;
    }
    return isIndexValid;
}

@end

