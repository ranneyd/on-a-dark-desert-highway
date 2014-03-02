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
    
    // 
    UIImageView* _whiteView;
}

- (id)initWithFrame:(CGRect)frame column:(NSInteger)column row:(NSInteger)row board:(DDHBoard *)board
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _row = row;
        _column = column;
        _board = board;
        
        // create the views for the playing piece graphics
        UIImage* blackImage = [UIImage imageNamed: @"ReversiBlackPiece.png"];
        _blackView = [[UIImageView alloc] initWithImage: blackImage];
        _blackView.alpha = 0.0;
        [self addSubview:_blackView];
        
        UIImage* whiteImage = [UIImage imageNamed: @"ReversiWhitePiece.png"];
        _whiteView = [[UIImageView alloc] initWithImage: whiteImage];
        _whiteView.alpha = 0.0;
        [self addSubview:_whiteView];
        
        self.backgroundColor = [UIColor clearColor];
        
        [self update];
    }
    [_board.boardDelegate addDelegate:self];
    
    // add a tap recognizer
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellTapped:)];
    [self addGestureRecognizer:tapRecognizer];
    
    return self;
}

// updates the UI state
- (void)update
{
    // show / hide the images based on the cell state
    DDHPiece* piece = [_board pieceAtColumn:_column andRow:_row];
    NSLog(@"%", [piece description]);
    
    // Update the image on the square
    
}

-(void) cellPieceChanged:(DDHPiece*)piece forColumn:(int)column addRow:(int)row
{
    if ((column == _column && row == _row) || (column == -1 && row == -1))
    {
        [self update];
    }
}

- (void)cellTapped: (UITapGestureRecognizer *)recognizer
{
    /*
     
     All the stuff that Will did goes here? Maybe?
     
     */
}

@end