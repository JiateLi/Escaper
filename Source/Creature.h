//
//  Creature.h
//  Escaper
//
//  Created by Jiate Li on 15/2/21.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Creature : CCSprite

// stores the current state of the creature
@property (nonatomic, assign) BOOL isAlive;
// stores the amount of living neighbors
//@property (nonatomic, assign) NSInteger livingNeighbors;

- (id)initCreature;
- (void)setIsVisible:(BOOL)newState;
@end