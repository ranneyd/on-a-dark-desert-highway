//
//  DDHPawn.m
//  DDHChess
//
//  Created by Dustin Kane on 2/21/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHPawn.h"
#import "DDHTuple.h"
#import "DDHBoard.h"
#import "DDHNullPiece.h"

@implementation DDHPawn{
    BOOL isLuke;
}

-(id) initWithPlayer:(ChessPlayer) player atColumn:(NSUInteger)column andRow:(NSUInteger)row
{
    self = [super initWithPlayer:player atColumn:column andRow:row];
    [self setNumClicks:0];
    isLuke = NO;
    return self;
}

-(NSMutableArray*) highlightMovesWithBoard:(DDHBoard*)board andCheck:(BOOL) check
{
    // Array of moves to be returned
    NSMutableArray* highlighting = [[NSMutableArray alloc] init];
    
    NSInteger column = [self x];
    NSInteger row = [self y];
    
    // Up or down depending on player
    NSInteger verticalMove = row + pow(-1, [self getPlayer]);
    
    // Variables for attacking other pieces. If the pawn can't move left or right,
    // set the values to be off the board!
    NSInteger leftMove = column - 1 >= 0 ? column - 1 : -1;
    NSInteger rightMove = column + 1 < [board getColumns] ? column + 1 : -1;
    
    // Next check if in initial state and nothing in front
    if ((([self getPlayer] == ChessPlayerBlack && [self y] == 1) && [board isEmptySquareAtColumn:[self x] andRow:2]) || (([self getPlayer] == ChessPlayerWhite && [self y] == 6) && [board isEmptySquareAtColumn:[self x] andRow:5])) {
        // Make pawn highlight two squares in front...note the direction of "front" is based on the player
        NSInteger verticalDoubleMove = row + 2*pow(-1, [self getPlayer]);

        // Only check if the pawn can move two spaces if it can move one
        [self checkAndMoveToColumn:column andRow:verticalDoubleMove withBoard:board andHighlighting:highlighting andCheck:check andPacifist:YES];
    }
    // If it can't double jump, it may still be able to move one space
    [self checkAndMoveToColumn:column andRow:verticalMove withBoard:board andHighlighting:highlighting andCheck:check andPacifist:YES];
    
    // Check if we can attack other pieces to the left.
    [self checkAndMoveToColumn:leftMove andRow:verticalMove withBoard:board andHighlighting:highlighting andCheck:check andPacifist:NO];
    
    // Check if the pawn can attack other pieces to the right.
    [self checkAndMoveToColumn:rightMove andRow:verticalMove withBoard:board andHighlighting:highlighting andCheck:check andPacifist:NO];

    // Check for en passant on the piece to the left and right
    [self checkEnPassantWithBoard:board andHighlighting:highlighting andCheck:check];
    
    return highlighting;
}

// Highlights the move if it is a valid move and returns whether or not it highlighted
-(BOOL) checkAndMoveToColumn:(NSUInteger) column andRow:(NSUInteger) row withBoard:(DDHBoard*) board andHighlighting:(NSMutableArray*) highlighting andCheck:(BOOL) check andPacifist:(BOOL) pacifist{
    
    // Check if the pawn can move forward.
    if ([self onBoard:board AtColumn:column andRow:row]) {
        // Make sure we aren't moving into check
        if(!(check &&[board checkIfMoveFromColumn:[self x] andRow:[self y] toColumn:column andRow:row])){
            // Pacifist means this is a non-attacking move
            if(pacifist){
                // Pacifist moves only work if the space is empty
                if ([board isEmptySquareAtColumn:column andRow:row]) {
                    [highlighting addObject:[[DDHTuple alloc] initWithX:column andY:row]];
                    return YES;
                }
            }
            // If not in pacifist mode, in warmonger mode, aka the piece MUST attack
            else{
                // make sure the space has an enemy piece in it.
                if ([self warmongerWithBoard:board atColumn:column andRow:row]) {
                    [highlighting addObject:[[DDHTuple alloc] initWithX:column andY:row]];
                    return YES;
                }
            }
        }
    }
    return NO;
}

-(BOOL) checkEnPassantWithBoard:(DDHBoard*) board andHighlighting:(NSMutableArray*) highlighting andCheck:(BOOL) check{
    
    NSInteger column = [self x];
    NSInteger row = [self y];
    
    // Up or down depending on player
    NSInteger verticalMove = row + pow(-1, [self getPlayer]);
    
    // Variables for attacking other pieces. If the pawn can't move left or right,
    // set the values to be off the board!
    NSInteger leftMove = column - 1 >= 0 ? column - 1 : -1;
    NSInteger rightMove = column + 1 < [board getColumns] ? column + 1 : -1;
    
    // Check en passant to the left
    // Is the space on the board?
    if ([self onBoard:board AtColumn:leftMove andRow:verticalMove]) {
        // Make sure we aren't moving into check
        if(!(check &&[board checkIfMoveFromColumn:[self x] andRow:[self y] toColumn:leftMove andRow:verticalMove])){
            // Piece to the left must be the double jumped pawn. Note that the piece is in the same row, not where we are moving.
            if ([board pieceAtColumn:leftMove andRow:row] == [board getPawnThatDoubleMovedLastTurn]) {
                [highlighting addObject:[[DDHTuple alloc] initWithX:leftMove andY:verticalMove]];
                return YES;
            }
        }
    }
    // Check en passant to the right
    // Is the space on the board?
    if ([self onBoard:board AtColumn:rightMove andRow:verticalMove]) {
        // Make sure we aren't moving into check
        if(!(check &&[board checkIfMoveFromColumn:[self x] andRow:[self y] toColumn:rightMove andRow:verticalMove])){
            // Piece to the right must be the double jumped pawn. Note that the piece is in the same row, not where we are moving
            if ([board pieceAtColumn:rightMove andRow:row] == [board getPawnThatDoubleMovedLastTurn]) {
                [highlighting addObject:[[DDHTuple alloc] initWithX:rightMove andY:verticalMove]];
                return YES;
            }
        }
    }
    return NO;
}

// True if the place is not empty and the piece in that place is an enemy piece.
-(BOOL) warmongerWithBoard:(DDHBoard*) board atColumn:(NSUInteger) column andRow:(NSUInteger) row{
    return ![board isEmptySquareAtColumn:column andRow:row] && [board doesPieceAtColumn:column andRow:row notBelongToPlayer:[self getPlayer]];
}

-(void) moveToColumn:(NSInteger)column andRow:(NSInteger)row
{
    [self setX:column];
    [self setY:row];
}
-(void) setToLuke
{
    isLuke = YES;
}

- (NSString*) description
{
    if ([self getPlayer] == ChessPlayerBlack){
        if (isLuke)
            return @"DarthVader";
        else
            return @"BlackPawn";
    }
    else{
        if(isLuke)
            return @"LukeSkywalker";
        else
            return @"WhitePawn";
    }
}
-(int) click
{
    return ++self.numClicks;
}

@end
