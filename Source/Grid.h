//
//  Grid.h
//  Escaper
//
//  Created by Jiate Li on 15/2/21.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Grid : CCSprite

//@property (nonatomic, assign) int totalAlive;
@property (nonatomic, assign) int setp;
@property (nonatomic, assign) int time;

@property (nonatomic, assign) int totalStep;
@property (nonatomic, assign) int restStep;
@property (nonatomic, assign) int totalCount;

- (void)evolveStep;
- (void)updateCreatures;

@end
