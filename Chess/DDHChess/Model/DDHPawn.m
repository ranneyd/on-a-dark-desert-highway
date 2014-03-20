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
}

-(id) initWithPlayer:(ChessPlayer) player atColumn:(NSUInteger)column andRow:(NSUInteger)row
{
    self = [super initWithPlayer:player atColumn:column andRow:row];
    return self;
}

-(NSMutableArray*) highlightMovesWithBoard:(DDHBoard*)board andCheck:(BOOL) check
{
    // Array of moves to be returned
    NSMutableArray* highlighting = [[NSMutableArray alloc] init];
    
    NSInteger column = [self x];
    NSInteger row = [self y];
    
    NSInteger verticalMove = row + pow(-1, [self getPlayer]);
    
    // Variables for attacking other pieces. If the pawn can't move left or right,
    // set the values to be off the board!
    NSInteger leftMove = column - 1 > 0 ? column - 1 : -1;
    NSInteger rightMove = column + 1 < [board getColumns] ? column + 1 : -1;
    
    // Next check for ability to move two squares forward.
    if (([self getPlayer] == ChessPlayerBlack && [self y] == 6) || ([self getPlayer] == ChessPlayerWhite && [self y] == 1)) {
        // Make pawn highlight two squares in front...note the direction of "front" is based on the player
        NSInteger verticalDoubleMove = row + 2*pow(-1, [self getPlayer]);
        
        [self checkAndMoveToColumn:column andRow:verticalDoubleMove withBoard:board andHighlighting:highlighting andCheck:check andPacifist:YES];
    }
    
    // Check if the pawn can move forward.
    [self checkAndMoveToColumn:column andRow:verticalMove withBoard:board andHighlighting:highlighting andCheck:check andPacifist:YES];
    
    // Check if we can attack other pieces to the left.
    [self checkAndMoveToColumn:leftMove andRow:verticalMove withBoard:board andHighlighting:highlighting andCheck:check andPacifist:NO];
    
    // Check if the pawn can attack other pieces to the right.
    [self checkAndMoveToColumn:rightMove andRow:verticalMove withBoard:board andHighlighting:highlighting andCheck:check andPacifist:NO];
 
    return highlighting;
}

-(void) checkAndMoveToColumn:(NSUInteger) column andRow:(NSUInteger) row withBoard:(DDHBoard*) board andHighlighting:(NSMutableArray*) highlighting andCheck:(BOOL) check andPacifist:(BOOL) pacifist{
    // Check if the pawn can move forward.
    if ([self onBoard:board AtColumn:column andRow:row]) {
        // Make sure we aren't moving into check
        if(!(check &&[board checkIfMoveFromColumn:[self x] andRow:[self y] toColumn:column andRow:row])){
            // Pacifist means this is a non-attacking move
            if(pacifist){
                // Pacifist moves only work if the space is empty
                if ([board isEmptySquareAtColumn:column andRow:row]) {
                    [highlighting addObject:[[DDHTuple alloc] initWithX:column andY:row]];
                }
            }
            // If not in pacifist mode, in warmonger mode, aka the piece MUST attack
            else{
                // make sure the space has an enemy piece in it.
                if ([self warmongerWithBoard:board atColumn:column andRow:row]) {
                    [highlighting addObject:[[DDHTuple alloc] initWithX:column andY:row]];
                }
            }
        }
    }
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

- (NSString*) description
{
    if ([self getPlayer] == ChessPlayerBlack)
        return @"BlackPawn";
    return @"WhitePawn";
}

@end
