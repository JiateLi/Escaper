//
//  Creature.m
//  Escaper
//
//  Created by Jiate Li on 15/2/21.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "Creature.h"

@implementation Creature
- (instancetype)initCreature {
    self = [super initWithImageNamed:@"GameOfLifeAssets/Assets/bubble.png"];
    
    if (self) {
        self.isAlive = NO;
        self.visible = NO;
    }
    
    return self;
}

- (void)setIsVisible:(BOOL)newState {
    //_isAlive = newState;
    //self.visible = _isAlive;
    self.visible = newState;
}
@end
