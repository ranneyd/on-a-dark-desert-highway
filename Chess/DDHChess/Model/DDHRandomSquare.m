//
//  DDHRandomSquare.m
//  Chess?
//
//  Created by Dustin Kane on 4/16/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHRandomSquare.h"
#import "DDHBoardDelegate.h"
#import "DDHKing.h"


@interface DDHRandomSquare ()

// Random square effect functions

// Destroys the piece that landed on square
-(void) destroyPiece;

// Teleports the piece to a random location
-(void) teleportPiece;

// Teleports a random enemy piece to a random location
-(void) teleportEnemy;

// Destroys a random enemy piece
-(void) destroyEnemy;

// Renders the space unusable
-(void) fallThrough;

// Helper function to get find a valid enemy piece
-(DDHPiece *) getEnemyPiece;

@end

@implementation DDHRandomSquare {
    id<DDHBoardDelegate> _delegate;
}

-(id) initWithColumn:(NSUInteger)column andRow:(NSUInteger)row andBoard:(DDHBoard *) board andDelegate: (id) boardDelegate
{
    self = [super init];
    
    [self setType:arc4random()%NumTypes];
//    [self setType:FallThrough]; // For testing purposes. Remove for release
    [self setX:column];
    [self setY:row];
    [self setBoard:board];
    
    [self setActive:YES];
    _delegate = boardDelegate;
    
    return self;
}

-(id)initNull
{
    self = [super init];
    
    [self setType: NullSquare];
    [self setX:0];
    [self setY:0];
    [self setBoard:NULL];
    
    _delegate = (id)[[DDHMulticastDelegate alloc] init];
    return self;
}

-(void) trigger
{
    switch ([self type]){
        case DestroyPiece:
            [self destroyPiece];
            break;
        case TeleportPiece:
            [self teleportPiece];
            break;
        case TeleportEnemy:
            [self teleportEnemy];
            break;
        case DestroyEnemy:
            [self destroyEnemy];
            break;
        case FallThrough:
            [self fallThrough];
            break;
        default:
            NSLog(@"Square type is: %d", [self type]);
            [self popupWithTitle:@"Nothing!" andMessage:@"You're lucky this time..."];
            
            [self setActive:NO];
            break;
    }
}

-(void) popupWithTitle:(NSString*) title andMessage:(NSString *) message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"Okay!" otherButtonTitles:nil];
    [alert show];
}

// Random square effect functions

-(void) destroyPiece
{
    // Landmines can't blow up kings or put the player in check
    if ([[_board pieceAtColumn:_x andRow:_y] isMemberOfClass:[DDHKing class]] || [_board doesDestructionCauseCheckAtColumn:_x andRow:_y]){
        [self setType:NullSquare];
        [self trigger];
        return;
    }
    
    // Display the message
    [self popupWithTitle:@"Landmine!" andMessage:@"You stepped on a landmine! You die now!"];
    
    // Destroy the piece that landed on the square
    [[self board] destroyPieceAtColumn:[self x] andRow:[self y]];
    
    [self setActive:NO];
}

-(void) teleportPiece
{
    // Get a random position on the board
    NSInteger newCol = arc4random()%[_board getColumns];
    NSInteger newRow = arc4random()%[_board getRows];
    
    // Keep looking until the space is empty and doesn't contain a random square
    while (![_board isEmptySquareAtColumn:newCol andRow:newRow] || [_board randomAtColumn:newCol andRow:newRow]){
        newCol = arc4random()%[_board getColumns];
        newRow = arc4random()%[_board getRows];
    }
    
    // Make sure that moving the piece won't put the player in check
    if ([_board checkIfMoveFromColumn:_x andRow:_y toColumn:newCol andRow:newRow]){
        [self setType:NullSquare];
        [self trigger];
        return;
    }
    
    // Display correct message
    [self popupWithTitle:@"Teleport!" andMessage:@"Turns out that was a teleporter... Where do you think you'll land?"];
    
    // Moves the piece to the open position
    NSLog(@"Teleporting Piece");
    [_board movePieceAtColumn:_x andRow:_y ToColumn:newCol andRow:newRow];
    
    // Update all squares to display the change
    [_delegate pieceChangedAtColumn:-1 addRow:-1];
    
    [self setActive:NO];
}

