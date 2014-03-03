//
//  DDHBoard.m
//  DDHChess
//
//  Created by Colin Eberhardt and modified by Dustin Kane, Will Clausen and Zakkai Davidson on 2/15/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHBoard.h"
#import "DDHBoardDelegate.h"
#import "DDHKnight.h"

@implementation DDHBoard
{
    // CHANGE FOR DYNAMICALLY SIZED BOARD
    
    // 2D array representing which pieces are in each board location.
    DDH2DArray* _pieces;
    // 2D array representing which parts of the board are currently highlighted
    BOOL _highlightBoard[8][8];
    id<DDHBoardDelegate> _delegate;
    DDHTuple* _locOfHighlightOwner;
    
    NSUInteger _rows;
    NSUInteger _columns;
}

- (id) init
{
    if (self = [super init]){
        _rows = 8;
        _columns = 8;
        _pieces = [[DDH2DArray alloc] initWithColumns:_rows andRow:_columns];
        [self clearBoard];
        [_pieces replaceObjectAtColumn:1 andRow:1 withObject:[[DDHKnight alloc]initWithPlayer:ChessPlayerWhite atColumn:1 andRow:1]];
        _boardDelegate = [[DDHMulticastDelegate alloc] init];
        _delegate = (id)_boardDelegate;
    }
    return self;
}

-(void) setToInitialState
{
    // clear le board
    
    [self clearBoard];
    
    // Put in the board setup
    
    _nextMove = ChessPlayerBlack;
}

-(void)invertState
{
    if ([self nextMove] == ChessPlayerBlack)
        self.nextMove = ChessPlayerWhite;
    self.nextMove = ChessPlayerBlack;
}

- (DDHPiece*) pieceAtColumn:(NSInteger)column andRow:(NSInteger)row
{
    [self checkBoundsForColumn:column andRow:row];
    return [_pieces objectAtColumn:column andRow:row];
}

-(void) putPiece:(DDHPiece *)piece inColumn:(NSInteger)column andRow:(NSInteger)row
{
    [self checkBoundsForColumn:column andRow:row];
    [_pieces replaceObjectAtColumn:column andRow:row withObject:piece];
    [self informDelegateOfStateChanged:state forColumn:column andRow:row];
}

-(BOOL) isEmptySquareAtColumn:(NSInteger)column andRow:(NSInteger)row
{
    return [_pieces objectAtColumn:column andRow:row] == NULL;
}

-(BOOL) highlightedAtColumn:(NSInteger)column andRow:(NSInteger)row
{
    return _highlightBoard[column][row] != -1;
}

-(void) movePieceAtColumn:(NSInteger)oldColumn andRow:(NSUInteger)oldRow ToColumn:(NSInteger)column andRow:(NSInteger)row
{
    // Get the piece from _pieces
    DDHPiece* piece = [_pieces objectAtColumn:oldColumn andRow:oldRow];
    // Get old position of the piece
    
    // Make sure the piece's internal x and y are updated to the new position
    [piece moveToColumn:column andRow:row];
    
    // Change the old position in the board array to empty
    [_pieces replaceObjectAtColumn:oldColumn andRow:oldRow withObject:nil];
    
    // Change the new position in the board to our piece index
    [_pieces replaceObjectAtColumn:column andRow:row withObject:piece];
    
    // Clear the highlighting
    [self clearHighlighting];
    
    [self invertState];
}

-(void)informDelegateOfPieceChanged:(DDHPiece*) piece forColumn:(NSInteger)column andRow:(NSInteger) row
{
    if([_delegate respondsToSelector:@selector(cellPieceChanged:forColumn:addRow:)])
        [_delegate cellPieceChanged:piece forColumn:column addRow:row];
}


-(void)checkBoundsForColumn: (NSInteger) column andRow: (NSInteger) row
{
    if (column < 0 || column >= _columns || row < 0 || row >= _rows)
        [NSException raise:NSRangeException format:@"row or column out of bounds"];
}

// Someone figure out if this takes advantage of spacial locality
-(void) clearBoard
{
    [self clearHighlighting];
    for(int i = 0; i < [_pieces rows]; i++){
        for(int j = 0; j < [_pieces columns]; j++){
            [_pieces replaceObjectAtColumn:j andRow:i withObject:NULL];
        }
    }
    //[self informDelegateOfStateChanged:BoardCellStateEmpty forColumn:-1 andRow:-1];
}
-(void) highlightAtColumn:(NSInteger)column andRow:(NSInteger)row;
{
    _highlightBoard[column][row] = YES;
}

-(void) clearHighlighting
{
    for(int i = 0; i < _rows; i++)
        for(int j = 0; i < _columns; j++)
            _highlightBoard[i][j] = NO;
}


-(NSMutableArray*) getHighlightedSquaresFromPieceAtColumn: (NSUInteger) column andRow:(NSUInteger) row
{
    DDHPiece* piece = [self pieceAtColumn:column andRow:row];
    if (piece == nil)
        return nil;
    NSMutableArray* highlighting = [piece highlightMovesWithBoard:_pieces];
    _locOfHighlightOwner = [[DDHTuple alloc] initWithX:column andY:row];
    for (DDHTuple *location in highlighting){
        [self highlightAtColumn:[location x] andRow: [location y]];
    }
    return highlighting;
}
-(void) moveHighlightOwnerToColumn:(NSUInteger)columnn AndRow:(NSUInteger)row
{
    [self movePieceAtColumn:[_locOfHighlightOwner x] andRow:[_locOfHighlightOwner y] ToColumn:columnn andRow:row];
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

@end
