#import "MainScene.h"

@implementation MainScene
- (void)playgame {
    CCScene *gameplayScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}
@end
