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
#import "DDHPawn.h"
#import "DDHRook.h"
#import "DDHKnight.h"
#import "DDHBishop.h"
#import "DDHQueen.h"
#import "DDHTuple.h"



@interface DDHRandomSquare ()

// Random square effect functions

// Destroys the piece that landed on square
-(void) destroyPlayer;

// Teleports the piece to a random location
-(void) teleportPlayer;

// Teleports a random enemy piece to a random location
-(void) teleportEnemy;

// Destroys a random enemy piece
-(void) destroyEnemy;

// Renders the space unusable
-(void) fallThrough;

// Blow up everything around it
-(void) hugeLandmine;

// Spawns a new piece somewhere on the board
-(void) newPiece;

// Turns an opponent's piece to the other color
-(void) enemyDoubleAgent;

// Turns a player's piece into the opponent's color
-(void) playerDoubleAgent;

// Switch all the of the player's piece positions with the opponent's
-(void) changeSides;

// Destroy all valid pieces in a row
-(void) carpetBomb;

// Helper function to get find a valid enemy piece
-(DDHPiece *) getEnemyPiece;

// Helper function to get find a valid piece from the current player
-(DDHPiece *) getPlayerPiece;

// Helper function to find an open position on the board
-(DDHTuple *) getRandomEmptyPosition;

@end

@implementation DDHRandomSquare {
    id<DDHBoardDelegate> _delegate;
}

-(id) initWithColumn:(NSUInteger)column andRow:(NSUInteger)row andBoard:(DDHBoard *) board andDelegate: (id) boardDelegate
{
    self = [super init];
    
    //[self setType:arc4random()%NumTypes];
    [self setType:CarpetBomb]; // For testing purposes. Remove for release
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
    [self setActive:NO];
    switch ([self type]){
        case DestroyPlayer:
            [self destroyPlayer];
            break;
        case TeleportPlayer:
            [self teleportPlayer];
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
        case HugeLandmine:
            [self hugeLandmine];
            break;
        case NewPiece:
            [self newPiece];
        case LukeSkywalker:
            [self lukeSkywalker];
            break;
        case EnemyDoubleAgent:
            [self enemyDoubleAgent];
            break;
        case DarthVader:
            [self darthVader];
            break;
        case PlayerDoubleAgent:
            [self playerDoubleAgent];
            break;
        case ChangeSides:
            [self changeSides];
            break;
        case CarpetBomb:
            [self carpetBomb];
            break;
        default:
            NSLog(@"Square type is: %d", [self type]);
            [self popupWithTitle:@"Nothing!" andMessage:@"You're lucky this time..."];
            break;
    }
    
}

-(void) popupWithTitle:(NSString*) title andMessage:(NSString *) message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"Okay!" otherButtonTitles:nil];
    [alert show];
}

// Random square effect functions

-(void) destroyPlayer
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
    
}

-(void) teleportPlayer
{
    // Get an open position on the board
    DDHTuple* randomPos = [self getRandomEmptyPosition];
    
    // Make sure that moving the piece won't put the player in check
    if ([_board checkIfMoveFromColumn:_x andRow:_y toColumn:[randomPos x] andRow:[randomPos y]]){
        [self setType:NullSquare];
        [self trigger];
        return;
    }
    
    // Display correct message
    [self popupWithTitle:@"Teleport!" andMessage:@"Turns out that was a teleporter... Where do you think you'll land?"];
    
    // Moves the piece to the open position
    NSLog(@"Teleporting Piece");
    [_board movePieceAtColumn:_x andRow:_y ToColumn:[randomPos x] andRow:[randomPos y]];
    
    // Update all squares to display the change
    [_delegate pieceChangedAtColumn:-1 addRow:-1];
    
}

