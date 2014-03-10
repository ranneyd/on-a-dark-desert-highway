//
//  DDHBoard.m
//  DDHChess
//
//  Created by Colin Eberhardt and modified by Dustin Kane, Will Clausen and Zakkai Davidson on 2/15/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHBoard.h"
#import "DDH2DArray.h"
#import "DDHBoardDelegate.h"
#import "DDHNullPiece.h"
#import "DDHPawn.h"
#import "DDHRook.h"
#import "DDHKnight.h"
#import "DDHBishop.h"
#import "DDHQueen.h"
#import "DDHKing.h"

@interface DDHBoard ()

// ***********************
// ** Private Functions **
// ***********************

// ************************************
// ** Piece Interaction and Movement **
// ************************************

// Helper function to move the selected piece
-(void) moveHighlightOwnerToColumn:(NSUInteger) columnn andRow:(NSUInteger) row;

// Move a piece from an old postion to a new one
-(void) movePieceAtColumn:(NSInteger)oldColumn andRow:(NSUInteger)oldRow ToColumn:(NSInteger)column andRow:(NSInteger)row;


// ***************************
// ** Additional Game Logic **
// ***************************

// Changes whose turn it is
-(void) invertState;

// *************************
// ** UI Helper Functions **
// *************************

// Highlight possible movements for a piece, using a delegate to inform the views
-(NSMutableArray*) getHighlightedSquaresFromPieceAtColumn: (NSUInteger) column andRow:(NSUInteger) row;

// Change the state of a position in the private highlighted array
-(void) highlightAtColumn: (NSInteger) column andRow:(NSInteger) row;

// Tell the delegate that the views should be updated
-(void)informDelegateOfPieceChangedAtColumn:(NSInteger)column andRow:(NSInteger) row;

// ******************************
// ** General Helper Functions **
// ******************************

// Verify that a given location is in bounds
-(void)checkBoundsForColumn: (NSInteger) column andRow: (NSInteger) row;

@end

// ###########################
// END OF PRIVATE DECLARATIONS
// ###########################


@implementation DDHBoard
{
    // CHANGE FOR DYNAMICALLY SIZED BOARD
    
    // 2D array representing which pieces are in each board location.
    DDH2DArray* _pieces;
    // 2D array representing which parts of the board are currently highlighted
    BOOL _highlightBoard[8][8];
    id<DDHBoardDelegate> _delegate;
    DDHTuple* _locOfHighlightOwner;
    
    NSUInteger _rows; // Number of rows in the board
    NSUInteger _columns; // Number of columns in the board
}

// ********************
// ** Initialization **
// ********************

- (id) init
{
    if (self = [super init]){
        // Set the size of the board. TODO: Change for dynamically allocated array.
        _rows = 8;
        _columns = 8;
        
        // Initialize the array of pieces. Set all pieces on the board to null pieces initially (i.e. set the board
        // to be completely empty).
        _pieces = [[DDH2DArray alloc] initWithColumns:_rows andRow:_columns andObject:[[DDHNullPiece alloc] init]];
        
        [self clearBoard];
        _boardDelegate = [[DDHMulticastDelegate alloc] init];
        _delegate = (id)_boardDelegate;
    }
    return self;
}

