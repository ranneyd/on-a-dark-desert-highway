//
//  DDHPiece.h
//  DDHChess
//
//  Created by Dustin Kane on 2/21/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChessPlayer.h"
#import "DDHBoard.h"

struct Tuple{
    NSInteger x;
    NSInteger y;
};

@interface DDHPiece : NSObject

@property DDHBoard* board;
@property NSInteger x;
@property NSInteger y;
@property int index;

-(id) initWithBoard: (id) board andPlayer: (ChessPlayer) player andIndex:(int) index atColumn:(NSUInteger) column andRow:(NSUInteger) row;

// Sets the highlighted array of the board to the places that are moveable by this piece
-(void) highlightMoves;

// Changes the x and y properties of this piece
-(void) moveToColumn: (NSInteger) column andRow:(NSInteger)row;

-(ChessPlayer) getPlayer;

@end
