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

@class DDHBoard;

@interface DDHPiece : NSObject

@property NSInteger x;
@property NSInteger y;
@property int index;

-(id) initWithPlayer: (ChessPlayer) player atColumn:(NSUInteger) column andRow:(NSUInteger) row;

// Sets the highlighted array of the board to the places that are moveable by this piece
-(NSMutableArray*) highlightMovesWithBoard:(DDHBoard*) board andCheck:(BOOL)check;

// Changes the x and y properties of this piece
-(void) moveToColumn: (NSInteger) column andRow:(NSInteger)row;

// Get player
-(ChessPlayer) getPlayer;

// Check if a position is on the given board
-(BOOL) onBoard:(DDHBoard*)board AtColumn:(NSInteger)column andRow:(NSInteger)row;

-(void) setPlayer:(ChessPlayer) player;

// Describe the piece
-(NSString*) description;

// Checks if the move is on the board, to an empty space or enemy piece and that the move doesn't put the player in check. Adjusts highlighting accordingly.
// Returns YES if the move succeeded and NO otherwise.
-(BOOL) checkAndMoveToColumn:(NSUInteger) column andRow:(NSUInteger) row withBoard:(DDHBoard*) board andHighlighting:(NSMutableArray*) highlighting;

@end
