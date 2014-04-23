//
//  RandomSquare.h
//  Chess?
//
//  Created by Dustin Kane on 4/16/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//


//Include guards from the tutorial. Assume they are important
#ifndef Chess__RandomSquare_h
#define Chess__RandomSquare_h


// Make our lives easier by defining chess players as ints
typedef NS_ENUM(int, RandomSquare){
    DestroyPiece = 0,
    TeleportPiece = 1,
    TeleportEnemy = 2,
    DestroyEnemy = 3,
    FallThrough = 4,
    NullSquare = 5,
    HugeLandmine = 6,
    LukeSkywalker = 7,
    DarthVader = 8,
    NumTypes = 9
};

#endif
