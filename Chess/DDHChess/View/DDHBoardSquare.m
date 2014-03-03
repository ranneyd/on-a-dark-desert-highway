//
//  DDHBoardSquare.m
//  DDHChess
//
//  Created by Colin Eberhardt and modified by Dustin Kane, Will Clausen and Zakkai Davidson on 2/15/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHBoardSquare.h"
#import "DDHBoard.h"

@implementation DDHBoardSquare
{
    NSUInteger _row;
    NSUInteger _column;
    DDHBoard* _board;
    
    // Views for pieces
    
    // White Pieces
    UIImageView* _whitePawnView;
    UIImageView* _whiteRookView;
    UIImageView* _whiteKnightView;
    UIImageView* _whiteBishopView;
    UIImageView* _whiteQueenView;
    UIImageView* _whiteKingView;
    
    // Black Pieces
    UIImageView* _blackPawnView;
    UIImageView* _blackRookView;
    UIImageView* _blackKnightView;
    UIImageView* _blackBishopView;
    UIImageView* _blackQueenView;
    UIImageView* _blackKingView;
}

- (id)initWithFrame:(CGRect)frame column:(NSInteger)column row:(NSInteger)row board:(DDHBoard *)board
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _row = row;
        _column = column;
        _board = board;
        
        // create the views for the playing piece graphics
        [self initWhitePieceViews];
        
        [self initBlackPieceViews];
        
        self.backgroundColor = [UIColor clearColor];
        
        [self update];
    }
    [_board.boardDelegate addDelegate:self];
    
    // add a tap recognizer
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellTapped:)];
    [self addGestureRecognizer:tapRecognizer];
    
    return self;
}

- (void) initWhitePieceViews
{
    
    UIImage* whitePawnImage = [UIImage imageNamed: @"WhitePawn.png"];
    _whitePawnView = [[UIImageView alloc] initWithImage: whitePawnImage];
    _whitePawnView.alpha = 0.0;
    [self addSubview:_whitePawnView];
    
    UIImage* whiteRookImage = [UIImage imageNamed: @"WhiteRook.png"];
    _whiteRookView = [[UIImageView alloc] initWithImage: whiteRookImage];
    _whiteRookView.alpha = 0.0;
    [self addSubview:_whiteRookView];
    
    UIImage* whiteKnightImage = [UIImage imageNamed: @"WhiteKnight.png"];
    _whiteKnightView = [[UIImageView alloc] initWithImage: whiteKnightImage];
    _whiteKnightView.alpha = 0.0;
    [self addSubview:_whiteKnightView];
    
    UIImage* whiteBishopImage = [UIImage imageNamed: @"WhiteBishop.png"];
    _whiteBishopView = [[UIImageView alloc] initWithImage: whiteBishopImage];
    _whiteBishopView.alpha = 0.0;
    [self addSubview:_whiteBishopView];
    
    UIImage* whiteQueenImage = [UIImage imageNamed: @"WhiteQueen.png"];
    _whiteQueenView = [[UIImageView alloc] initWithImage: whiteQueenImage];
    _whiteQueenView.alpha = 0.0;
    [self addSubview:_whiteQueenView];
    
    UIImage* whiteKingImage = [UIImage imageNamed: @"WhiteKing.png"];
    _whiteKingView = [[UIImageView alloc] initWithImage: whiteKingImage];
    _whiteKingView.alpha = 0.0;
    [self addSubview:_whiteKingView];
}

- (void) initBlackPieceViews
{
    
    UIImage* blackPawnImage = [UIImage imageNamed: @"blackPawn.png"];
    _blackPawnView = [[UIImageView alloc] initWithImage: blackPawnImage];
    _blackPawnView.alpha = 0.0;
    [self addSubview:_blackPawnView];
    
    UIImage* blackRookImage = [UIImage imageNamed: @"blackRook.png"];
    _blackRookView = [[UIImageView alloc] initWithImage: blackRookImage];
    _blackRookView.alpha = 0.0;
    [self addSubview:_blackRookView];
    
    UIImage* blackKnightImage = [UIImage imageNamed: @"blackKnight.png"];
    _blackKnightView = [[UIImageView alloc] initWithImage: blackKnightImage];
    _blackKnightView.alpha = 0.0;
    [self addSubview:_blackKnightView];
    
    UIImage* blackBishopImage = [UIImage imageNamed: @"blackBishop.png"];
    _blackBishopView = [[UIImageView alloc] initWithImage: blackBishopImage];
    _blackBishopView.alpha = 0.0;
    [self addSubview:_blackBishopView];
    
    UIImage* blackQueenImage = [UIImage imageNamed: @"blackQueen.png"];
    _blackQueenView = [[UIImageView alloc] initWithImage: blackQueenImage];
    _blackQueenView.alpha = 0.0;
    [self addSubview:_blackQueenView];
    
    UIImage* blackKingImage = [UIImage imageNamed: @"blackKing.png"];
    _blackKingView = [[UIImageView alloc] initWithImage: blackKingImage];
    _blackKingView.alpha = 0.0;
    [self addSubview:_blackKingView];
}


