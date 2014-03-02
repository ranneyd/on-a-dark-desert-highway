//
//  DDHBoardSquare.m
//  DDHChess
//
//  Created by Colin Eberhardt and modified by Dustin Kane, Will Clausen and Zakkai Davidson on 2/15/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHBoardSquare.h"

@implementation DDHBoardSquare
{
    int _row;
    int _column;
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
    _blackQueenView.alpha = 1.0;
    [self addSubview:_blackQueenView];
    
    UIImage* blackKingImage = [UIImage imageNamed: @"blackKing.png"];
    _blackKingView = [[UIImageView alloc] initWithImage: blackKingImage];
    _blackKingView.alpha = 1.0;
    [self addSubview:_blackKingView];
}


// updates the UI state
- (void)update
{
    // show / hide the images based on the cell state
//    DDHPiece* piece = [_board pieceAtColumn:_column andRow:_row];
//    NSLog(@"%@", [piece description]);
    
    // Update the image on the square
    
}

-(void) cellPieceChanged:(DDHPiece*)piece forColumn:(int)column addRow:(int)row
{
//    if ((column == _column && row == _row) || (column == -1 && row == -1))
//    {
//        [self update];
//    }
}

- (void)cellTapped: (UITapGestureRecognizer *)recognizer
{
    /*
     
     All the stuff that Will did goes here? Maybe?
     
     */
}

@end