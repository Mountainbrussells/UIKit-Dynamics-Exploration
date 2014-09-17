//
//  BARViewController.m
//  BARBounceBounce
//
//  Created by Ben Russell on 8/28/14.
//  Copyright (c) 2014 Angry Grouse Media. All rights reserved.
//

#import "BARViewController.h"

@interface BARViewController ()

// Animator properties
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) UIGravityBehavior *gravityBehavior;
@property (strong, nonatomic) UICollisionBehavior *collisionBehavior;
@property (strong, nonatomic) UIDynamicItemBehavior *itemBehavior;

// Drag Properties
@property CGPoint currentLocation;
@property (strong, nonatomic) UIAttachmentBehavior *attachment;

@property (weak, nonatomic) IBOutlet UIView *ballView;
@end

@implementation BARViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    self.ballView.backgroundColor = [UIColor redColor];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    // init gravity behavior with bounds of view
    self.gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.ballView]];
    self.gravityBehavior.magnitude = 1.0;
    [self.animator addBehavior:self.gravityBehavior];
    
    // add collision behavior with bounds of the view
    self.collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.ballView]];
    self.collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    
    [self.animator addBehavior:self.collisionBehavior];
    
    self.itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.ballView]];
    self.itemBehavior.elasticity = .75;
    [self.animator addBehavior:self.itemBehavior];
    
}

// Touch gestures to move ball view

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *theTouch = [touches anyObject];
    
    _currentLocation = [theTouch locationInView:self.view];
    
    _attachment = [[UIAttachmentBehavior alloc] initWithItem:_ballView attachedToAnchor:_currentLocation];
    
    [_animator addBehavior:_attachment];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *theTouch = [touches anyObject];
    _currentLocation = [theTouch locationInView:self.view];
    _attachment.anchorPoint = _currentLocation;
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_animator removeBehavior:_attachment];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
