//
//  DDHRandomChessController.m
//  DDHChess
//
//  Created by CS121 on 4/1/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDHRandomChessController.h"
#import "DDHBoard.h"
#import "DDHChessBoardView.h"
#import "DDHChessInfoView.h"
#import "DDHViewController.h"

@interface DDHRandomChessController ()

@end

@implementation DDHRandomChessController
{
    DDHBoard* _board; // Contains the board on which the game will be played
    BOOL random;
    BOOL quit;
    DDHViewController* parent_;
}

@synthesize transitionController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andRandom: (BOOL) rand andParent:(UIViewController *)parent
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        random = rand;
        quit = NO;
        parent_ = (DDHViewController *)parent;
        //[self setMenu:[[DDHMenuViewController alloc] init]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    DDHChessInfoView* info = [[DDHChessInfoView alloc] initWithFrame:[[UIScreen mainScreen]applicationFrame]];
    
    
    // Create the board object
    _board = [[DDHBoard alloc] initWithView:info];
    // Initialize the board
    if(random)
        [_board setToInitialRandomState];
    else
        [_board setToInitialState];
    
    
    // Set background color. For displaying images, use self.backgroundImage.image = [UIImage imageNamed: @"image.png"]
    self.view.backgroundColor = [UIColor blackColor];
    
    // Create and initialize view to display the board and add it to this controller
    DDHChessBoardView* chessBoard = [[DDHChessBoardView alloc] initWithFrame:CGRectMake(88,([[UIScreen mainScreen]applicationFrame].size.height - 585.0)/2.0,600, 585) andBoard:_board];
    
    [self.view addSubview:info];
    [self.view addSubview:chessBoard];
    
    CGSize size = self.view.frame.size;
    int width = 100;
    int height = 50;
    UIButton * settings = [[UIButton alloc] initWithFrame:CGRectMake(size.width-width - 50,size.height-height - 50,width,height)];
    [settings addTarget:self action:@selector(settings:) forControlEvents:UIControlEventTouchUpInside];
    [settings setBackgroundColor: [UIColor clearColor]];
    settings.layer.borderColor = [UIColor colorWithRed:0.502 green:0 blue:0 alpha:1].CGColor;
    settings.layer.borderWidth = 2;
    settings.layer.cornerRadius = 10;
    settings.layer.masksToBounds = NO;
    
    [settings setTitle:@"Settings" forState:UIControlStateNormal];
    //[[settings titleLabel] setTextColor:[UIColor colorWithRed:0.502 green:0 blue:0 alpha:1]];
     
    [self.view addSubview:settings];
    
    
    self.transitionController = [[TransitionDelegate alloc] init];
}

- (IBAction)settings:(id) sender
{
    DDHMenuViewController *controller = [[DDHMenuViewController alloc] initWithNibName:nil bundle:nil];
    
    //controller.view.backgroundColor = [UIColor clear];
    [controller setTransitioningDelegate:transitionController];
    controller.modalPresentationStyle= UIModalPresentationCustom;
    
    [self presentViewController:controller animated:YES completion: nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) quitView
{
    NSLog(@":D");
    [self dismissViewControllerAnimated:NO completion:nil];
    [parent_ startFalling:self];

}
@end
