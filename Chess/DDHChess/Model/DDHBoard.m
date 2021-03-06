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
#import "DDHDragon.h"
#import "DDHRandomSquare.h"
#import "RandomSquare.h"

@interface DDHBoard ()

// ***********************
// ** Private Functions **
// ***********************


-(id) initWithPieces:(DDH2DArray*) pieces andColumns:(NSUInteger) columns andRows:(NSUInteger) rows;

// Return an array of blank highlighting
-(DDH2DArray*) getBlankHighlighting;

// ************************************
// ** Piece Interaction and Movement **
// ************************************


// ***************************
// ** Additional Game Logic **
// ***************************

// Checks to see if the current player is in checkmate
-(BOOL) checkForCheckmate;

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
    DDH2DArray* _highlightBoard; // Which parts of the board are currently highlighted
    
    DDH2DArray* _randomSquares;
    
    // Keep track of the kings
    DDHKing* whiteKing;
    DDHKing* blackKing;
    
    // Keep track of whether or not castling is happening
    BOOL _castling;
    
    // Double jumping pawns for en passant
    DDHPiece* _pawnThatDoubleMovedLastTurn;
    
    BOOL _luke;
    BOOL _vader;
    
    // Information about random squares
    NSInteger _currentRandomSquares; // Only accounts for active squares
    NSInteger _maxRandomSquares; // Parameter set in setToInitialRandomState
    
}

// ********************
// ** Initialization **
// ********************

- (id) initWithView:(DDHRandomChessController *)controller
{
    if (self = [super init]){
        // Set the size of the board. TODO: Change for dynamically allocated array.
        _rows = 8;
        _columns = 8;
        
        // Initialize the array of pieces. Set all pieces on the board to null pieces initially (i.e. set the board
        // to be completely empty).
        _pieces = [[DDH2DArray alloc] initWithColumns:_rows andRow:_columns andObject:[[DDHNullPiece alloc] init]];
        
        _randomSquares = [[DDH2DArray alloc] initWithColumns:_rows andRow:_columns andObject:[[DDHRandomSquare alloc] initNull]];
        
        _highlightBoard = [self getBlankHighlighting];
        
        // Initialized the empty board
        [self clearBoard];
        
        // Create the delegate to communicate with the views
        _boardDelegate = [[DDHMulticastDelegate alloc] init];
        _delegate = (id)_boardDelegate;
        
        _controller = controller;
        [self setLuke:NO];
        [self setVader:NO];
    }
    return self;
}

-(id) initWithPieces:(DDH2DArray*) pieces andColumns:(NSUInteger) columns andRows:(NSUInteger) rows
{
    if (self = [super init]){
        // Set the size of the board. TODO: Change for dynamically allocated array.
        _rows = rows;
        _columns = columns;
        
        // Initialize the array of pieces. Set all pieces on the board to null pieces initially (i.e. set the board
        // to be completely empty).
        _pieces = [pieces copy];
        
        // Initialized the empty board
        [self clearBoard];
        

    }
    return self;
}