-(void) teleportEnemy
{
    [self popupWithTitle:@"Teleport Enemy!" andMessage:@"Something has happened to one of your opponent's pieces!"];
    
    // Get a valid enemy piece
    DDHPiece* enemyPiece = [self getEnemyPiece];
    
    // Get an open position on the board
    DDHTuple* randomPos = [self getRandomEmptyPosition];
    
    // Check that the move won't put the player in check
    ChessPlayer player = [[_board pieceAtColumn:_x andRow:_y] getPlayer];
    if ([_board doesMoveFromColumn:[enemyPiece x] andRow:[enemyPiece y] toColumn:[randomPos x] andRow:[randomPos y] causeCheckForPlayer:player]){
        [self setType:NullSquare];
        [self trigger];
        return;
    }
    
    // Moves the piece to the open position
    NSLog(@"Teleporting Piece");
    [_board movePieceAtColumn:[enemyPiece x] andRow:[enemyPiece y] ToColumn:[randomPos x] andRow:[randomPos y]];
    
    // Update all squares to display the change
    [_delegate pieceChangedAtColumn:-1 addRow:-1];

}

-(void) destroyEnemy
{
    [self popupWithTitle:@"Missile!" andMessage:@"You found a missile and launched it at the enemy. Too bad it doesn't have a targeting system"];

    // Get a valid enemy piece
    DDHPiece* enemyPiece = [self getEnemyPiece];
    
    // Destroy the enemy piece
    [_board destroyPieceAtColumn:[enemyPiece x] andRow:[enemyPiece y]];
    
}

-(void) fallThrough
{
    // Bottomless pits can't take kings or put the player in check
    if ([[_board pieceAtColumn:_x andRow:_y] isMemberOfClass:[DDHKing class]] || [_board doesDestructionCauseCheckAtColumn:_x andRow:_y]){
        [self setType:NullSquare];
        [self trigger];
        return;
    }
    
    [self popupWithTitle:@"Bottomless Pit!" andMessage:@"You feel the earth crumbling beneath your feet. You gasp as the ground buckles and collapses below you and you plunge down the bowels of Hell...\n\n Now no one is going to touch that square with a 15 foot pole"];
    
    // Destroy the piece that landed on the square
    [[self board] destroyPieceAtColumn:[self x] andRow:[self y]];

   

    
    // Update all squares to display the change
    [_delegate pieceChangedAtColumn:-1 addRow:-1];
}

-(void) hugeLandmine
{
    // Get a piece for checking boundaries
    DDHPiece* posPiece = [_board pieceAtColumn:_x andRow:_y];
    
    for (long r = _y - 1; r <= _y + 1; ++r){
        for (long c = _x - 1; c <= _x + 1; ++c){
            
            // Landmines can't blow up kings or put the player in check (or things that are off the board)
            if (![[_board pieceAtColumn:c andRow:r] isMemberOfClass:[DDHKing class]] && ![_board doesDestructionCauseCheckAtColumn:c andRow:r] &&
                                                                                        [posPiece onBoard:_board AtColumn:c andRow:r]){
                [[self board] destroyPieceAtColumn:c andRow:r];
            }
        }
    }

}
-(void) lukeSkywalker
{
    for(int i = 0; i < 8; i++){
        for(int j = 0; j < 8; j++){
            DDHPiece * piece = [_board pieceAtColumn:i andRow:j];
            if([piece isKindOfClass:[DDHPawn class]] && [piece getPlayer] == ChessPlayerWhite)
                [(DDHPawn *)piece setToLuke];
        }
    }
    [self popupWithTitle:@"Luke Skywalker Has Joined the Battle!" andMessage:@"In an attempt to aid you in your battle against the Dark Side, Luke Skywalker has come and replaced all of your pawns with clones of himself!"];
    [_delegate pieceChangedAtColumn:-1 addRow:-1];
    
}

