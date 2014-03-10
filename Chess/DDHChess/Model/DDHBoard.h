//
//  DDHBoard.h - The main board class
//  DDHChess
//
//  Contains the current state of the board. Also handles game logic,
//  communication with pieces, and communication with views (which
//  should probably be moved into a controller if time allows).
//
//  Created by Colin Eberhardt and modified by Dustin Kane, Will Clausen and Zakkai Davidson on 2/15/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDHMulticastDelegate.h"
#import "DDHPiece.h"
#import "ChessPlayer.h"
#import "DDHTuple.h"

/* The Board */
@interface DDHBoard : NSObject

// *****************
// ** Public Data **
// *****************

// Multicasts changes in cell state. Each delegate is informed of changes in state of individual cells
@property (readonly) DDHMulticastDelegate* boardDelegate;
// Indicates the player who makes the next move
@property ChessPlayer nextMove;

// **********************
// ** Public Functions **
// **********************

// ********************
// ** Initialization **
// ********************

// Initialize a board
-(id) init;

// Places pieces in proper places for chess and sets which player moves first
-(void) setToInitialState;

// Sets every cell in board to empty
-(void) clearBoard;


// ***************************
// ** Getters (and Setters) **
// ***************************

// Returns the number of columns
-(NSUInteger) getColumns;

// Returns the number of rows
-(NSUInteger) getRows;


// ************************************
// ** Piece Interaction and Movement **
// ************************************

// Returns pointer to piece at location
-(id) pieceAtColumn: (NSInteger) column andRow:(NSInteger)row;

// Puts the piece on the piece stack and in the piece array
// ASSUMES: piece object already has correct coordinates as its x and y and belongs to the board.
-(void) putPiece:(id) piece inColumn:(NSInteger) column andRow:(NSInteger) row;

// Returns true if square has no piece in it. Shocking, I know
-(BOOL) isEmptySquareAtColumn:(NSInteger) column andRow:(NSInteger) row;

-(void) makeMoveToColumn:(NSUInteger) column andRow:(NSUInteger) row;

-(void) moveHighlightOwnerToColumn:(NSUInteger) columnn andRow:(NSUInteger) row;


// ***************************
// ** Additional Game Logic **
// ***************************

-(BOOL) doesPieceAtColumn:(NSInteger)column andRow:(NSInteger)row notBelongToPlayer:(ChessPlayer)player;

-(BOOL) isHighlightOwnerAtColumn:(NSUInteger)columen andRow:(NSUInteger)row;

// Changes whose turn it is
-(void) invertState;

// TODO
 -(BOOL) kingInCheckBelongingTo:(ChessPlayer)player;

// TODO
//-(BOOL) kingBelongingTo:(ChessPlayer)player CouldMoveToColumn: (NSInteger) column andRow: (NSInteger) row;


// *************************
// ** UI Helper Functions **
// *************************

-(BOOL) highlightedAtColumn: (NSInteger) column andRow:(NSInteger) row;

-(void) highlightAtColumn: (NSInteger) column andRow:(NSInteger) row;

-(void) clearHighlighting;

-(NSMutableArray*) getHighlightedSquaresFromPieceAtColumn: (NSUInteger) column andRow:(NSUInteger) row;


-(void) highlightMovesForPieceAtColumn:(NSUInteger)column andRow:(NSUInteger)row;

@end