-(void) setToInitialState
{
    // Clear le board
    [self clearBoard];
    
    // Place the white pieces
    [_pieces replaceObjectAtColumn:0 andRow:6 withObject:[[DDHPawn alloc]initWithPlayer:ChessPlayerWhite atColumn:0 andRow:6]];
    [_pieces replaceObjectAtColumn:1 andRow:6 withObject:[[DDHPawn alloc]initWithPlayer:ChessPlayerWhite atColumn:1 andRow:6]];
    [_pieces replaceObjectAtColumn:2 andRow:6 withObject:[[DDHPawn alloc]initWithPlayer:ChessPlayerWhite atColumn:2 andRow:6]];
    [_pieces replaceObjectAtColumn:3 andRow:6 withObject:[[DDHPawn alloc]initWithPlayer:ChessPlayerWhite atColumn:3 andRow:6]];
    [_pieces replaceObjectAtColumn:4 andRow:6 withObject:[[DDHPawn alloc]initWithPlayer:ChessPlayerWhite atColumn:4 andRow:6]];
    [_pieces replaceObjectAtColumn:5 andRow:6 withObject:[[DDHPawn alloc]initWithPlayer:ChessPlayerWhite atColumn:5 andRow:6]];
    [_pieces replaceObjectAtColumn:6 andRow:6 withObject:[[DDHPawn alloc]initWithPlayer:ChessPlayerWhite atColumn:6 andRow:6]];
    [_pieces replaceObjectAtColumn:7 andRow:6 withObject:[[DDHPawn alloc]initWithPlayer:ChessPlayerWhite atColumn:7 andRow:6]];

    [_pieces replaceObjectAtColumn:0 andRow:7 withObject:[[DDHRook alloc]initWithPlayer:ChessPlayerWhite atColumn:0 andRow:7]];
    [_pieces replaceObjectAtColumn:1 andRow:7 withObject:[[DDHKnight alloc]initWithPlayer:ChessPlayerWhite atColumn:1 andRow:7]];
    [_pieces replaceObjectAtColumn:2 andRow:7 withObject:[[DDHBishop alloc]initWithPlayer:ChessPlayerWhite atColumn:2 andRow:7]];
    [_pieces replaceObjectAtColumn:3 andRow:7 withObject:[[DDHQueen alloc]initWithPlayer:ChessPlayerWhite atColumn:3 andRow:7]];
    [_pieces replaceObjectAtColumn:4 andRow:7 withObject:[[DDHKing alloc]initWithPlayer:ChessPlayerWhite atColumn:4 andRow:7]];
    [_pieces replaceObjectAtColumn:5 andRow:7 withObject:[[DDHBishop alloc]initWithPlayer:ChessPlayerWhite atColumn:5 andRow:7]];
    [_pieces replaceObjectAtColumn:6 andRow:7 withObject:[[DDHKnight alloc]initWithPlayer:ChessPlayerWhite atColumn:6 andRow:7]];
    [_pieces replaceObjectAtColumn:7 andRow:7 withObject:[[DDHRook alloc]initWithPlayer:ChessPlayerWhite atColumn:7 andRow:7]];
    
    // Black pieces
    [_pieces replaceObjectAtColumn:0 andRow:1 withObject:[[DDHPawn alloc]initWithPlayer:ChessPlayerBlack atColumn:0 andRow:1]];
    [_pieces replaceObjectAtColumn:1 andRow:1 withObject:[[DDHPawn alloc]initWithPlayer:ChessPlayerBlack atColumn:1 andRow:1]];
    [_pieces replaceObjectAtColumn:2 andRow:1 withObject:[[DDHPawn alloc]initWithPlayer:ChessPlayerBlack atColumn:2 andRow:1]];
    [_pieces replaceObjectAtColumn:3 andRow:1 withObject:[[DDHPawn alloc]initWithPlayer:ChessPlayerBlack atColumn:3 andRow:1]];
    [_pieces replaceObjectAtColumn:4 andRow:1 withObject:[[DDHPawn alloc]initWithPlayer:ChessPlayerBlack atColumn:4 andRow:1]];
    [_pieces replaceObjectAtColumn:5 andRow:1 withObject:[[DDHPawn alloc]initWithPlayer:ChessPlayerBlack atColumn:5 andRow:1]];
    [_pieces replaceObjectAtColumn:6 andRow:1 withObject:[[DDHPawn alloc]initWithPlayer:ChessPlayerBlack atColumn:6 andRow:1]];
    [_pieces replaceObjectAtColumn:7 andRow:1 withObject:[[DDHPawn alloc]initWithPlayer:ChessPlayerBlack atColumn:7 andRow:1]];
    
    [_pieces replaceObjectAtColumn:0 andRow:0 withObject:[[DDHRook alloc]initWithPlayer:ChessPlayerBlack atColumn:0 andRow:0]];
    [_pieces replaceObjectAtColumn:1 andRow:0 withObject:[[DDHKnight alloc]initWithPlayer:ChessPlayerBlack atColumn:1 andRow:0]];
    [_pieces replaceObjectAtColumn:2 andRow:0 withObject:[[DDHBishop alloc]initWithPlayer:ChessPlayerBlack atColumn:2 andRow:0]];
    [_pieces replaceObjectAtColumn:3 andRow:0 withObject:[[DDHQueen alloc]initWithPlayer:ChessPlayerBlack atColumn:3 andRow:0]];
    [_pieces replaceObjectAtColumn:4 andRow:0 withObject:[[DDHKing alloc]initWithPlayer:ChessPlayerBlack atColumn:4 andRow:0]];
    [_pieces replaceObjectAtColumn:5 andRow:0 withObject:[[DDHBishop alloc]initWithPlayer:ChessPlayerBlack atColumn:5 andRow:0]];
    [_pieces replaceObjectAtColumn:6 andRow:0 withObject:[[DDHKnight alloc]initWithPlayer:ChessPlayerBlack atColumn:6 andRow:0]];
    [_pieces replaceObjectAtColumn:7 andRow:0 withObject:[[DDHRook alloc]initWithPlayer:ChessPlayerBlack atColumn:7 andRow:0]];
    
    // Nobody has highlighted anything yet, so make it out of bounds
    _locOfHighlightOwner = [[DDHTuple alloc] initWithX:_columns + 1 andY:_rows + 1];
    
    // Save pointers to the kings for check purposes.
    whiteKing = [_pieces objectAtColumn:4 andRow:7];
    blackKing = [_pieces objectAtColumn:4 andRow:0];
    
    // Set who gets to move first
    _nextMove = ChessPlayerWhite;
    
    // Flags to handle special piece movements and rules
    _castling = NO;
    _pawnThatDoubleMovedLastTurn = nil;
    
    NSLog(@"Life Happened");
}

