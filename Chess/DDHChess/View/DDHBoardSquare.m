//
//  DDHBoardSquare.m
//  DDHChess
//
//  Created by Dustin Kane, Will Clausen, and Zakkai Davidson on 3/4/14. Adapted from code by Colin Eberhardt.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHBoardSquare.h"
#import "DDHBoard.h"

// This class handles the UI for individual squares in our chessboard
@implementation DDHBoardSquare
{
    // The location of the square on the board, i.e. row and column indices
    NSUInteger _row;
    NSUInteger _column;
    
    // The board on which this square lives
    DDHBoard* _board;
    
    // The color of the square;
    UIColor* _color;
    
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

// Creation method for squares.
- (id)initWithFrame:(CGRect)frame column:(NSInteger)column row:(NSInteger)row board:(DDHBoard *)board
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Set data members properly given input.
        _row = row;
        _column = column;
        _board = board;
        
        [self setColor];
        
        // create the views for the playing piece graphics
        [self initWhitePieceViews];
        
        [self initBlackPieceViews];
        
        // Set additional values for squares.
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = [UIColor clearColor].CGColor;
        
        [self update];
    }
    
    // Add the square to the board.
    [_board.boardDelegate addDelegate:self];
    
    // Add a tap recognizer.
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellTapped:)];
    [self addGestureRecognizer:tapRecognizer];
    
    return self;
}

// Method that stores the proper background color and displays it.
-(void) setColor
{
    // Set the proper background color of the square based on the location on the board.
    if ((_column+_row) % 2 == 1)
    {
        _color = [UIColor blackColor];
    }
    else
    {
        _color = [UIColor colorWithRed:0.502 green:0 blue:0 alpha:1];
    }
    
    // Display the proper color of the square
    self.backgroundColor = _color;
}

// Method that creates and adds the views for all of the possible white pieces to a given square.
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

// Method that creates and adds the views for all of the possible black pieces to a given square.
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


// Method that updates the UI state.
- (void)update
{
    // Update the image on the square
    // TODO: Remove debug statements
//    NSLog(@"ABOUT TO DIE!");
//    NSLog(@"Column is: %d and Row is: %d", _column, _row);
    DDHPiece* piece = [_board pieceAtColumn:_column andRow:_row];
    // TODO: Remove debug statements
    //NSLog(@"Piece is: %@", [piece description]);
    [self updateWhitePieceImageForPiece:piece];
    
    [self updateBlackPieceImageForPiece:piece];
    
    // Update the highlighting of the square.
    [self updateHighlighted];
    
}

// Method that handles which white piece to display based which
// piece is in the given square.
- (void) updateWhitePieceImageForPiece:(DDHPiece*) piece
{
    // Use handy description method to figure out which piece
    // we should display
    NSString* pieceDescription = [piece description];
    
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

// Update the highlighted status of a square.
- (void) updateHighlighted
{
    //self.layer.borderColor = [UIColor blackColor].CGColor;
    
    // If the square has the piece the user selected, put a white border around the piece.
    if ([ _board highlightOwnerAtColumn:_column andRow:_row]) {
        NSLog(@"Never getting here?");
        self.layer.borderColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1].CGColor;
    }
    
    // If the square is a place the selected piece could move, highlight it yellow with black borders.
    if ([_board highlightedAtColumn:_column andRow:_row]) {
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.backgroundColor = [UIColor yellowColor];
    }
    else
    {
        // If the piece isn't highlighted, no need to display the border
        self.layer.borderColor = [UIColor clearColor].CGColor;
        
        // TODO: Will, is this the right way to do this? Highlighting keeps staying...  -Zakkai
        // Set the colors of the squares of the board to unhighlighted color
        if ((_column+_row) % 2 == 1)
        {
            self.backgroundColor = [UIColor blackColor];
        }
        else
        {
            self.backgroundColor = [UIColor colorWithRed:0.502 green:0 blue:0 alpha:1];
        }
    }
    
    
}

// This function is called by the Board class through a delegate
// to let the Board Square know it should display an updated
// image.
-(void) pieceChangedAtColumn:(int)column addRow:(int)row
{
    // Note that if the board sends the message with column and row values equal to -1,
    // then the board wants every square to update its state.
    if ((column == _column && row == _row) || (column == -1 && row == -1))
    {
        [self update];
    }
}

// YOYOYO DUSTIN YOU SHOULD READ THIS SO YOU CAN MAKE THE
// METHODS I REQUEST IN IT
- (void)cellTapped: (UITapGestureRecognizer *)recognizer
{
    // TODO: Remove debug statements.
//    NSLog(@"Tapped at column: %d and row: %d", _column, _row);
    
    // First, move to the square if it is highlighted
    if ([_board highlightedAtColumn:_column andRow:_row])
    {
        // TODO: Remove debug statements.
//        NSLog(@"Tapped Highlighted Square!");
        
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
        // TODO: Remove debug statements.
//        NSLog(@"YAY");
        // Next, get the piece in the square
        DDHPiece* piece = [_board pieceAtColumn:_column andRow:_row];
        
        // Next, check if the piece is of the proper color
        if ([_board nextMove] == [piece getPlayer])
        {
            // TODO: Remove debug statements
//            NSLog(@"YUPYUP");
            
            // At this point, we know the user has tapped a
            // square containing a piece that is of the same
            // color as the player who is set to make the next
            // move, so highlight the squares that piece can
            // move to.
            [_board highlightMovesForPieceAtColumn:_column andRow:_row];
        }
    }
    
}

@end