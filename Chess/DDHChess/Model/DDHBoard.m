//
//  DDHBoard.m
//  DDHChess
//
//  Created by Colin Eberhardt and modified by Dustin Kane, Will Clausen and Zakkai Davidson on 2/15/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHBoard.h"
#import "DDHBoardDelegate.h"

@implementation DDHBoard
{
    // CHANGE FOR DYNAMICALLY SIZED BOARD
    
    // List of piece pointers. Used to access piece objects
    NSMutableArray* _pieceList;
    // 2D array representing which pieces are in each board location.
    // Number represents index in _pieceList. -1 means empty
    NSUInteger _pieceBoard[8][8];
    // 2D array representing which parts of the board are currently highlighted
    // Number represents index in _pieceList. -1 means not highlighted
    NSUInteger _highlightBoard[8][8];
    id<DDHBoardDelegate> _delegate;
}

- (id) init
{
    if (self = [super init]){
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
    
    // Put in the board setup
    
    _nextMove = ChessPlayerBlack;
}

-(ChessPlayer)invertState:(ChessPlayer)state
{
    if (state == ChessPlayerBlack)
        return ChessPlayerWhite;
    return ChessPlayerBlack;
}

- (DDHPiece*) pieceAtColumn:(NSInteger)column andRow:(NSInteger)row
{
    [self checkBoundsForColumn:column andRow:row];
    NSUInteger piece = _pieceBoard[column][row];
    if (piece == -1)
        return nil;
    else
        return [_pieceList objectAtIndex:piece];
}

-(void) putPiece:(DDHPiece *)piece inColumn:(NSInteger)column andRow:(NSInteger)row
{
    [self checkBoundsForColumn:column andRow:row];
    // Since this is the size, or biggest index + 1, it should be the index of the thing we're about to add
    NSUInteger index = [_pieceList count];
    // Add the piece object to the list of pieces
    [_pieceList addObject:piece];
    // Add the index of the piece to the piece board.
    _pieceBoard[column][row] = index;
    //[self informDelegateOfStateChanged:state forColumn:column andRow:row];
}

-(BOOL) isEmptySquareAtColumn:(NSInteger)column andRow:(NSInteger)row
{
    return _pieceBoard[column][row] == -1;
}

-(id) pieceAtIndex:(int)index
{
    return [_pieceList objectAtIndex:index];
}

-(BOOL) highlightedAtColumn:(NSInteger)column andRow:(NSInteger)row
{
    return _highlightBoard[column][row] != -1;
}

-(void) moveToColumn:(NSInteger)column andRow:(NSInteger)row
{
    // Get _pieceList index of the piece we are moving. Theoretically, if we are moving to spot, that spot was
    // highlighted with the value of the piece index.
    NSUInteger pieceIndex = _highlightBoard[column][row];
    // Get the piece from the _pieceList
    DDHPiece* piece = [_pieceList objectAtIndex:pieceIndex];
    // Get old position of the piece
    NSUInteger oldX = [piece x];
    NSUInteger oldY = [piece y];
    
    // Make sure the piece's internal x and y are updated to the new position
    [piece moveToColumn:column andRow:row];
    
    // Kill old piece if there was one
    if (![self isEmptySquareAtColumn:column andRow:row]){
        // Find the piece index of the soon-to-be-dead piece
        NSInteger pieceInWay = _pieceBoard[column][row];
        // We don't want to remove the object because we don't want to screw up all the numbering, so we'll
        // replace it with nil
        [_pieceList replaceObjectAtIndex:pieceInWay withObject:nil];
    }
    // Change the old position in the board array to empty
    _pieceBoard[oldX][oldY] = -1;
    
    // Change the new position in the board to our piece index
    _pieceBoard[column][row] = pieceIndex;
    
    // Clear the highlighting
    [self clearHighlighting];
    
    // INVERT PLAYER STATE
}

-(void)informDelegateOfStateChanged:(BoardCellState) state forColumn:(NSInteger)column andRow:(NSInteger) row
{
    if([_delegate respondsToSelector:@selector(cellStateChanged:forColumn:addRow:)])
        [_delegate cellStateChanged:state forColumn:column addRow:row];
}

// CHANGE FOR DYNAMICALLY SIZED BOARD
-(void)checkBoundsForColumn: (NSInteger) column andRow: (NSInteger) row
{
    if (column < 0 || column > 7 || row < 0 || row > 7)
        [NSException raise:NSRangeException format:@"row or column out of bounds"];
}

-(BOOL) onBoardAtColumn:(NSInteger)column andRow:(NSInteger)row
{
    return column < 0 || column > 7 || row < 0 || row > 7;
}

// CHANGE FOR DYNAMICALLY SIZED BOARD
// SKETCHY AND PROBABLY HAS MEMORY LEAKS
-(void) clearBoard
{
    // Hack way to do it. Oh well
    // REPLACE FOR DYNAMIC BOARD SIZE
    memset(_pieceBoard, 0, sizeof(NSUInteger) * 8 * 8);
    [self clearHighlighting];
    _pieceList = [[NSMutableArray alloc] init];
    //[self informDelegateOfStateChanged:BoardCellStateEmpty forColumn:-1 andRow:-1];
}
-(void) highlightAtColumn:(NSInteger)column andRow:(NSInteger)row withIndex:(int)index
{
    _highlightBoard[column][row] = index;
}

-(void) clearHighlighting
{
    memset(_highlightBoard, 0, sizeof(NSUInteger) * 8 * 8);
}


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

@end
