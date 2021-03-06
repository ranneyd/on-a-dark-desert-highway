//
//  DDHPiece.h
//  DDHChess
//
//  Created by Dustin Kane on 2/21/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChessPlayer.h"
#import "DDHTuple.h"
#import "DDHBoard.h"

@class DDHBoard;

@interface DDHPiece : NSObject <NSCopying>

@property NSInteger x;
@property NSInteger y;
@property int index;

-(id) initWithPlayer: (ChessPlayer) player atColumn:(NSUInteger) column andRow:(NSUInteger) row;

// Implements NSCopying protocol
-(id) copyWithZone:(NSZone *)zone;

// Sets the highlighted array of the board to the places that are moveable by this piece
-(NSMutableArray*) highlightMovesWithBoard:(DDHBoard*) board andCheck:(BOOL)check;

// Changes the x and y properties of this piece
-(void) moveToColumn: (NSInteger) column andRow:(NSInteger)row;

// Get player
-(ChessPlayer) getPlayer;

// Get opposite player
-(ChessPlayer) getEnemy;

// Check if a position is on the given board
-(BOOL) onBoard:(DDHBoard*)board AtColumn:(NSInteger)column andRow:(NSInteger)row;

-(void) setPlayer:(ChessPlayer) player;

// Describe the piece
-(NSString*) description;

// Checks if the move is on the board, to an empty space or enemy piece and that the move doesn't put the player in check. Adjusts highlighting accordingly.
// Returns YES if the spot in question had a piece in it or was off the board
-(BOOL) checkAndMoveToColumn:(NSUInteger) column andRow:(NSUInteger) row withBoard:(DDHBoard*) board andHighlighting:(NSMutableArray*) highlighting andCheck:(BOOL) check;

// True if the piece has moved.
-(BOOL) hasMoved;

// Sets whether or not the piece has moved.
-(void) setMoved:(BOOL) moved;

@end
