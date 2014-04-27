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
    DestroyPlayer = 0,
    TeleportPlayer = 1,
    TeleportEnemy = 2,
    DestroyEnemy = 3,
    FallThrough = 4,
    HugeLandmine = 5,
    NewPiece = 6,
    EnemyDoubleAgent = 7,
    PlayerDoubleAgent = 8,
    ChangeSides = 9,
    CarpetBomb = 10,
    LukeSkywalker = 11,
    DarthVader = 12,
    NumTypes = 13,
    NullSquare = 14
};

#endif
