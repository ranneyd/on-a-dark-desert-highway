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

@implementation DDHPawn
{
    DDHTuple* startingLocation;
}

-(id) initWithPlayer:(ChessPlayer) player atColumn:(NSUInteger)column andRow:(NSUInteger)row
{
    self = [super initWithPlayer:player atColumn:column andRow:row];
    startingLocation = [[DDHTuple alloc] initWithX:column andY:row];
    return self;
}

-(NSMutableArray*) attackablePositionsOnBoard:(DDHBoard*)board
{
    // Array of moves to be returned.
    NSMutableArray* attackable = [[NSMutableArray alloc] init];
    
    // Location of the piece currently.
    NSInteger column = [self x];
    NSInteger row = [self y];
    
    // Row one in front of the pawn based on color of piece.
    NSInteger verticalMove = row + pow(-1, [self getPlayer]);
    
    // Variables for attacking other pieces. If the pawn can't move left or right,
    // set the values to be off the board!
    NSInteger leftMove = column - 1 > 0 ? column - 1 : -1;
    NSInteger rightMove = column + 1 < [board getColumns] ? column + 1 : -1;
    
    // Pawns can (usually) only attack in two locations (one square diagonally forward along both diagonals),
    // so check those two locations.
    
    // Check if we can attack other pieces to the left.
    if ([self onBoard:board AtColumn:leftMove andRow:verticalMove]) {
        if (![board isEmptySquareAtColumn:leftMove andRow:verticalMove]) {
            if ([board doesPieceAtColumn:leftMove andRow:verticalMove notBelongToPlayer:[self getPlayer]]) {
                [attackable addObject:[[DDHTuple alloc] initWithX:leftMove andY:verticalMove]];
            }
        }
    }
    
    // Check if the pawn can attack other pieces to the right.
    if ([self onBoard:board AtColumn:rightMove andRow:verticalMove]) {
        if (![board isEmptySquareAtColumn:rightMove andRow:verticalMove]) {
            if ([board doesPieceAtColumn:rightMove andRow:verticalMove notBelongToPlayer:[self getPlayer]]) {
                [attackable addObject:[[DDHTuple alloc] initWithX:rightMove andY:verticalMove]];
            }
        }
    }
    
    return attackable;
}

-(NSMutableArray*) highlightMovesWithBoard:(DDHBoard*)board
{
    
    // Array of moves to be returned
    NSMutableArray* highlighting = [[NSMutableArray alloc] init];
    
    NSInteger column = [self x];
    NSInteger row = [self y];
    
    NSInteger verticalMove = row + pow(-1, [self getPlayer]);
    
    // Next check for ability to move two squares forward.
    if ([self hasNotMoved]) {
        // Make pawn highlight two squares in front...note the direction of "front" is based on the player
        NSInteger verticalDoubleMove = row + 2*pow(-1, [self getPlayer]);
        
        // Sanity check to make sure the move is on the board
        if ([self onBoard:board AtColumn:column andRow:verticalDoubleMove]) {
            
            // Make sure both the square immediately in front of and two squares in front of the pawn are empty.
            if ([board isEmptySquareAtColumn:column andRow:verticalDoubleMove] && [board isEmptySquareAtColumn:column andRow:verticalMove]) {
                // Finally check if moving to this square puts the king in check.
                //NSLog(@"Going into kingInCheck for doubleVertical move!");
                if (![self kingInCheckAfterMovingToColumn:column andRow:verticalDoubleMove onBoard:board]) {
                    [highlighting addObject:[[DDHTuple alloc] initWithX:column andY:verticalDoubleMove]];
                }
                //NSLog(@"Survived kingInCheck!");
            }
        }
    } else {
        // If it can't double jump, it may still be able to move one space
        [self checkAndMoveToColumn:column andRow:verticalMove withBoard:board andHighlighting:highlighting andCheck:check andPacifist:YES];
    }
    
    // Check if the pawn can move forward.
    if ([self onBoard:board AtColumn:column andRow:verticalMove]) {
        
        // If the square in front of the pawn is empty, it can move there.
        if ([board isEmptySquareAtColumn:column andRow:verticalMove]) {
            // Finally check if moving to this square puts the king in check.
            if (![self kingInCheckAfterMovingToColumn:column andRow:verticalMove onBoard:board]) {
                [highlighting addObject:[[DDHTuple alloc] initWithX:column andY:verticalMove]];
            }
        }
    }
    
    // Next get moves where the pawn can attack and add those to the array of highlightable
    // squares
    
    NSMutableArray* attacking = [self attackablePositionsOnBoard:board];
    
    // Need to be careful here with passing around references...
    for (DDHTuple* position in attacking) {
        NSInteger positionColumn = [position x];
        NSInteger positionRow = [position y];
        // Check if moving to this square puts the king in check. If it doesn't put the king in check, add the move
        // to the list of possible moves.
        if (![self kingInCheckAfterMovingToColumn:positionColumn andRow:positionRow onBoard:board]) {
            [highlighting addObject:[[DDHTuple alloc] initWithX:positionColumn andY:positionRow]];
        }
    }
    
    return highlighting;
}

-(void) moveToColumn:(NSInteger)column andRow:(NSInteger)row
{
    [self setX:column];
    [self setY:row];
}

-(BOOL) hasNotMoved
{
    return [self x] == [startingLocation x] && [self y] == [startingLocation y];
}

- (NSString*) description
{
    if ([self getPlayer] == ChessPlayerBlack)
        return @"BlackPawn";
    return @"WhitePawn";
}

@end