-(void) darthVader
{
    for(int i = 0; i < 8; i++){
        for(int j = 0; j < 8; j++){
            DDHPiece * piece = [_board pieceAtColumn:i andRow:j];
            if([piece isKindOfClass:[DDHPawn class]] && [piece getPlayer] == ChessPlayerBlack)
                [(DDHPawn *)piece setToLuke];
        }
    }
    [self popupWithTitle:@"Dark Vader Has Joined the Battle!" andMessage:@"The Empire has sent Darth Vader to oversee your command of the troops. He has deamed your army unsatisfactory and has replaced all your pawns with clones of himself."];
    [_delegate pieceChangedAtColumn:-1 addRow:-1];
    
}

-(void) newPiece
{
    // Get an open position on the board
    DDHTuple* randomPos = [self getRandomEmptyPosition];
    
    // Make sure that the new piece belongs to the right player
    ChessPlayer player = [[_board pieceAtColumn:_x andRow:_y] getPlayer];
    
    // Create a new piece (of a random non-king type) and place it on the board
    NSArray* pieceTypes = [[NSArray alloc] initWithObjects: [DDHPawn class], [DDHBishop class], [DDHKnight class], [DDHQueen class], [DDHRook class], nil];
    NSInteger randomIndex = arc4random()%[pieceTypes count];
    DDHPiece* newPiece = [[[pieceTypes objectAtIndex:randomIndex] alloc] initWithPlayer:player atColumn:[randomPos x] andRow:[randomPos y]];
    [_board putPiece:newPiece inColumn:[randomPos x] andRow:[randomPos y]];
    
    // Update the square to display the change
    [_delegate pieceChangedAtColumn:[randomPos x] addRow:[randomPos y]];
    
    [self popupWithTitle:@"New Piece" andMessage:@"You have drafted a new soldier into your army.\n \"We met as soul mates on Parris Island. We left as inmates from an asylum. And we were sharp, as sharp as knives, and we were so gung ho to lay down our lives...\" - Billy Joel "];
}

-(void) enemyDoubleAgent
{
    // Get a valid enemy piece
    DDHPiece* enemyPiece = [self getEnemyPiece];
    
    // Get the player that landed on the square
    ChessPlayer player = [[_board pieceAtColumn:_x andRow:_y] getPlayer];
    
    // Change the piece to the current player's colo
    [enemyPiece setPlayer:player];
    
    // Update the square to display the change
    [_delegate pieceChangedAtColumn:[enemyPiece x] addRow:[enemyPiece y]];
    
    [self setActive:NO];
}

-(void) playerDoubleAgent
{
    // Get a valid piece
    DDHPiece* playerPiece = [self getPlayerPiece];
    
    // Get the opponent's color
    ChessPlayer opponent = [[self getEnemyPiece] getPlayer];
    
    // Create a new piece to check if the move is valid
    DDHPiece* doubleAgent = [[[playerPiece class] alloc] initWithPlayer:opponent atColumn:[playerPiece x] andRow:[playerPiece y]];
    
    // If changing the piece to a double agent would cause check, don't do anything
    if ([_board doesNewPiece:doubleAgent atColumn:[doubleAgent x] andRow:[doubleAgent y] causeCheckForPlayer:[playerPiece getPlayer]]){
        [self setType:NullSquare];
        [self trigger];
        return;
    }
    
    // Change the piece to the opponent
    [playerPiece setPlayer:opponent];
    
    // Update the square to display the change
    [_delegate pieceChangedAtColumn:[playerPiece x] addRow:[playerPiece y]];
    
    [self setActive:NO];
}

