//
//  DDHPiece.h
//  Chess
//
//  Created by Dustin Kane on 2/13/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDHPlayer.h"
#import "DDHLoc.h"
#import "DDHBoard.h"

@interface DDHPiece : NSObject

@property DDHPlayer *player;
@property DDHLoc *position;
@property DDHBoard  *board;

-(NSArray *) moves;
-(void) moveTo:(DDHLoc *) position;

@end
