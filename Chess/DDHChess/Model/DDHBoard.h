//
//  DDHBoard.h
//  DDHChess
//
//  Created by Colin Eberhardt and modified by Dustin Kane, Will Clausen and Zakkai Davidson on 2/15/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDHMulticastDelegate.h"
#import "DDHPiece.h"

/* The Board */
@interface DDHBoard : NSObject

// multicasts changes in cell state. Each delegate is informed of changes in state of individual cells
@property (readonly) DDHMulticastDelegate* boardDelegate;


// Returns pointer to piece at location
-(id) pieceAtColumn: (NSInteger) column andRow:(NSInteger)row;


// Puts the piece on the piece stack and in the piece array
// ASSUMES: piece object already has correct coordinates as its x and y and belongs to the board.
-(void) putPiece:(id) piece inColumn:(NSInteger) column andRow:(NSInteger) row;

// Returns true if square has no piece in it. Shocking, I know
-(BOOL) isEmptySquareAtColumn:(NSInteger) column andRow:(NSInteger) row;

// Returns a pointer to the piece at the given index in the internal piece array.
-(id) pieceAtIndex: (int) index;

-(BOOL) highlightedAtColumn: (NSInteger) column andRow:(NSInteger) row;

-(void) moveToColumn:(NSInteger) column andRow:(NSInteger) row;

-(void) highlightAtColumn: (NSInteger) column andRow:(NSInteger) row withIndex: (int) index;

-(void) clearHighlighting;

-(BOOL) onBoardAtColumn: (NSInteger) column andRow: (NSInteger) row;

// Sets every cell in board to empty
-(void) clearBoard;

-(BOOL) kingCouldMoveToColumn: (NSInteger) column andRow: (NSInteger) row;

@end
