//
//  DDHViewController.m - Implementation of main game view controller
//  DDHChess
//
//  Created by Colin Eberhardt and modified by Dustin Kane, Will Clausen and Zakkai Davidson on 2/15/14.
//  Copyright (c) 2012 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDHViewController.h"

#import <QuartzCore/QuartzCore.h>


@interface DDHViewController()
@property (weak, nonatomic) IBOutlet UIButton *randomChessButton;
@property (weak, nonatomic) IBOutlet UIButton *randomChessSuperButton;
@property (weak, nonatomic) IBOutlet UIButton *boringChessButton;

@end

@implementation DDHViewController
{
    AVAudioPlayer *player_;
    BOOL falling;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    falling = YES;
    _randomChessButton.layer.cornerRadius = 20;
    _randomChessButton.layer.shadowRadius= 3.0f;
    _randomChessButton.layer.shadowColor = [UIColor blackColor].CGColor;
    _randomChessButton.layer.shadowOpacity = 0.5f;
    _randomChessButton.layer.shadowOffset = CGSizeMake(8.0f, 8.0f);
    _randomChessButton.layer.masksToBounds = NO;
    
    
    _randomChessSuperButton.layer.cornerRadius = 20;
    _randomChessSuperButton.layer.shadowRadius= 3.0f;
    _randomChessSuperButton.layer.shadowColor = [UIColor blackColor].CGColor;
    _randomChessSuperButton.layer.shadowOpacity = 0.5f;
    _randomChessSuperButton.layer.shadowOffset = CGSizeMake(8.0f, 8.0f);
    _randomChessSuperButton.layer.masksToBounds = NO;
    
    
    
    _boringChessButton.layer.cornerRadius = 5;
    _boringChessButton.layer.masksToBounds = YES;
    _boringChessButton.layer.shadowRadius= 1.0f;
    _boringChessButton.layer.shadowColor = [UIColor blackColor].CGColor;
    _boringChessButton.layer.shadowOpacity = 0.5f;
    _boringChessButton.layer.shadowOffset = CGSizeMake(3.0f, 3.0f);
    
    [self loadPieces];
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"metal" ofType:@"mp3"];
    NSURL *file = [[NSURL alloc] initFileURLWithPath:path];
    
    player_ = [[AVAudioPlayer alloc] initWithContentsOfURL:file error:nil];
    
    player_.numberOfLoops = -1;
    [player_ prepareToPlay];
    
    
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    if ([settings boolForKey:@"musicOn"])
        [player_ play];

}

-(void) loadPieces
{
    
    NSArray *pieces = [NSArray arrayWithObjects: @"WhiteQueen.png",
                                                 @"WhiteKing.png",
                                                 @"WhiteRook.png",
                                                 @"WhiteKnight.png",
                                                 @"WhiteBishop.png",
                                                 @"WhitePawn.png",
                                                 @"BlackQueen",
                                                 @"BlackKing.png",
                                                 @"BlackRook.png",
                                                 @"BlackKnight.png",
                                                 @"BlackBishop.png",
                                                 @"BlackPawn.png",
                                                 nil];
    
    for (int i = 0; i < 20; i++){
        UIImageView *queen = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[pieces objectAtIndex:arc4random()%[pieces count]]]];
        [queen setAlpha:0.8];
        [self.view addSubview:queen];
        [self.view sendSubviewToBack:queen];
        
        int x = [self setPieceRandomTop:queen];
        //CGRect rect = [queen frame];
        //[queen setFrame:CGRectMake(rect.origin.x, arc4random()%((int)[[UIScreen mainScreen]applicationFrame].size.height+100) - 50 , rect.size.width, rect.size.height)];
        [self.view addSubview:queen];
        [self.view sendSubviewToBack:queen];
        [self fallPiece:queen atX:x];
    }
}
-(void) fallPiece:(UIImageView*) piece atX:(int) x{
    if (falling){
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [UIView commitAnimations];
        double distance = self.view.frame.size.height +100 - [piece frame].origin.y;
        double speed = 200.0;
        [UIView animateWithDuration: distance/speed delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            [piece setFrame:CGRectMake(x, self.view.frame.size.height + 100, 100, 100)];
        } completion:^(BOOL finished){
            [self fallPiece:piece atX:[self setPieceRandomTop:piece]];
        }];
    }
}
-(int) setPieceRandomTop:(UIImageView*) piece
{
    int x = arc4random()%((int)self.view.frame.size.width - 200) +50;
    [piece setFrame:CGRectMake(x, -100-(int)(arc4random()%(int)self.view.frame.size.height), 100, 100)];
    return x;
}
-(void) startFalling: (DDHRandomChessController *) caller
{
    [caller dismissViewControllerAnimated:YES completion:nil];
    falling = YES;
    [self loadPieces];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)randomChessAction:(id)sender
{
    DDHRandomChessController *controller = [[DDHRandomChessController alloc] initWithNibName:nil bundle:nil andRandom:YES];
    falling = NO;
    [self presentViewController:controller animated:NO completion:nil];
}

- (IBAction)superRandomChessAction:(id)sender
{
    DDHRandomChessController *controller = [[DDHRandomChessController alloc] initWithNibName:nil bundle:nil andRandom:YES];
    falling = NO;
    [self presentViewController:controller animated:NO completion:nil];
}

- (IBAction)boringChessAction:(id)sender
{
    DDHRandomChessController *controller = [[DDHRandomChessController alloc] initWithNibName:nil bundle:nil andRandom:NO];
    falling = NO;
    [self presentViewController:controller animated:NO completion:nil];
}

-(AVAudioPlayer *) getPlayer
{
    return player_;
}
@end
