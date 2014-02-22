//
//  DDHReversiBoard.h
//  DDHChess
//
//  Created by Colin Eberhardt and modified by Dustin Kane, Will Clausen and Zakkai Davidson on 2/15/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHBoard.h"

@interface DDHReversiBoard : DDHBoard

// THESE WILL NEED TO BE CHANGED WHEN IMPLEMENTING MORE THAN TWO PLAYERS. MAKE ARRAY?
// ACTUALLY, THESE DON'T REALLY HAVE ANYTHING TO DO WITH CHESS SO...

// White player's score
@property (readonly) NSInteger whiteScore;
// Black player's score
@property (readonly) NSInteger blackScore;

// indicates the player who makes the next move
@property (readonly) BoardCellState nextMove;

// Sets board to opening positions for Reversi
- (void) setToInitialState;


// Returns whether the player who's turn it is can make the given move
-(BOOL) isValidMoveToColumn:(NSInteger)column andRow:(NSInteger) row;

// Makes the given move for the player who is currently taking their turn
- (void) makeMoveToColumn: (NSInteger) column andRow:(NSInteger) row;


@end