-(void) setToInitialState
{
    // clear le board
    
    [self clearBoard];
    
    // Place the white pieces
    [_pieces replaceObjectAtColumn:0 andRow:1 withObject:[[DDHPawn alloc]initWithPlayer:ChessPlayerWhite atColumn:0 andRow:1]];
    [_pieces replaceObjectAtColumn:1 andRow:1 withObject:[[DDHPawn alloc]initWithPlayer:ChessPlayerWhite atColumn:1 andRow:1]];
    [_pieces replaceObjectAtColumn:2 andRow:1 withObject:[[DDHPawn alloc]initWithPlayer:ChessPlayerWhite atColumn:2 andRow:1]];
    [_pieces replaceObjectAtColumn:3 andRow:1 withObject:[[DDHPawn alloc]initWithPlayer:ChessPlayerWhite atColumn:3 andRow:1]];
    [_pieces replaceObjectAtColumn:4 andRow:1 withObject:[[DDHPawn alloc]initWithPlayer:ChessPlayerWhite atColumn:4 andRow:1]];
    [_pieces replaceObjectAtColumn:5 andRow:1 withObject:[[DDHPawn alloc]initWithPlayer:ChessPlayerWhite atColumn:5 andRow:1]];
    [_pieces replaceObjectAtColumn:6 andRow:1 withObject:[[DDHPawn alloc]initWithPlayer:ChessPlayerWhite atColumn:6 andRow:1]];
    [_pieces replaceObjectAtColumn:7 andRow:1 withObject:[[DDHPawn alloc]initWithPlayer:ChessPlayerWhite atColumn:7 andRow:1]];
    
    [_pieces replaceObjectAtColumn:0 andRow:0 withObject:[[DDHRook alloc]initWithPlayer:ChessPlayerWhite atColumn:0 andRow:0]];
    [_pieces replaceObjectAtColumn:1 andRow:0 withObject:[[DDHKnight alloc]initWithPlayer:ChessPlayerWhite atColumn:1 andRow:0]];
    [_pieces replaceObjectAtColumn:2 andRow:0 withObject:[[DDHBishop alloc]initWithPlayer:ChessPlayerWhite atColumn:2 andRow:0]];
    [_pieces replaceObjectAtColumn:3 andRow:0 withObject:[[DDHQueen alloc]initWithPlayer:ChessPlayerWhite atColumn:3 andRow:0]];
    [_pieces replaceObjectAtColumn:4 andRow:0 withObject:[[DDHKing alloc]initWithPlayer:ChessPlayerWhite atColumn:4 andRow:0]];
    [_pieces replaceObjectAtColumn:5 andRow:0 withObject:[[DDHBishop alloc]initWithPlayer:ChessPlayerWhite atColumn:5 andRow:0]];
    [_pieces replaceObjectAtColumn:6 andRow:0 withObject:[[DDHKnight alloc]initWithPlayer:ChessPlayerWhite atColumn:6 andRow:0]];
    [_pieces replaceObjectAtColumn:7 andRow:0 withObject:[[DDHRook alloc]initWithPlayer:ChessPlayerWhite atColumn:7 andRow:0]];
    
    // Black pieces
    [_pieces replaceObjectAtColumn:0 andRow:6 withObject:[[DDHPawn alloc]initWithPlayer:ChessPlayerBlack atColumn:0 andRow:6]];
    [_pieces replaceObjectAtColumn:1 andRow:6 withObject:[[DDHPawn alloc]initWithPlayer:ChessPlayerBlack atColumn:1 andRow:6]];
    [_pieces replaceObjectAtColumn:2 andRow:6 withObject:[[DDHPawn alloc]initWithPlayer:ChessPlayerBlack atColumn:2 andRow:6]];
    [_pieces replaceObjectAtColumn:3 andRow:6 withObject:[[DDHPawn alloc]initWithPlayer:ChessPlayerBlack atColumn:3 andRow:6]];
    [_pieces replaceObjectAtColumn:4 andRow:6 withObject:[[DDHPawn alloc]initWithPlayer:ChessPlayerBlack atColumn:4 andRow:6]];
    [_pieces replaceObjectAtColumn:5 andRow:6 withObject:[[DDHPawn alloc]initWithPlayer:ChessPlayerBlack atColumn:5 andRow:6]];
    [_pieces replaceObjectAtColumn:6 andRow:6 withObject:[[DDHPawn alloc]initWithPlayer:ChessPlayerBlack atColumn:6 andRow:6]];
    [_pieces replaceObjectAtColumn:7 andRow:6 withObject:[[DDHPawn alloc]initWithPlayer:ChessPlayerBlack atColumn:7 andRow:6]];
    
    [_pieces replaceObjectAtColumn:0 andRow:7 withObject:[[DDHRook alloc]initWithPlayer:ChessPlayerBlack atColumn:0 andRow:7]];
    [_pieces replaceObjectAtColumn:1 andRow:7 withObject:[[DDHKnight alloc]initWithPlayer:ChessPlayerBlack atColumn:1 andRow:7]];
    [_pieces replaceObjectAtColumn:2 andRow:7 withObject:[[DDHBishop alloc]initWithPlayer:ChessPlayerBlack atColumn:2 andRow:7]];
    [_pieces replaceObjectAtColumn:3 andRow:7 withObject:[[DDHQueen alloc]initWithPlayer:ChessPlayerBlack atColumn:3 andRow:7]];
    [_pieces replaceObjectAtColumn:4 andRow:7 withObject:[[DDHKing alloc]initWithPlayer:ChessPlayerBlack atColumn:4 andRow:7]];
    [_pieces replaceObjectAtColumn:5 andRow:7 withObject:[[DDHBishop alloc]initWithPlayer:ChessPlayerBlack atColumn:5 andRow:7]];
    [_pieces replaceObjectAtColumn:6 andRow:7 withObject:[[DDHKnight alloc]initWithPlayer:ChessPlayerBlack atColumn:6 andRow:7]];
    [_pieces replaceObjectAtColumn:7 andRow:7 withObject:[[DDHRook alloc]initWithPlayer:ChessPlayerBlack atColumn:7 andRow:7]];
    
    // Nobody has highlighted anything yet. So the highlight owner should be updated accordingly
    _locOfHighlightOwner = [[DDHTuple alloc] initWithX:_columns + 1 andY:_rows + 1];
    
    _nextMove = ChessPlayerBlack;
}


