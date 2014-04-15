//
//  DDHKing.m
//  DDHChess
//
//  Created by Dustin Kane on 2/21/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHKing.h"
#import "DDHBoard.h"
#import "DDHRook.h"

@implementation DDHKing

-(NSMutableArray*) highlightMovesWithBoard:(DDHBoard*) board andCheck:(BOOL)check;
{
    NSUInteger x = [self x];
    NSUInteger y = [self y];
    
    // Store move types in here.
    NSMutableArray* points = [[NSMutableArray alloc] initWithCapacity:8];
    
    // up
    [points addObject:[[DDHTuple alloc] initWithX:0 andY:-1]];
    
    // down
    [points addObject:[[DDHTuple alloc] initWithX:0 andY:1]];
    
    // left
    [points addObject:[[DDHTuple alloc] initWithX:-1 andY:0]];
    
    // right
    [points addObject:[[DDHTuple alloc] initWithX:1 andY:0]];
    
    // up 1 left 1
    [points addObject:[[DDHTuple alloc] initWithX:-1 andY:-1]];
    
    // down 1 left 1
    [points addObject:[[DDHTuple alloc] initWithX:-1 andY:1]];
    
    // up 1 right 1
    [points addObject:[[DDHTuple alloc] initWithX:1 andY:-1]];
    
    // down 1 right 1
    [points addObject:[[DDHTuple alloc] initWithX:1 andY:1]];
    
    NSMutableArray *highlighting = [[NSMutableArray alloc]init];
    
    for(int i = 0; i < 8; i++){
        DDHTuple* nextMove = [points objectAtIndex:i];
        long dx = x + [nextMove x];
        long dy = y + [nextMove y];
        // Make sure the potential move is on the board, then check to make sure it's a valid move.
        if([self onBoard:board AtColumn:dx andRow:dy]) {
            if(!(check && [board checkIfMoveFromColumn:x andRow:y toColumn:dx andRow:dy])){
                if ([board doesPieceAtColumn:dx andRow:dy notBelongToPlayer:[self getPlayer]]) {
                    [highlighting addObject:[[DDHTuple alloc] initWithX:dx andY:dy]];
                }
            }
        }
    }
    
    
    // Castling
    
    // Cannot castle if the king has moved
    if (![self hasMoved]){
        // king side castle
        DDHPiece* kingCastle = [board pieceAtColumn:[board getColumns]-1 andRow:y];
        // If piece is a rook that hasn't moved. Remember, if it hasn't moved, it must be our rook
        if ([kingCastle isKindOfClass:[DDHRook class]] &&
            ![kingCastle hasMoved] &&
            [board isEmptySquareAtColumn:x + 1 andRow:y] &&
            [board isEmptySquareAtColumn:x + 2 andRow:y] ){
            // Make sure that we are not moving through or into check
            if(!(check && [board checkIfMoveFromColumn:x andRow:y toColumn:[board getColumns] -2 andRow:y])){
                if(![board checkIfMoveFromColumn:x andRow:y toColumn:[board getColumns] -3 andRow:y]){
                    [highlighting addObject:[[DDHTuple alloc] initWithX: [board getColumns] -2 andY:y]];
                }
            }
        }
        
        // queen side castle
        
        DDHPiece* queenCastle = [board pieceAtColumn:0 andRow:y];
        if ([queenCastle isKindOfClass:[DDHRook class]] &&
            ![queenCastle hasMoved] &&
            [board isEmptySquareAtColumn:x - 1 andRow:y] &&
            [board isEmptySquareAtColumn:x - 2 andRow:y] &&
            [board isEmptySquareAtColumn:x - 3 andRow:y]){
            // Make sure that we are not moving through or into check
            if(!(check && [board checkIfMoveFromColumn:x andRow:y toColumn: 2 andRow:y])){
                if(![board checkIfMoveFromColumn:x andRow:y toColumn: 3 andRow:y]){
                    [highlighting addObject:[[DDHTuple alloc] initWithX: 2 andY:y]];
                }
            }
        }
    }
 
    
    return highlighting;
}

-(NSString*) description
{
    if ([super getPlayer] == ChessPlayerBlack)
        return @"BlackKing";
    return @"WhiteKing";
}

@end
