//
//  DDHBoardSquare.m - Implementation of the single square view
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
    
    // View to display current image depending on state of square
    UIImageView* _currentImageView;
}

// **********************
// ** PUBLIC FUNCTIONS **
// **********************

// Creation method for squares.
- (id)initWithFrame:(CGRect)frame column:(NSInteger)column row:(NSInteger)row board:(DDHBoard *)board
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Set data members properly given input.
        _row = row;
        _column = column;
        _board = board;
        
        // Determine color of square based on position in board
        [self setColor];
        
        // Set additional values for squares.
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = [UIColor clearColor].CGColor;
        
        // Initialize the view with an arbitrary image that will be overwritten
        UIImage* startImage = [UIImage imageNamed: @"NullPiece.png"];
        _currentImageView = [[UIImageView alloc] initWithImage: startImage];
        [self addSubview:_currentImageView];
        
        [self update];
    }
    
    // Add the square to the board.
    [_board.boardDelegate addDelegate:self];
    
    // Add a tap recognizer.
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellTapped:)];
    [self addGestureRecognizer:tapRecognizer];
    
    return self;
}

// ***********************
// ** PRIVATE FUNCTIONS **
// ***********************

// ******************************
// ** Initialization Functions **
// ******************************

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
        // Values were tuned to make the board look nice
        _color = [UIColor colorWithRed:0.502 green:0 blue:0 alpha:1];
    }
    
    // Display the proper color of the square
    self.backgroundColor = _color;
}

// ***************************
// ** View Update Functions **
// ***************************

// Method that updates the UIView state.
- (void)update
{
    // Determine name of piece in square
    DDHPiece* piece = [_board pieceAtColumn:_column andRow:_row];
    NSString* pieceDescription = [piece description];
    
    // Change to image of correct piece
    UIImage* newImage = [UIImage imageNamed:[pieceDescription stringByAppendingString: @".png"]];
    _currentImageView.image = newImage;
    
    // Update the highlighting of the square
    [self updateHighlighted];
}

// Update the highlighted status of a square.
- (void) updateHighlighted
{
    // If the square has the piece the user selected, put a white border around the piece.
    if ([ _board highlightOwnerAtColumn:_column andRow:_row]) {
        self.layer.borderColor = [UIColor orangeColor].CGColor;
    }
    // If the square is a place the selected piece could move, highlight it yellow with black borders.
    else if ([_board highlightedAtColumn:_column andRow:_row]) {
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.backgroundColor = [UIColor yellowColor];
    }
    // Otherwise, restore the color to default
    else
    {
        self.backgroundColor = _color;
        // If the piece isn't highlighted, no need to display the border
        self.layer.borderColor = [UIColor clearColor].CGColor;
    }
}

// ************************
// ** Delegate Functions **
// ************************

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

// **************************
// ** User Input Functions **
// **************************

// Handles user input based on the state of the board
- (void)cellTapped: (UITapGestureRecognizer *)recognizer
{
    // If the square is highlighted, tell the board to move there and end
    if ([_board highlightedAtColumn:_column andRow:_row])
    {
        [_board makeMoveToColumn:_column andRow:_row];
        [_board clearHighlighting];
        return;
    }
    
    // Clear all highlighting so that we can ensure only
    // the right squares are highlighted and previously
    // highlighted squares are unhighlighted if necessary.
    [_board clearHighlighting];
    
    // Next highlight the proper squares based on whose turn it
    // is and which piece is tapped.
    
    // Check if the square tapped contains a piece.
    if (![_board isEmptySquareAtColumn:_column andRow:_row])
    {
        // Next, get the piece in the square
        DDHPiece* piece = [_board pieceAtColumn:_column andRow:_row];
        
        // Next, check if the piece is of the proper color
        if ([_board nextMove] == [piece getPlayer])
        {
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