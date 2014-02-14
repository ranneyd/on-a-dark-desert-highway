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

@property DDHPlayer *player;            //Represents the player that controls this piece
@property DDHLoc *position;             //Represents the location on the board of this piece
@property DDHBoard  *board;             //Pointer to the board this piece lives on

-(NSArray *) moves;                     //Returns an array containing DDHLoc objects that represent all possible moves
-(void) moveTo:(DDHLoc *) position;     //Moves the piece to the given DDHLoc

+(id) newPieceWithPlayer:(DDHPlayer *) player andPosition: (DDHLoc *) position andBoard: (DDHBoard *) board;

@end
