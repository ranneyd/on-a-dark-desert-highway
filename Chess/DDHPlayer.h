//
//  DDHPlayer.h
//  Chess
//
//  Created by Dustin Kane on 2/14/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDHPlayer : NSObject

@property int colorValue;       //Determines what color the player is. Color was a reserved word

extern const int WHITE;         //Constants to make referring to colors easier
extern const int BLACK;

+(id) newPlayer: (int) color;

@end