-(void) setToInitialRandomState
{
    [self setToInitialState];

    // Set to determine number of random squares that can be on the board at one time
    _maxRandomSquares = 4;
    
    // Start with no squares
    _currentRandomSquares = 0;
    
    // Get some random postions and place the correct number of squares
    for (long i = 0; i < _maxRandomSquares; ++i){
        // Get a random location on the board
        DDHTuple* newLocation = [self getRandomEmptyPosition];
        NSLog(@"Creating new square at (%li,%li)", [newLocation x], [newLocation y]);
        [_randomSquares replaceObjectAtColumn:[newLocation x] andRow:[newLocation y] withObject:[[DDHRandomSquare alloc] initWithColumn:[newLocation x] andRow:[newLocation y] andBoard:self andDelegate:_delegate]];
        ++_currentRandomSquares;
    }
    
    NSLog(@"Life Happened");
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

// Create a copy of the entire board
// Modeled after question by fuzzygoat on http://stackoverflow.com/questions/9907154/best-practice-when-implementing-copywithzone
-(id) copyWithZone:(NSZone *)zone {
    // Create a new DDHBoard object to be the copy
    DDHBoard* boardCopy = [[[self class] allocWithZone:zone] init];
    
    // If the boardCopy was created, copy each of the values from self to this copy
    if(boardCopy){
        boardCopy->_rows = _rows;
        boardCopy->_columns = _columns;
        boardCopy->_pieces = [_pieces copyWithZone:zone];
        boardCopy->_highlightBoard = [_highlightBoard copyWithZone:zone];
        boardCopy->_boardDelegate = _boardDelegate;
        boardCopy->_delegate = nil;
        boardCopy->_nextMove = _nextMove;
        boardCopy->_locOfHighlightOwner = _locOfHighlightOwner;
        boardCopy->blackKing = [boardCopy->_pieces objectAtColumn:[blackKing x] andRow:[blackKing y]];
        boardCopy->whiteKing = [boardCopy->_pieces objectAtColumn:[whiteKing x] andRow:[whiteKing y]];
        boardCopy->_castling = _castling;
        boardCopy->_pawnThatDoubleMovedLastTurn = [boardCopy->_pieces objectAtColumn:[_pawnThatDoubleMovedLastTurn x] andRow:[_pawnThatDoubleMovedLastTurn y]];
        boardCopy->_controller = _controller;
        boardCopy->_randomSquares = _randomSquares;
        boardCopy->_currentRandomSquares = _currentRandomSquares;
        boardCopy->_maxRandomSquares = _maxRandomSquares;
    }
    return boardCopy;
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

-(DDHPiece*) getPawnThatDoubleMovedLastTurn
{
    return _pawnThatDoubleMovedLastTurn;
}

-(void) setHighlighterwithColumn:(NSUInteger) column andRow:(NSUInteger) row
{
    _locOfHighlightOwner = [[DDHTuple alloc] initWithX:column andY:row];
}

-(DDH2DArray*) getBlankHighlighting
{
    DDH2DArray* highlighting = [[DDH2DArray alloc] initWithColumns:_columns andRow:_rows andObject:[NSNumber numberWithBool:NO]];
    return highlighting;
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
    return [pieceDescription isEqualToString:@"NullPiece"] && [self hasNoWallAtColumn:column andRow:row];
}

-(void) makeMoveToColumn:(NSUInteger) column andRow:(NSUInteger) row
{    
    if (![[self pieceAtColumn:column andRow:row]isKindOfClass:[DDHNullPiece class]]){
        [self informDelegateOfExplosionAtColumn:column andRow:row];
    }
    // Move the selected piece with private function
    [self movePieceAtColumn:[_locOfHighlightOwner x] andRow:[_locOfHighlightOwner y] ToColumn:column andRow:row];
    [self afterMoveFromColumn:[_locOfHighlightOwner x] andRow:[_locOfHighlightOwner y] ToColumn:column andRow:row];
}

-(void) movePieceAtColumn:(NSInteger)oldColumn andRow:(NSUInteger)oldRow ToColumn:(NSInteger)column andRow:(NSInteger)row
{
    // Get the piece from _pieces
    DDHPiece* piece = [self pieceAtColumn:oldColumn andRow:oldRow];
    
    // Check Castling
    if ([piece isKindOfClass:[DDHKing class]]){
        if(column == [piece x] - 2){
            _castling = YES;
            [self movePieceAtColumn:0 andRow:oldRow ToColumn:3 andRow:oldRow];
            [self afterMoveFromColumn:0 andRow:oldRow ToColumn:3 andRow:oldRow];
        }
        if(column == [piece x] + 2){
            _castling = YES;
            [self movePieceAtColumn:[self getColumns]-1 andRow:oldRow ToColumn:[self getColumns] -3 andRow:oldRow];
            [self afterMoveFromColumn:[self getColumns]-1 andRow:oldRow ToColumn:[self getColumns] -3 andRow:oldRow];
        }
        
    }
    
    // Check en passant
    if ([piece isKindOfClass:[DDHPawn class]]){
        // If the piece to the left or the right of the pawn is the double jumped pawn, and is of the opposite color, then we can take it
        if(([self pieceAtColumn:column andRow:[piece y]] == _pawnThatDoubleMovedLastTurn) &&
                         [self doesPieceAtColumn:column andRow:row notBelongToPlayer:_nextMove]){
            [self destroyPieceAtColumn:column andRow:[piece y]];
        }
    }
    
    
    // Make sure the piece's internal x and y are updated to the new position
    [piece moveToColumn:column andRow:row];
    
    // Change the old position in the board array to empty
    [_pieces replaceObjectAtColumn:oldColumn andRow:oldRow withObject:[[DDHNullPiece alloc] init]];
    
    // Change the new position in the board to our piece index
    [_pieces replaceObjectAtColumn:column andRow:row withObject:piece];
    //NSLog(@"Moved the %@ to (%lu, %lu), but the king is at (%lu, %lu)", piece, column, row, [whiteKing x], [whiteKing y]);

}

-(void) afterMoveFromColumn:(NSInteger)oldColumn andRow:(NSUInteger)oldRow ToColumn:(NSInteger)column andRow:(NSInteger)row
{
    // Check if double move pawn flag from last turn should be reset
    if (_pawnThatDoubleMovedLastTurn) {
        _pawnThatDoubleMovedLastTurn = nil;
    }
    
    // Get the piece from _pieces
    DDHPiece* piece = [self pieceAtColumn:column andRow:row];
    
    // Check for pawn promotion after movement and change flags for en passant
    if([piece isKindOfClass:[DDHPawn class]]){
        // Pawn promotion
        
        // If a black pawn has made it to the top, make it a queen
        if(row == 0){
            [_pieces replaceObjectAtColumn:column andRow:row withObject:[[DDHQueen alloc] initWithPlayer:ChessPlayerWhite atColumn:column andRow:row]];
        }
        // If a white pawn has made it to the bottom, make it a queen
        if(row == _columns - 1){
            [_pieces replaceObjectAtColumn:column andRow:row withObject:[[DDHQueen alloc] initWithPlayer:ChessPlayerBlack atColumn:column andRow:row]];
        }
        
        // En passant TODO
        
        // If the pawn moved two spaces, then update it's flag
        if((row == oldRow - 2) || (row == oldRow + 2)){
            _pawnThatDoubleMovedLastTurn = piece;
        }
    }
    
    // Check for special dragon moves
    if([piece isKindOfClass:[DDHDragon class]]){
        NSLog(@"Dragon has moved!!!!");
        // Blow up squares to each side
        [(DDHDragon *)piece explodeAfterMoveOnBoard:self];
    }
    
    // Clear the highlighting
    [self clearHighlighting];
    
    // Tell the correct views to update
    [self informDelegateOfPieceChangedAtColumn:oldColumn andRow:oldRow];
    [self informDelegateOfPieceChangedAtColumn:column andRow:row];
    
    // Handle if the piece landed on a random square
    if([self randomAtColumn:column andRow:row]){
        [_delegate randomLandAtColumn:column addRow:row withSquare:[_randomSquares objectAtColumn:column andRow:row]];
        --_currentRandomSquares;
        [self updateRandomSquares];
    }
    
    // Switch turns if we aren't castling
    if(!_castling){
        [self invertState];
    } else {
        _castling = NO;
    }

    [self checkUpdate];
    
}

-(void) checkUpdate
{
    // See if next player is now in check
    BOOL check =[self kingInCheckBelongingTo:[self nextMove]];
    
    DDHChessInfoView* info = [_controller info];
    
    if (check){
        [[info check] setTextColor:[UIColor whiteColor]];
        [[info check2] setTextColor:[UIColor whiteColor]];
    }
    else{
        [[info check] setTextColor:[UIColor blackColor]];
        [[info check2] setTextColor:[UIColor blackColor]];
    }
    
    // Check if the move has put the player in checkmate, but actually checks if the player has no available moves
    if ([self checkForCheckmate]){
        //if you have no moves and are in check, then that's checkmate
        if(check){
            [[info check] setText:@"Checkmate!"];
            [[info check2] setText:@"Checkmate!"];
            [[info check] setTextColor:[UIColor whiteColor]];
            [[info check2] setTextColor:[UIColor whiteColor]];
        }
        else{
            [[info check] setText:@"Stalemate :("];
            [[info check2] setText:@"Stalemate :("];
            [[info check] setTextColor:[UIColor whiteColor]];
            [[info check2] setTextColor:[UIColor whiteColor]];
        }
    }
    [self clearHighlighting];
}

-(void) putPiece:(DDHPiece *)piece inColumn:(NSUInteger)column andRow:(NSUInteger) row
{
    [_pieces replaceObjectAtColumn:column andRow:row withObject:piece];
}


// ***************************
// ** Additional Game Logic **
// ***************************

-(BOOL) doesPieceAtColumn:(NSInteger)column andRow:(NSInteger)row notBelongToPlayer:(ChessPlayer)player
{
    // If there's a piece in the spot, check who's it is
    if (![self isEmptySquareAtColumn:column andRow:row]) {
        DDHPiece* piece = [self pieceAtColumn:column andRow:row];
        return ([piece getPlayer] != player && [self hasNoWallAtColumn:column andRow:row]);
    }
    // If it's empty, then it doesn't belong to the player
    return YES;
}

-(BOOL) hasNoWallAtColumn:(NSInteger)column andRow:(NSInteger)row
{
    // If there is an inactive FallThrough square, then we cant move there
    DDHRandomSquare *square = [_randomSquares objectAtColumn:column andRow:row];
    return !([square type] == FallThrough && ![square active]);
}

-(BOOL) isHighlightOwnerAtColumn:(NSUInteger)column andRow:(NSUInteger)row
{
    // Veryfy that highlighted piece is at the given row and column
    return [_locOfHighlightOwner x] == column && [_locOfHighlightOwner y] == row;
}

-(void)invertState
{
    // If white just moved, then black is next, and vice versa
    if ([self nextMove] == ChessPlayerBlack){
        self.nextMove = ChessPlayerWhite;
        NSLog(@"It's white's turn!");
        //[[_controller player] setText:@"White's Turn"];
    }
    else{
        self.nextMove = ChessPlayerBlack;
        NSLog(@"It's black's turn!");
        //[[_controller player] setText:@"Black's Turn"];
    }
    
    //reset pawn click counters
    
    for (int i = 0; i < _columns; i++){
        for(int j = 0; j < _rows; j++){
            DDHPiece *piece = [_pieces objectAtColumn:i andRow:j];
            if ([piece isKindOfClass:[DDHPawn class]]){
                [(DDHPawn *)piece setNumClicks:0];
            }
        }
    }
    
    // rotate
    
    [_delegate rotate];
   
}

-(BOOL) kingInCheckBelongingTo:(ChessPlayer)player
{
    // Iterate over the board
    for(int i = 0; i < _columns; i++){
        for (int j = 0; j < _rows; j++) {
            
            // Get a piece from the board
            DDHPiece *piece = [_pieces objectAtColumn:i andRow:j];
            
            // If the piece is not a null piece
            if(![piece isKindOfClass:[DDHNullPiece class]]){
                // If the piece is an enemy piece
                if(player != [piece getPlayer]){
                    // Get the enemy piece's moves
                    NSMutableArray *moves = [piece highlightMovesWithBoard:self andCheck:NO];
                    // look at each move
                    for (DDHTuple* move in moves){
                        // A piece cannot take its own teammate, so we don't have to worry about a potential move taking the player's own king
                        // If a piece has a move that can take a king, we know it's bad.
                        if(([move x] == [whiteKing x] && [move y] == [whiteKing y]) ||
                           ([move x] == [blackKing x] && [move y] == [blackKing y])){
                            //NSLog(@"You's in check dawg. Dat %@ can take you", piece);
                            return YES;
                        }
                    }
                }
            }
        }
    }
    return NO;
}

-(BOOL) checkIfMoveFromColumn:(NSUInteger) oldColumn andRow:(NSUInteger) oldRow toColumn:(NSUInteger) column andRow:(NSUInteger) row
{
    // Create a copy of the board
    DDHBoard* boardCopy = [self copy];
    
    // Moving piece. Checking if this piece moving would cause check
    DDHPiece* movingPiece = [boardCopy pieceAtColumn:oldColumn andRow:oldRow];

    // Move the moving piece to the new position.
    [boardCopy movePieceAtColumn:oldColumn andRow:oldRow ToColumn:column andRow:row];
    
    // If this move causes the player to be in check, we are moving into check
    BOOL movingIntoCheck = [boardCopy kingInCheckBelongingTo:[movingPiece getPlayer]];
    
    return movingIntoCheck;
    
}

-(BOOL) doesMoveFromColumn:(NSUInteger) oldColumn andRow:(NSUInteger) oldRow toColumn:(NSUInteger) column andRow:(NSUInteger) row causeCheckForPlayer: (ChessPlayer) player
{
    // Create a copy of the board
    DDHBoard* boardCopy = [self copy];
    
    // Move the moving piece to the new position.
    [boardCopy movePieceAtColumn:oldColumn andRow:oldRow ToColumn:column andRow:row];
    
    // If this move causes the player to be in check, we are moving into check
    return [boardCopy kingInCheckBelongingTo:player];
    
}

-(BOOL) doesDestructionCauseCheckAtColumn:(NSUInteger) column andRow:(NSUInteger) row
{
    // Create a copy of the board
    DDHBoard* boardCopy = [self copy];
    
    // Piece being destroyed
    DDHPiece* pieceToDie = [boardCopy pieceAtColumn:column andRow:row];
    
    // Destroy the piece and see what happens
    [boardCopy destroyPieceAtColumn:column andRow:row];
    
    // If this move causes the player to be in check, we are moving into check
    return [boardCopy kingInCheckBelongingTo:[pieceToDie getPlayer]];
}

-(BOOL) doesNewPiece: (DDHPiece *) piece atColumn: (NSInteger) column andRow: (NSInteger) row causeCheckForPlayer: (ChessPlayer) player
{
    // Create a copy of the board
    DDHBoard* boardCopy = [self copy];
    
    // Place the new piece on the board
    [boardCopy putPiece:piece inColumn:column andRow:row];
    
    // Check to see if the player is now in check
    return [boardCopy kingInCheckBelongingTo:player];
}


// PRIVATE
-(BOOL) checkForCheckmate
{
    BOOL checkmate = YES; // If no pieces can move
    BOOL dobreak = NO;
    for(int r=0; !dobreak && r<[self getRows]; ++r){
        for (int c=0; c<[self getColumns]; ++c) {
            if(![self doesPieceAtColumn:c andRow:r notBelongToPlayer:_nextMove]){
                NSMutableArray* highlighting = [self getHighlightedSquaresFromPieceAtColumn:c andRow:r];
                if([highlighting count]){
                    checkmate = NO; // If a piece can move, then the game keeps going
                    //NSLog(@"%@ at (%i,%i)can still move, so there's no checkmate", [self pieceAtColumn:c andRow:r], r,c);
                    //NSLog(@"it's moves are %@", highlighting);
                    dobreak = YES;
                    break;
                }
            }
        }
    }
    return checkmate;
}



-(void) destroyPieceAtColumn:(NSUInteger) column andRow:(NSUInteger) row
{
    [self informDelegateOfExplosionAtColumn:column andRow:row];
    [self checkBoundsForColumn:column andRow:row];
    [_pieces replaceObjectAtColumn:column andRow:row withObject:[[DDHNullPiece alloc] init]];
    [self informDelegateOfPieceChangedAtColumn:column andRow:row];
}

-(void) updateRandomSquares
{
    NSLog(@"current squares: %li", _currentRandomSquares);
    NSLog(@"max squares: %li", _maxRandomSquares);
    // Make more random squares when the number gets too low
    if (_currentRandomSquares < _maxRandomSquares){
        // Get a random location on the board
        DDHTuple* newLocation = [self getRandomEmptyPosition];
        
        // Figure out how many random squares to make
        NSInteger numberOfSquares = _maxRandomSquares - _currentRandomSquares;
        
        // Create more random squares to get back to the max
        for (long i = 0; i < numberOfSquares; ++i){
            NSLog(@"Creating new square at (%li,%li)", [newLocation x], [newLocation y]);
            [_randomSquares replaceObjectAtColumn:[newLocation x] andRow:[newLocation y] withObject:[[DDHRandomSquare alloc] initWithColumn:[newLocation x] andRow:[newLocation y] andBoard:self andDelegate:_delegate]];
            ++_currentRandomSquares;
            
            // Update the new location
            newLocation = [self getRandomEmptyPosition];
            
        }
        
        // Tell the delegate to update all the squares
        [self informDelegateOfPieceChangedAtColumn:-1 andRow:-1];
    }
}

-(DDHTuple *) getRandomEmptyPosition
{
    // Get a random position on the board
    NSInteger newCol = arc4random()%[self getColumns];
    NSInteger newRow = arc4random()%[self getRows];
    
    // Keep looking until the space is empty and doesn't contain a random square
    while (![self isEmptySquareAtColumn:newCol andRow:newRow] || [self randomAtColumn:newCol andRow:newRow]){
        newCol = arc4random()%[self getColumns];
        newRow = arc4random()%[self getRows];
    }
    
    return [[DDHTuple alloc] initWithX:newCol andY:newRow];
}

// *************************
// ** UI Helper Functions **
// *************************

-(BOOL) highlightedAtColumn:(NSInteger)column andRow:(NSInteger)row
{
    // Check to see if the location should be/is highlighted
    return [[_highlightBoard objectAtColumn:column andRow:row] boolValue] == YES;
}


-(void) clearHighlighting
{
    // Loop through all positions and remove highlighting
    for(int i = 0; i < _rows; i++)
    {
        for(int j = 0; j < _columns; j++)
        {
            [_highlightBoard replaceObjectAtColumn:i andRow:j withObject:[NSNumber numberWithBool:NO]];
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
    
    /*
    
    This should not be necessary. getHighlightedSquares should not give you squares with friendly pieces on them.
     
     
    // Create a way to keep track of what spaces a piece can actually move to (i.e. not taking it's own color piece)
    NSMutableArray* properHighlighting = [[NSMutableArray alloc] init];
    
    // Filter out all moves that would land on a piece of the same color
    for (DDHTuple *location in allHighlighting){
        if ([self doesPieceAtColumn:[location x] andRow:[location y] notBelongToPlayer:_nextMove]) {
            [properHighlighting addObject:location];
        }
    }
     
    // Highlight each space and tell the views to update
    for (DDHTuple *location in properHighlighting){*/
    for (DDHTuple* location in allHighlighting){
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
    NSMutableArray* highlighting = [piece highlightMovesWithBoard:self andCheck:YES];
    // Mark that piece as selected
    _locOfHighlightOwner = [[DDHTuple alloc] initWithX:column andY:row];
    // Update the UI to show the selection
    [self informDelegateOfPieceChangedAtColumn:column andRow:row];
    return highlighting;
}

// PRIVATE
-(void) highlightAtColumn:(NSInteger)column andRow:(NSInteger)row;
{
    [_highlightBoard replaceObjectAtColumn:column andRow:row withObject:[NSNumber numberWithBool:YES]];
}

// PRIVATE
-(void)informDelegateOfPieceChangedAtColumn:(NSInteger)column andRow:(NSInteger) row
{
    // Check if the delegate knows how to respond, and then tell it that a change was made
    if([_delegate respondsToSelector:@selector(pieceChangedAtColumn:addRow:)])
        [_delegate pieceChangedAtColumn:(int)column addRow:(int)row];
}
-(void)informDelegateOfExplosionAtColumn:(NSInteger)column andRow:(NSInteger) row
{
    // Check if the delegate knows how to respond, and then tell it that a change was made
    if([_delegate respondsToSelector:@selector(explodeAtColumn:addRow:)])
        [_delegate explodeAtColumn:(int)column addRow:(int)row];
}


-(BOOL) randomAtColumn:(NSUInteger)column andRow:(NSUInteger)row
{
    DDHRandomSquare *square = [_randomSquares objectAtColumn:column andRow:row];
    return [square type] != NullSquare && [square active];
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

-(BOOL) onBoardAtColumn :(NSInteger) column andRow:(NSInteger) row
{
    return column >= 0 && column < _columns && row >= 0 && row < _rows;
}
@end