-(void) changeSides
{
    // Get the players
    ChessPlayer player = [[_board pieceAtColumn:_x andRow:_y] getPlayer];
    ChessPlayer opponent = [[self getEnemyPiece] getPlayer];
    
    // If the moved caused check, then don't change sides
    if ([_board kingInCheckBelongingTo:opponent]){
        [self setType:NullSquare];
        [self trigger];
        return;
    }
    
    // Iterate over the entire board and swap the position of pieces (but only go upto the center row, or else all piece move back)
    for (NSInteger r=0; r<[_board getRows]/2; ++r){
        for (NSInteger c=0; c<[_board getColumns]; ++c){
            // Get the destination row and column, adjusting for indexing from 0
            NSInteger destCol = [_board getColumns] - 1 - c;
            NSInteger destRow = [_board getRows] - 1 - r;
            
            // Remeber the pieces so that we don't over write them
            DDHPiece* srcPiece = [_board pieceAtColumn:c andRow:r];
            DDHPiece* destPiece = [_board pieceAtColumn:destCol andRow:destRow];
            
            // Move the pieces on the board
            [_board putPiece:srcPiece inColumn:destCol andRow:destRow];
            [_board putPiece:destPiece inColumn:c andRow:r];
            
            // Change the color of the pieces
            if ([srcPiece getPlayer] == player){
                [srcPiece setPlayer:opponent];
                NSLog(@"changing color");
            } else {
                [srcPiece setPlayer:player];
            }
            if ([destPiece getPlayer] == player){
                [destPiece setPlayer:opponent];
            } else {
                [destPiece setPlayer:player];
            }
            
            // Move the pieces internally to the correct place
            [srcPiece moveToColumn:destCol andRow:destRow];
            [destPiece moveToColumn:c andRow:r];
            
        }
    }
    
    // Update all squares to display the change
    [_delegate pieceChangedAtColumn:-1 addRow:-1];
    
    NSLog(@"Done moving pieces!");
    
    [self setActive:NO];
}

-(void) carpetBomb
{
    // Get a piece for checking boundaries
    DDHPiece* posPiece = [_board pieceAtColumn:_x andRow:_y];
    

    for (int c = 0; c < [_board getColumns]; ++c){
        
        // Can't blow up kings or put the player in check (or things that are off the board)
        if (![[_board pieceAtColumn:c andRow:_y] isMemberOfClass:[DDHKing class]] && ![_board doesDestructionCauseCheckAtColumn:c andRow:_y] &&
                                                                                                    [posPiece onBoard:_board AtColumn:c andRow:_y]){
            [[self board] destroyPieceAtColumn:c andRow:_y];
            //[[self board] informDelegateOfExplosionAtColumn:c andRow:_y];
            [NSThread sleepForTimeInterval:0.25];
        }
    }
    
    [self popupWithTitle:@"Airstrike" andMessage:@"You got a 5 kill streak and have earned an airstrike (I bet you young whipersnappers don't remember Call of Duty 4)."];
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

-(DDHPiece *) getPlayerPiece
{
    // Get the player that moved to the space
    DDHPiece* playerPiece = [_board pieceAtColumn:_x andRow:_y];
    ChessPlayer player = [playerPiece getPlayer];
    
    // Get a random position on the board
    NSInteger targetCol = arc4random()%[_board getColumns];
    NSInteger targetRow = arc4random()%[_board getRows];
    DDHPiece* targetPiece = [_board pieceAtColumn:targetCol andRow:targetRow];
    
    // Keep looking until you find an enemy piece that isn't the king
    while(([targetPiece getPlayer] != player) || [targetPiece isMemberOfClass:[DDHKing class]]){
        targetCol = arc4random()%[_board getColumns];
        targetRow = arc4random()%[_board getRows];
        targetPiece = [_board pieceAtColumn:targetCol andRow:targetRow];
    }
    
    return targetPiece;
}

-(DDHTuple *) getRandomEmptyPosition
{
    // Get a random position on the board
    NSInteger newCol = arc4random()%[_board getColumns];
    NSInteger newRow = arc4random()%[_board getRows];
    
    // Keep looking until the space is empty and doesn't contain a random square
    while (![_board isEmptySquareAtColumn:newCol andRow:newRow] || [_board randomAtColumn:newCol andRow:newRow]){
        newCol = arc4random()%[_board getColumns];
        newRow = arc4random()%[_board getRows];
    }

    return [[DDHTuple alloc] initWithX:newCol andY:newRow];
}

@end
