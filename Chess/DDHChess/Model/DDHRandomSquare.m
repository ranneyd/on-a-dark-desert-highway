//
//  DDHRandomSquare.m
//  Chess?
//
//  Created by Dustin Kane on 4/16/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHRandomSquare.h"
#import "DDHBoardDelegate.h"


@implementation DDHRandomSquare {
    id<DDHBoardDelegate> _delegate;
}

-(id) initWithColumn:(NSUInteger)column andRow:(NSUInteger)row andBoard:(DDHBoard *) board
{
    self = [super init];
    
    [self setType:arc4random()%NumTypes];
    [self setX:column];
    [self setY:row];
    [self setBoard:board];
    
    _delegate = (id)[[DDHMulticastDelegate alloc] init];
    
    return self;
}

-(id)initNull
{
    self = [super init];
    
    [self setType: NullSquare];
    [self setX:0];
    [self setY:0];
    [self setBoard:NULL];
    
    return self;
}

-(void) trigger
{
    switch ([self type]){
        case DestroyPiece:
            [self popupWithTitle:@"Random Square: Landmine!" andMessage:@"You stepped on a land mine! You die now!"];
            [[self board] destroyPieceAtColumn:[self x] andRow:[self y]];
            break;
        default:
            NSLog(@"Default");
            break;
    }
}
-(void) popupWithTitle:(NSString*) title andMessage:(NSString *) message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"Okay!" otherButtonTitles:nil];
    [alert show];
}


@end