-(void) clearBoard
{
    // Someone figure out if this takes advantage of spacial locality
    
    // Clear all highlighted squares
    [self clearHighlighting];
    
    // Set all squares on the board to empty by putting a NullPiece in each square.
    for(int i = 0; i < [_pieces rows]; i++){
        for(int j = 0; j < [_pieces columns]; j++){
            [_pieces replaceObjectAtColumn:j andRow:i withObject:[[DDHNullPiece alloc] init]];
        }
    }
    
    // Let the UI know things have changed, so it will update every square as necessary.
    [self informDelegateOfPieceChangedAtColumn:-1 andRow:-1];
}


// *************
// ** Getters **
// *************

-(NSUInteger) getColumns
{
    return _columns;
}

-(NSUInteger) getRows
{
    return _rows;
}


// ************************************
// ** Piece Interaction and Movement **
// ************************************


- (DDHPiece*) pieceAtColumn:(NSInteger)column andRow:(NSInteger)row
{
    [self checkBoundsForColumn:column andRow:row];
    return [_pieces objectAtColumn:column andRow:row];
}

-(void) putPiece:(DDHPiece *)piece inColumn:(NSInteger)column andRow:(NSInteger)row
{
    [self checkBoundsForColumn:column andRow:row];
    [_pieces replaceObjectAtColumn:column andRow:row withObject:piece];
    [self informDelegateOfPieceChangedAtColumn:column andRow:row];
}

-(BOOL) isEmptySquareAtColumn:(NSInteger)column andRow:(NSInteger)row
{
    DDHPiece* piece = [_pieces objectAtColumn:column andRow:row];
    NSString* pieceDescription = [piece description];
    return [pieceDescription isEqualToString:@"NullPiece"];
}

-(void) makeMoveToColumn:(NSUInteger) column andRow:(NSUInteger) row
{
    [self moveHighlightOwnerToColumn:column andRow:row];
}

// PRIVATE
-(void) moveHighlightOwnerToColumn:(NSUInteger)columnn andRow:(NSUInteger)row
{
    NSLog(@"Moving piece at column: %d and row: %d", [_locOfHighlightOwner x], [_locOfHighlightOwner y]);
    [self movePieceAtColumn:[_locOfHighlightOwner x] andRow:[_locOfHighlightOwner y] ToColumn:columnn andRow:row];
}

