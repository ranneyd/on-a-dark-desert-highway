//
//  DDHBoard.m - Implementation of the main board class
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
    DDH2DArray* _pieces; // Contains the location of pieces in the board
    id<DDHBoardDelegate> _delegate; // To communicate with the views to update UI
    DDHTuple* _locOfHighlightOwner; // Keeps track of location of selected piece
    NSUInteger _rows; // Number of rows in the board
    NSUInteger _columns; // Number of columns in the board
    
    // TODO CHANGE FOR DYNAMICALLY SIZED BOARD
    BOOL _highlightBoard[8][8]; // Which parts of the board are currently highlighted
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
        
        // Initialized the empty board
        [self clearBoard];
        
        // Create the delegate to communicate with the views
        _boardDelegate = [[DDHMulticastDelegate alloc] init];
        _delegate = (id)_boardDelegate;
    }
    return self;
}

-(void) setToInitialState
{
    // Clear le board
    [self clearBoard];
    
    // Create a list of tuples that correspond to the initial piece layout. Change for custom layout
    NSArray *whitePositions = [NSArray arrayWithObjects:
                               [[DDHTuple alloc] initWithX:0 andY:0], [[DDHTuple alloc] initWithX:1 andY:0],
                               [[DDHTuple alloc] initWithX:2 andY:0], [[DDHTuple alloc] initWithX:3 andY:0],
                               [[DDHTuple alloc] initWithX:4 andY:0], [[DDHTuple alloc] initWithX:5 andY:0],
                               [[DDHTuple alloc] initWithX:6 andY:0], [[DDHTuple alloc] initWithX:7 andY:0],
                               [[DDHTuple alloc] initWithX:0 andY:1], [[DDHTuple alloc] initWithX:1 andY:1],
                               [[DDHTuple alloc] initWithX:2 andY:1], [[DDHTuple alloc] initWithX:3 andY:1],
                               [[DDHTuple alloc] initWithX:4 andY:1], [[DDHTuple alloc] initWithX:5 andY:1],
                               [[DDHTuple alloc] initWithX:6 andY:1], [[DDHTuple alloc] initWithX:7 andY:1],nil];
    NSArray *whitePieces = [NSArray arrayWithObjects:
                            [DDHRook   class], [DDHKnight class],
                            [DDHBishop class], [DDHQueen  class],
                            [DDHKing   class], [DDHBishop class],
                            [DDHKnight class], [DDHRook   class],
                            [DDHPawn class], [DDHPawn class],
                            [DDHPawn class], [DDHPawn class],
                            [DDHPawn class], [DDHPawn class],
                            [DDHPawn class], [DDHPawn class],nil];
//    NSDictionary *whiteDict = [NSDictionary dictionaryWithObjects:whitePieces forKeys:whitePositions];
    NSArray *blackPositions = [NSArray arrayWithObjects:
                               [[DDHTuple alloc] initWithX:0 andY:6], [[DDHTuple alloc] initWithX:1 andY:6],
                               [[DDHTuple alloc] initWithX:2 andY:6], [[DDHTuple alloc] initWithX:3 andY:6],
                               [[DDHTuple alloc] initWithX:4 andY:6], [[DDHTuple alloc] initWithX:5 andY:6],
                               [[DDHTuple alloc] initWithX:6 andY:6], [[DDHTuple alloc] initWithX:7 andY:6],
                               [[DDHTuple alloc] initWithX:0 andY:7], [[DDHTuple alloc] initWithX:1 andY:7],
                               [[DDHTuple alloc] initWithX:2 andY:7], [[DDHTuple alloc] initWithX:3 andY:7],
                               [[DDHTuple alloc] initWithX:4 andY:7], [[DDHTuple alloc] initWithX:5 andY:7],
                               [[DDHTuple alloc] initWithX:6 andY:7], [[DDHTuple alloc] initWithX:7 andY:7],nil];
    NSArray *blackPieces = [NSArray arrayWithObjects:
                            [DDHPawn class], [DDHPawn class],
                            [DDHPawn class], [DDHPawn class],
                            [DDHPawn class], [DDHPawn class],
                            [DDHPawn class], [DDHPawn class],
                            [DDHRook   class], [DDHKnight class],
                            [DDHBishop class], [DDHQueen  class],
                            [DDHKing   class], [DDHBishop class],
                            [DDHKnight class], [DDHRook   class],nil];
//    NSDictionary *blackDict = [NSDictionary dictionaryWithObjects:blackPieces forKeys:blackPositions];
//
//    // Loop through all positions and place the correct pieces
//    for (DDHTuple *pos in whiteDict) {
//        NSInteger x = [pos x];
//        NSInteger y = [pos y];
//        [_pieces replaceObjectAtColumn:x andRow:y withObject:
//                [[DDHPawn alloc]initWithPlayer:ChessPlayerWhite atColumn:x andRow:y]];
//    }
    
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
    
    // Nobody has highlighted anything yet, so make it out of bounds
    _locOfHighlightOwner = [[DDHTuple alloc] initWithX:_columns + 1 andY:_rows + 1];
    
    // Set who gets to move first
    _nextMove = ChessPlayerBlack;
}


