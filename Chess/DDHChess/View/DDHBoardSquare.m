//
//  DDHBoardSquare.m - Implementation of the single square view
//  DDHChess
//
//  Created by Dustin Kane, Will Clausen, and Zakkai Davidson on 3/4/14. Adapted from code by Colin Eberhardt.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHBoardSquare.h"
#import "DDHBoard.h"
#import "DDHPawn.h"
#import "DDHRandomSquare.h"
#import "QuartzCore/QuartzCore.h"

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
    
    BOOL _upsideDown;
    
    BOOL _pulsating;
    BOOL _animating;
    
    UIView *_highlight;
    UIImageView* _questionMark;
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
        _upsideDown = NO;
        _pulsating = NO;
        _animating = NO;
        
        
        // Determine color of square based on position in board
        [self setColor];
        
        // Set additional values for squares.
        self.layer.borderColor = [UIColor clearColor].CGColor;
        
        if ([board randomAtColumn:column andRow:row]){
            _questionMark = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"questionMark.png"]];
            [[_questionMark layer] setFrame:CGRectMake(frame.size.width/4.0,frame.size.height/4.0,frame.size.width/2.0,frame.size.height/2.0)];
            [self addSubview:_questionMark];
            //[self setBackgroundColor:[UIColor greenColor]];
        }
        int borderWidth = 2;
        
        _highlight = [[UIView alloc]initWithFrame:CGRectMake(borderWidth,borderWidth, frame.size.width-borderWidth*2,frame.size.height-borderWidth*2)];
        [_highlight setBackgroundColor:[UIColor clearColor]];
        //[[_highlight layer] setBorderWidth:borderWidth];
        //[[_highlight layer] setBorderColor:[UIColor clearColor].CGColor];
        [_highlight setUserInteractionEnabled:NO];
        [_questionMark setUserInteractionEnabled:NO];
        
        [self addSubview:_highlight];
        
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
    
    if(![_board randomAtColumn:_column andRow:_row]){
        [_questionMark setImage:[UIImage imageNamed: @"NullPiece.png"]];
    }

    // If there is a wall there, change the color and image
    if(![_board hasNoWallAtColumn:_column andRow:_row]){
        //self.backgroundColor = [UIColor darkGrayColor];
        UIImageView* hole = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hole.png"]];
        [hole setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:hole];
        [self sendSubviewToBack:hole];
    }
    
    // Update the highlighting of the square
    [self updateHighlighted];
}

// Update the highlighted status of a square.
- (void) updateHighlighted
{
    // If the square has the piece the user selected, put an orange border around the piece.
    if ([ _board isHighlightOwnerAtColumn:_column andRow:_row]) {
        self.layer.borderColor = [UIColor orangeColor].CGColor;
    }
    // If the square is a place the selected piece could move, highlight it yellow with black borders.
    else if ([_board highlightedAtColumn:_column andRow:_row]) {
        //_highlight.layer.borderColor = (_color == [UIColor blackColor] ? [UIColor colorWithRed:0.502 green:0 blue:0 alpha:1].CGColor : [UIColor blackColor].CGColor);
        _highlight.backgroundColor = [UIColor yellowColor];
        [self killPulse];
        _pulsating = YES;
        [self pulsate];
    }
    // Otherwise, restore the color to default
    else
    {
        _highlight.backgroundColor = [UIColor clearColor];
        // If the piece isn't highlighted, no need to display the border
        //self.layer.borderColor = [UIColor clearColor].CGColor;
        [self killPulse];
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

// image.
-(void) explodeAtColumn:(int)column addRow:(int)row
{
    // Note that if the board sends the message with column and row values equal to -1,
    // then the board wants every square to update its state.
    if (column == _column && row == _row){
         NSMutableArray * imageArray = [[NSMutableArray alloc] init];
         for (NSInteger i = 1; i <= 90; i++){
             [imageArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"explosion1_00%@%ld.png", i < 10? @"0" : @"", (long)i]]];
         }
         UIImageView * explosion = [[UIImageView alloc] initWithFrame:
                                    CGRectMake(-45, 50, 50, 50)];
         explosion.animationImages = imageArray;
         explosion.animationDuration = 2.5f;
         explosion.contentMode = UIViewContentModeBottomLeft;
         [self addSubview:explosion];
         [explosion setAnimationRepeatCount:1];
         [explosion startAnimating];
        
        NSString *explosionPath = [[NSBundle mainBundle] pathForResource:@"explosion" ofType:@"wav"];
        NSURL *explosionURL = [NSURL fileURLWithPath:explosionPath];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)explosionURL, &_explosionSound);
        AudioServicesPlaySystemSound(_explosionSound);
    }
}

-(void) rotate
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationRepeatCount:1];
    _currentImageView.transform = CGAffineTransformMakeRotation(_upsideDown? 0 : M_PI);
    _questionMark.transform = CGAffineTransformMakeRotation(_upsideDown? 0 : M_PI);
    [UIView commitAnimations];
    
    _upsideDown = !_upsideDown;
}

// **************************
// ** User Input Functions **
// **************************

// Handles user input based on the state of the board
- (void)cellTapped: (UITapGestureRecognizer *)recognizer
{
    NSLog(@"Yo I got tapped yo");
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
        
        if([piece isKindOfClass:[DDHPawn class]]){
            if([(DDHPawn*)piece click] == 50 && [piece getPlayer] == [_board nextMove]){
                [_board destroyPieceAtColumn:_column andRow:_row];
                [_board clearHighlighting];
            }
        }
        
        // Next, check if the piece is of the proper color
        if ([_board nextMove] == [piece getPlayer])
        {
            // At this point, we know the user has tapped a
            // square containing a piece that is of the same
            // color as the player who is set to make the next
            // move, so highlight the squares that piece can
            // move to.
            //NSLog(@"Highlighting for piece at column:%d and row:%d", _column, _row);
            [_board highlightMovesForPieceAtColumn:_column andRow:_row];
        }
    }
    
}
-(void) pulsate
{
    if(_pulsating && !_animating){
        _animating = YES;
        [UIView animateWithDuration:1 animations:^{
            [_highlight setAlpha:0.5];
        } completion:^(BOOL finished){
            if(_pulsating){
                [UIView animateWithDuration:1 animations:^{
                    [_highlight setAlpha:1];
                } completion:^(BOOL finished){
                    _animating = NO;
                    [self pulsate];
                }];
            }
            else{
                [self killPulse];
                _animating = NO;
            }
        }];
    }
}
-(void) killPulse
{
    _pulsating = NO;
    [_highlight setAlpha:1];
    [_highlight.layer removeAllAnimations];
}

-(void) randomLandAtColumn:(NSUInteger)column addRow:(NSUInteger)row withSquare:(DDHRandomSquare*) square
{
    if (column == _column && row == _row){
        
        [[self superview] bringSubviewToFront:self];
        float duration = 2.0;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView setAnimationRepeatCount:21];
        _questionMark.transform = CGAffineTransformMakeRotation(_upsideDown? 0 : M_PI);
        [UIView commitAnimations];
        
        [UIView animateWithDuration:duration animations:^{
            CGRect qMark = [_questionMark frame];
            int scale = 20;
            [_questionMark setAlpha:0];
            [_questionMark setFrame:CGRectMake(qMark.origin.x - qMark.size.width*scale/2.0, qMark.origin.y - qMark.size.height*scale/2.0, qMark.size.width*scale, qMark.size.height*scale)];
        } completion:^(BOOL finished){
            [square trigger];
        }];
    }
}

@end