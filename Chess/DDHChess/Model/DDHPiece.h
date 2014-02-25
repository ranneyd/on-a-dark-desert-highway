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


@interface DDHPiece : NSObject

// This is the board the piece belongs to
@property (readonly) DDHBoard* board;
// This represents which player each piece belongs to
@property (readonly) ChessPlayer player;
// this represents the piece's location
@property NSInteger x;
@property NSInteger y;

+(id) initWithBoard: (id) board atColumn:(NSUInteger) column andRow:(NSUInteger) row;

// Sets the highlighted array of the board to the places that are moveable by this piece
-(void) highlightMoves;

// Changes the x and y properties of this piece
-(void) moveToColumn: (NSInteger) column andRow:(NSInteger)row;

-(NSUInteger) getX;

-(NSUInteger) getY;

@end