// PRIVATE
-(void) movePieceAtColumn:(NSInteger)oldColumn andRow:(NSUInteger)oldRow ToColumn:(NSInteger)column andRow:(NSInteger)row
{
    // Get the piece from _pieces
    DDHPiece* piece = [_pieces objectAtColumn:oldColumn andRow:oldRow];
    // Get old position of the piece
    
    // Make sure the piece's internal x and y are updated to the new position
    [piece moveToColumn:column andRow:row];
    
    // Change the old position in the board array to empty
    [_pieces replaceObjectAtColumn:oldColumn andRow:oldRow withObject:[[DDHNullPiece alloc] init]];
    
    // Change the new position in the board to our piece index
    [_pieces replaceObjectAtColumn:column andRow:row withObject:piece];
    
    // Clear the highlighting
    [self clearHighlighting];
    
    [self informDelegateOfPieceChangedAtColumn:oldColumn andRow:oldRow];
    
    [self informDelegateOfPieceChangedAtColumn:column andRow:row];
    
    [self invertState];
}


// ***************************
// ** Additional Game Logic **
// ***************************

-(BOOL) doesPieceAtColumn:(NSInteger)column andRow:(NSInteger)row notBelongToPlayer:(ChessPlayer)player
{
    [self checkBoundsForColumn:column andRow:row];
    
    if (![self isEmptySquareAtColumn:column andRow:row]) {
        DDHPiece* piece = [self pieceAtColumn:column andRow:row];
        return [piece getPlayer] != _nextMove;
    }
    return YES;
}

-(BOOL) isHighlightOwnerAtColumn:(NSUInteger)column andRow:(NSUInteger)row
{
    return [_locOfHighlightOwner x] == column && [_locOfHighlightOwner y] == row;
}

-(void)invertState
{
    if ([self nextMove] == ChessPlayerBlack)
        self.nextMove = ChessPlayerWhite;
    else
        self.nextMove = ChessPlayerBlack;
}

-(BOOL) kingInCheckBelongingTo:(ChessPlayer)player
{
//    NSInteger kingColumn = -1;
//    NSInteger kingRow = -1;
//
//    // First, we need to find the King of the player.
//    // Let's iterate over all the pieces to find the King.
//    for (int row = 0; row < _rows; row++) {
//        for (int col = 0; col < _columns; col++) {
//            DDHPiece* piece = [_pieces objectAtColumn:col andRow:row];
//
//            if ([piece getPlayer] == player) {
//                NSString* pieceDescription = [piece description];
//                if ([pieceDescription rangeOfString:@"King"].location != NSNotFound) {
//                    // We found the King!
//                    // Get the location
//                    NSInteger kingColumn = [piece x];
//                    NSInteger kingRow = [piece y];
//                }
//            }
//        }
//    }
//
//    // Iterate over all enemy pieces to determine if they are attacking the player's king.
//    for (int row = 0; row < _rows; row++) {
//        for (int col = 0; col < _columns; col++) {
//            DDHPiece* piece = [_pieces objectAtColumn:col andRow:row];
//
//            if ([piece getPlayer] != player) {
//                if ([piece couldAttackAtColumn:kingColumn andRow:kingRow]) {
//                    return YES;
//                }
//            }
//        }
//    }
    return NO;
}
/*
 
 // Returns true if a King belonging to player could move to this spot. Iterates through pieces and highlights the board
 // with their moves and if, after all the pieces are through, the given spot is highlighted, the king can't move there
 // ie can't move into check.
 -(BOOL) kingBelongingTo:(ChessPlayer)player CouldMoveToColumn:(NSInteger)column andRow:(NSInteger) row
 {
 // I sincerely wish pointers in objective C weren't so stupid
 
 // We're going to store the current state of the highlighted board here.
 NSUInteger oldHighlighting[8][8];
 
 // Iterate over the highlighted board and save it into the temporary save location
 for(int i = 0; i < 8; i++)
 for(int j = 0; j < 8; j++)
 oldHighlighting[i][j] = _highlightBoard[i][j];
 
 // Clear the highlighting
 [self clearHighlighting];
 // If we find that our spot is hit, we set this to NO
 BOOL result = YES;
 
 // Iterate over all pieces
 for(DDHPiece* piece in _pieceList){
 // _pieceList has nils in it to preserve indices after piece deletion. We have to avoid those and
 // we don't want to consider moves from our own pieces.
 if(piece != nil && [piece getPlayer] != player){
 // Highlight possible moves
 [piece highlightMoves];
 // If the square we're looking at is highlighted, we'll return NO later and break the loop now
 
 // Putting here and not outside the loop for performance. Don't want to go through every piece if
 // The first piece can hit that spot.
 if ([self highlightedAtColumn:column andRow:row]){
 result = NO;
 break;
 }
 }
 }
 
 // Set the highlight board back to its original state.
 for(int i = 0; i < 8; i++)
 for(int j = 0; j < 8; j++)
 _highlightBoard[i][j] = oldHighlighting[i][j];
 return result;
 }
 
 */