// updates the UI state
- (void)update
{
    // Update the image on the square
    // Makes assumption about behaviour of pieceAt function
    NSLog(@"ABOUT TO DIE!");
    NSLog(@"Column is: %d and Row is: %d", _column, _row);
    DDHPiece* piece = [_board pieceAtColumn:_column andRow:_row];
    NSLog(@"Will not reach");
    [self updateWhitePieceImageForPiece:piece];
    
    [self updateBlackPieceImageForPiece:piece];
    
    [self updateHighlighted];
    
}

// Method that handles which white piece to display based which
// piece is in the given square.
- (void) updateWhitePieceImageForPiece:(DDHPiece*) piece
{
    // Use handy description method to figure out which piece
    // we should display
    NSString* pieceDescription = [piece description];
    
    // Go through huge conditional statements to figure out
    // which image to display. Not the sleekest...
    _whitePawnView.alpha = [pieceDescription isEqualToString:@"WhitePawn"];
    _whiteRookView.alpha = [pieceDescription isEqualToString:@"WhiteRook"];
    _whiteKnightView.alpha = [pieceDescription isEqualToString:@"WhiteKnight"];
    _whiteBishopView.alpha = [pieceDescription isEqualToString:@"WhiteBishop"];
    _whiteQueenView.alpha = [pieceDescription isEqualToString:@"WhiteQueen"];
    _whiteKingView.alpha = [pieceDescription isEqualToString:@"WhiteKing"];
}

// Same method for black pieces as updateWhitePieceImage...
- (void) updateBlackPieceImageForPiece:(DDHPiece*) piece
{
    // Use handy description method to figure out which piece
    // we should display
    NSString* pieceDescription = [piece description];
    
    // Go through huge conditional statements to figure out
    // which image to display. Not the sleekest...
    _blackPawnView.alpha = [pieceDescription isEqualToString:@"BlackPawn"];
    _blackRookView.alpha = [pieceDescription isEqualToString:@"BlackRook"];
    _blackKnightView.alpha = [pieceDescription isEqualToString:@"BlackKnight"];
    _blackBishopView.alpha = [pieceDescription isEqualToString:@"BlackBishop"];
    _blackQueenView.alpha = [pieceDescription isEqualToString:@"BlackQueen"];
    _blackKingView.alpha = [pieceDescription isEqualToString:@"BlackKing"];
}

// Update the highlighted status of a square. This entails

- (void) updateHighlighted
{
    if ((_column+_row) % 2 == 0)
    {
        self.backgroundColor = [UIColor cyanColor];
    }
    else
    {
        self.backgroundColor = [UIColor whiteColor];
    }
    
    self.backgroundColor = [_board highlightedAtColumn:_column andRow:_row] ? [UIColor yellowColor] : self.backgroundColor;
    
}

// This function is called by the Board class through a delegate
// to let the Board Square know it should display an updated
// image.
-(void) pieceChangedAtColumn:(int)column addRow:(int)row
{
    if ((column == _column && row == _row) || (column == -1 && row == -1))
    {
        [self update];
    }
}

// YOYOYO DUSTIN YOU SHOULD READ THIS SO YOU CAN MAKE THE
// METHODS I REQUEST IN IT
- (void)cellTapped: (UITapGestureRecognizer *)recognizer
{
    NSLog(@"Tapped at column: %d and row: %d", _column, _row);
    // First, move to the square if it is highlighted
    if ([_board highlightedAtColumn:_column andRow:_row])
    {
        NSLog(@"Tapped Highlighted Square!");
        // Here, board takes care of figuring out which piece exactly will be moving.
        [_board makeMoveToColumn:_column andRow:_row];
    }
    
    // Next clear all highlighting so that we can ensure only
    // the right squares are highlighted and previously
    // highlighted squares are unhighlighted if necessary.
    [_board clearHighlighting];
    
    // Next highlight the proper squares based on whose turn it
    // is and which piece is tapped.
    
    // First, check if the square tapped contains a piece.
    if (![_board isEmptySquareAtColumn:_column andRow:_row])
    {
        NSLog(@"YAY");
        // Next, get the piece in the square
        // First, get the piece.
        DDHPiece* piece = [_board pieceAtColumn:_column andRow:_row];
        
        // Next, check if the piece is of the proper color
        if ([_board nextMove] == [piece getPlayer])
        {
            NSLog(@"YUPYUP");
            // At this point, we know the user has tapped a
            // square containing a piece that is of the same
            // color as the player who is set to make the next
            // move, so highlight the squares that piece can
            // move to.
            
            // THIS FUNCTION DOESN'T EXIST YET, BUT IT SHOULD!
            [_board highlightMovesForPieceAtColumn:_column andRow:_row];
        }
    }
    
}

@end