-(void) teleportEnemy
{
    [self popupWithTitle:@"Teleport Enemy!" andMessage:@"Something has happened to one of your opponent's pieces!"];
    
    // Get a valid enemy piece
    DDHPiece* enemyPiece = [self getEnemyPiece];
    
    // Get a random position on the board
    NSInteger newCol = arc4random()%[_board getColumns];
    NSInteger newRow = arc4random()%[_board getRows];
    
    // Keep looking until the space is empty and doesn't contain a random square
    while (![_board isEmptySquareAtColumn:newCol andRow:newRow] || [_board randomAtColumn:newCol andRow:newRow]){
        newCol = arc4random()%[_board getColumns];
        newRow = arc4random()%[_board getRows];
    }
    
    // Check that the move won't put the player in check
    ChessPlayer player = [[_board pieceAtColumn:_x andRow:_y] getPlayer];
    if ([_board doesMoveFromColumn:[enemyPiece x] andRow:[enemyPiece y] toColumn:newCol andRow:newRow causeCheckForPlayer:player]){
        [self setType:NullSquare];
        [self trigger];
        return;
    }
    
    // Moves the piece to the open position
    NSLog(@"Teleporting Piece");
    [_board movePieceAtColumn:[enemyPiece x] andRow:[enemyPiece y] ToColumn:newCol andRow:newRow];
    
    // Update all squares to display the change
    [_delegate pieceChangedAtColumn:-1 addRow:-1];

    [self setActive:NO];
}

-(void) destroyEnemy
{
    [self popupWithTitle:@"Missile!" andMessage:@"You found a missile and launched it at the enemy. Too bad it doesn't have a targeting system"];

    // Get a valid enemy piece
    DDHPiece* enemyPiece = [self getEnemyPiece];
    
    // Destroy the enemy piece
    [_board destroyPieceAtColumn:[enemyPiece x] andRow:[enemyPiece y]];
    
    [self setActive:NO];
}

-(void) fallThrough
{
    // Bottomless pits can't take kings or put the player in check
    if ([[_board pieceAtColumn:_x andRow:_y] isMemberOfClass:[DDHKing class]] || [_board doesDestructionCauseCheckAtColumn:_x andRow:_y]){
        [self setType:NullSquare];
        [self trigger];
        return;
    }
    
    [self popupWithTitle:@"Bottomless Pit!" andMessage:@"Great job, buddy. Now no one can go there. Way to go."];
    
    // Destroy the piece that landed on the square
    [[self board] destroyPieceAtColumn:[self x] andRow:[self y]];
    
    [self setActive:NO];
    
    // Update all squares to display the change
    [_delegate pieceChangedAtColumn:-1 addRow:-1];
}


// Helper functions
-(DDHPiece *) getEnemyPiece
{
    // Get the player that moved to the space
    DDHPiece* playerPiece = [_board pieceAtColumn:_x andRow:_y];
    ChessPlayer player = [playerPiece getPlayer];
    
    // Get a random position on the board
    NSInteger targetCol = arc4random()%[_board getColumns];
    NSInteger targetRow = arc4random()%[_board getRows];
    DDHPiece* targetPiece = [_board pieceAtColumn:targetCol andRow:targetRow];
    
    // Keep looking until you find an enemy piece that isn't the king
    while(([targetPiece getPlayer] == player) || ([targetPiece getPlayer] == ChessPlayerNull) || [targetPiece isMemberOfClass:[DDHKing class]]){
        targetCol = arc4random()%[_board getColumns];
        targetRow = arc4random()%[_board getRows];
        targetPiece = [_board pieceAtColumn:targetCol andRow:targetRow];
    }

    return targetPiece;
}

@end
