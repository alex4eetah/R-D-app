//
//  LoginViewController.m
//  R&D app
//
//  Created by AlexCheetah on 8/9/16.
//  Copyright © 2016 softserve. All rights reserved.
//

#import "LoginViewController.h"

typedef enum {
    Portrait,
    Landscape
}Orientation;

#define CONSTRAINT_VALID_PRIORITY 999
#define CONSTRAINT_INVALID_PRIORITY 1

@interface LoginViewController ()
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *potraitConstraints;

@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *landscapeConstraints;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    BOOL isInLandscape = (size.width > size.height);
    
    // Code here will execute before the rotation begins.
    // Equivalent to placing it in the deprecated method -[willRotateToInterfaceOrientation:duration:]
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
        // Place code here to perform animations during the rotation.
        // You can pass nil or leave this block empty if not necessary.
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
        // Code here will execute after the rotation has finished.
        // Equivalent to placing it in the deprecated method -[didRotateFromInterfaceOrientation:]
        
        [self animateConstraintsChangingToOrientation: isInLandscape? Landscape: Portrait];
        
    }];
}

- (void)animateConstraintsChangingToOrientation:(Orientation) orientation
{
    __weak LoginViewController *weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        if (orientation == Portrait) {
            [weakSelf dropConstraintsInArray:weakSelf.landscapeConstraints];
            [weakSelf setConstraintsInArray:weakSelf.potraitConstraints];
        } else {
            [weakSelf dropConstraintsInArray:weakSelf.potraitConstraints];
            [weakSelf setConstraintsInArray:weakSelf.landscapeConstraints];
        }
        [weakSelf.view layoutIfNeeded];
    }];
}

- (void)dropConstraintsInArray:(NSArray *)array
{
    for (NSLayoutConstraint *constraint in array) {
        constraint.priority = CONSTRAINT_INVALID_PRIORITY;
    }
}

- (void)setConstraintsInArray:(NSArray *)array
{
    for (NSLayoutConstraint *constraint in array) {
        constraint.priority = CONSTRAINT_VALID_PRIORITY;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