-(void) clearBoard
{
    // Someone figure out if this takes advantage of spacial locality (?????)
    
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
    // Verify piece is inbounds and if so return it
    [self checkBoundsForColumn:column andRow:row];
    return [_pieces objectAtColumn:column andRow:row];
}

-(BOOL) isEmptySquareAtColumn:(NSInteger)column andRow:(NSInteger)row
{
    // If the piece we find is null, then the square is empty
    DDHPiece* piece = [self pieceAtColumn:column andRow:row];
    NSString* pieceDescription = [piece description];
    return [pieceDescription isEqualToString:@"NullPiece"];
}

-(void) makeMoveToColumn:(NSUInteger) column andRow:(NSUInteger) row
{
    // Move the selected piece with private function
    [self movePieceAtColumn:[_locOfHighlightOwner x] andRow:[_locOfHighlightOwner y] ToColumn:column andRow:row];

}

// PRIVATE
-(void) movePieceAtColumn:(NSInteger)oldColumn andRow:(NSUInteger)oldRow ToColumn:(NSInteger)column andRow:(NSInteger)row
{
    // Get the piece from _pieces
    DDHPiece* piece = [self pieceAtColumn:oldColumn andRow:oldRow];
    
    // Make sure the piece's internal x and y are updated to the new position
    [piece moveToColumn:column andRow:row];
    
    // Change the old position in the board array to empty
    [_pieces replaceObjectAtColumn:oldColumn andRow:oldRow withObject:[[DDHNullPiece alloc] init]];
    
    // Change the new position in the board to our piece index
    [_pieces replaceObjectAtColumn:column andRow:row withObject:piece];
    
    // Clear the highlighting
    [self clearHighlighting];
    
    // Tell the correct views to update
    [self informDelegateOfPieceChangedAtColumn:oldColumn andRow:oldRow];
    [self informDelegateOfPieceChangedAtColumn:column andRow:row];
    
    // Switch turns
    [self invertState];
}


// ***************************
// ** Additional Game Logic **
// ***************************

-(BOOL) doesPieceAtColumn:(NSInteger)column andRow:(NSInteger)row notBelongToPlayer:(ChessPlayer)player
{
    // If there's a piece in the spot, check who's it is
    if (![self isEmptySquareAtColumn:column andRow:row]) {
        DDHPiece* piece = [self pieceAtColumn:column andRow:row];
        return [piece getPlayer] != _nextMove;
    }
    // If it's empty, then it doesn't belong to the player
    return YES;
}

-(BOOL) isHighlightOwnerAtColumn:(NSUInteger)column andRow:(NSUInteger)row
{
    // Veryfy that highlighted piece is at the given row and column
    return [_locOfHighlightOwner x] == column && [_locOfHighlightOwner y] == row;
}

-(void)invertState
{
    // If white just moved, then black is next, and vice versa
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
    // Check to see if the location should be/is highlighted
    return _highlightBoard[column][row] == YES;
}


-(void) clearHighlighting
{
    // Loop through all positions and remove highlighting
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
    // Get all possible moves that a piece can make
    NSMutableArray* allHighlighting = [self getHighlightedSquaresFromPieceAtColumn:column andRow:row];
    // Create a way to keep track of what spaces a piece can actually move to (i.e. not taking it's own color piece)
    NSMutableArray* properHighlighting = [[NSMutableArray alloc] init];
    
    // Filter out all moves that would land on a piece of the same color
    for (DDHTuple *location in allHighlighting){
        if ([self doesPieceAtColumn:[location x] andRow:[location y] notBelongToPlayer:_nextMove]) {
            [properHighlighting addObject:location];
        }
    }
    // Highlight each space and tell the views to update
    for (DDHTuple *location in properHighlighting){
        [self highlightAtColumn:[location x] andRow: [location y]];
        [self informDelegateOfPieceChangedAtColumn:[location x] andRow:[location y]];
    }
}

// PRIVATE
-(NSMutableArray*) getHighlightedSquaresFromPieceAtColumn: (NSUInteger) column andRow:(NSUInteger) row
{
    // Find the piece at the given location
    DDHPiece* piece = [self pieceAtColumn:column andRow:row];
    // If the space was empty, it can't move anywhere
    NSString* pieceDescription = [piece description];
    if ([pieceDescription isEqualToString:@"NullPiece"])
        return [[NSMutableArray alloc] init];
    
    // Get the moves the piece can make
    NSMutableArray* highlighting = [piece highlightMovesWithBoard:self];
    // Mark that piece as selected
    _locOfHighlightOwner = [[DDHTuple alloc] initWithX:column andY:row];
    // Update the UI to show the selection
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
    // Check if the delegate knows how to respond, and then tell it that a change was made
    if([_delegate respondsToSelector:@selector(pieceChangedAtColumn:addRow:)])
        [_delegate pieceChangedAtColumn:column addRow:row];
}


// ******************************
// ** General Helper Functions **
// ******************************

// PRIVATE
-(void)checkBoundsForColumn: (NSInteger) column andRow: (NSInteger) row
{
    // Make sure that the col and row are valid (i.e. actually on the board)
    if (column < 0 || column >= _columns || row < 0 || row >= _rows)
        [NSException raise:NSRangeException format:@"row or column out of bounds"];
}


@end