// *************************
// ** UI Helper Functions **
// *************************

-(BOOL) highlightedAtColumn:(NSInteger)column andRow:(NSInteger)row
{
    return _highlightBoard[column][row] == YES;
}


-(void) clearHighlighting
{
    for(int i = 0; i < _rows; i++)
    {
        for(int j = 0; j < _columns; j++)
        {
            _highlightBoard[i][j] = NO;
        }
    }
    
    // Set location of highlight owner to be nobody
    [_locOfHighlightOwner setX:_columns+1];
    [_locOfHighlightOwner setY:_rows + 1];
    
    // Update all squares
    [self informDelegateOfPieceChangedAtColumn:-1 andRow:-1];
}

-(void) highlightMovesForPieceAtColumn:(NSUInteger)column andRow:(NSUInteger)row
{
    NSMutableArray* allHighlighting = [self getHighlightedSquaresFromPieceAtColumn:column andRow:row];
    NSMutableArray* properHighlighting = [[NSMutableArray alloc] init];
    for (DDHTuple *location in allHighlighting){
        if ([self doesPieceAtColumn:[location x] andRow:[location y] notBelongToPlayer:_nextMove]) {
            [properHighlighting addObject:location];
        }
    }
    
    for (DDHTuple *location in properHighlighting){
        [self highlightAtColumn:[location x] andRow: [location y]];
        [self informDelegateOfPieceChangedAtColumn:[location x] andRow:[location y]];
    }
}

// PRIVATE
-(NSMutableArray*) getHighlightedSquaresFromPieceAtColumn: (NSUInteger) column andRow:(NSUInteger) row
{
    DDHPiece* piece = [self pieceAtColumn:column andRow:row];
    NSString* pieceDescription = [piece description];
    if ([pieceDescription isEqualToString:@"NullPiece"])
        return [[NSMutableArray alloc] init];
    
    NSMutableArray* highlighting = [piece highlightMovesWithBoard:self];
    _locOfHighlightOwner = [[DDHTuple alloc] initWithX:column andY:row];
    [self informDelegateOfPieceChangedAtColumn:column andRow:row];
    return highlighting;
}

// PRIVATE
-(void) highlightAtColumn:(NSInteger)column andRow:(NSInteger)row;
{
    _highlightBoard[column][row] = YES;
}

// PRIVATE
-(void)informDelegateOfPieceChangedAtColumn:(NSInteger)column andRow:(NSInteger) row
{
    if([_delegate respondsToSelector:@selector(pieceChangedAtColumn:addRow:)])
        [_delegate pieceChangedAtColumn:column addRow:row];
}


// ******************************
// ** General Helper Functions **
// ******************************

// PRIVATE
-(void)checkBoundsForColumn: (NSInteger) column andRow: (NSInteger) row
{
    if (column < 0 || column >= _columns || row < 0 || row >= _rows)
        [NSException raise:NSRangeException format:@"row or column out of bounds"];
}


@end
