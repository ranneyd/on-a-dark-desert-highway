//
//  DDHBoard.h - The main board class
//  DDHChess
//
//  Contains the current state of the board. Also handles game logic,
//  communication with pieces, and communication with views through
//  a delegate.22
//
//  Created by Colin Eberhardt and modified by Dustin Kane, Will Clausen and Zakkai Davidson on 2/15/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDHMulticastDelegate.h"
#import "DDHPiece.h"
#import "ChessPlayer.h"
#import "DDHTuple.h"
#import "DDHChessInfoView.h"

@class DDHPiece;
/* The Board */
@interface DDHBoard : NSObject <NSCopying>

// *****************
// ** Public Data **
// *****************

// Multicasts changes in cell state. Each delegate is informed of changes in state of individual cells
@property (readonly) DDHMulticastDelegate* boardDelegate;
// Indicates the player who makes the next move
@property ChessPlayer nextMove;

@property BOOL luke;
@property BOOL vader;

// **********************
// ** Public Functions **
// **********************

// ********************
// ** Initialization **
// ********************

// Initialize a board
-(id) initWithView:(DDHChessInfoView *) controller;

// Places pieces in proper places for chess and sets which player moves first
-(void) setToInitialState;

-(void) setToInitialRandomState;

// Sets every cell in board to empty
-(void) clearBoard;


// Set owner of highlighting
-(void) setHighlighterwithColumn:(NSUInteger) column andRow:(NSUInteger) row;

// Implementation of NSCopying protocol that allows for object copying
-(id) copyWithZone:(NSZone *)zone;

// *************
// ** Getters **
// *************

// Returns the number of columns
-(NSUInteger) getColumns;

// Returns the number of rows
-(NSUInteger) getRows;

// Get the pawn that double jumped last turn
-(DDHPiece*) getPawnThatDoubleMovedLastTurn;

// ************************************
// ** Piece Interaction and Movement **
// ************************************

// Returns pointer to piece at location
-(id) pieceAtColumn: (NSInteger) column andRow:(NSInteger)row;

// Returns true if square has no piece in it. Shocking, I know
-(BOOL) isEmptySquareAtColumn:(NSInteger) column andRow:(NSInteger) row;

// Moves the currently selected piece to the given column and row
-(void) makeMoveToColumn:(NSUInteger) column andRow:(NSUInteger) row;

// Move a piece from an old postion to a new one
-(void) movePieceAtColumn:(NSInteger)oldColumn andRow:(NSUInteger)oldRow ToColumn:(NSInteger)column andRow:(NSInteger)row;

// Housekeeping after moving a piece. Includes informing delegates, switching the current player and clearing highlighting
-(void) afterMoveFromColumn:(NSInteger)oldColumn andRow:(NSUInteger)oldRow ToColumn:(NSInteger)column andRow:(NSInteger)row;

// ***************************
// ** Additional Game Logic **
// ***************************

// Changes whose turn it is
-(void) invertState;

// Checks if the piece at a location does not belong to player
-(BOOL) doesPieceAtColumn:(NSInteger)column andRow:(NSInteger)row notBelongToPlayer:(ChessPlayer)player;

// Checks if there is a blocked wall at the given position
-(BOOL) hasNoWallAtColumn:(NSInteger)column andRow:(NSInteger)row;

// Checks if the selected piece is at the given row and column
-(BOOL) isHighlightOwnerAtColumn:(NSUInteger)column andRow:(NSUInteger)row;

// Checks if player is in check
-(BOOL) kingInCheckBelongingTo:(ChessPlayer)player;

// Puts a piece in a place. Only effects _pieces data member
-(void) putPiece:(DDHPiece*) piece inColumn:(NSUInteger) column andRow:(NSUInteger) row;

// Checks to see if a piece moving from one point to another would put the player in check.
-(BOOL) checkIfMoveFromColumn:(NSUInteger) oldColumn andRow:(NSUInteger) oldRow toColumn:(NSUInteger) column andRow:(NSUInteger) row;

// Checks if a move will put a given player in check
-(BOOL) doesMoveFromColumn:(NSUInteger) oldColumn andRow:(NSUInteger) oldRow toColumn:(NSUInteger) column andRow:(NSUInteger) row causeCheckForPlayer: (ChessPlayer) player;

// Check if destroying a piece will cause check
-(BOOL) doesDestructionCauseCheckAtColumn:(NSUInteger) column andRow:(NSUInteger) row;

// Check if a new piece at a given position will cause check
-(BOOL) doesNewPiece: (DDHPiece *) piece atColumn: (NSInteger) column andRow: (NSInteger) row causeCheckForPlayer: (ChessPlayer) player;

-(void) destroyPieceAtColumn:(NSUInteger) column andRow:(NSUInteger) row;

// *************************
// ** UI Helper Functions **
// *************************

// Checks if the location should be/is highlighted
-(BOOL) highlightedAtColumn: (NSInteger) column andRow:(NSInteger) row;

// Clears all highlighting on the board
-(void) clearHighlighting;

// Highlight all moves a given piece can make
-(void) highlightMovesForPieceAtColumn:(NSUInteger)column andRow:(NSUInteger)row;

-(BOOL) randomAtColumn:(NSUInteger) column andRow:(NSUInteger) row;

-(void)informDelegateOfExplosionAtColumn:(NSInteger)column andRow:(NSInteger) row;
@end
