//
//  LoginViewController.m
//  R&D app
//
//  Created by AlexCheetah on 8/9/16.
//  Copyright © 2016 softserve. All rights reserved.
//

#import "RotationUtil.h"
#import "LoginViewController.h"

@interface LoginViewController ()

@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *potraitConstraints;

@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *landscapeConstraints;

@property (strong, nonatomic) RotationUtil *rotator;

@property (assign, nonatomic) BOOL isInLandscape;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rotator = [RotationUtil sharedUtil];
    self.isInLandscape = (self.view.frame.size.width > self.view.frame.size.height);;
    [self.rotator animateConstraintsChangingToOrientation: self.isInLandscape? Landscape: Portrait
                                        ForViewController:self];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    self.isInLandscape = (size.width > size.height);
    
    // Code here will execute before the rotation begins.
    // Equivalent to placing it in the deprecated method -[willRotateToInterfaceOrientation:duration:]
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
        // Place code here to perform animations during the rotation.
        // You can pass nil or leave this block empty if not necessary.
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
        // Code here will execute after the rotation has finished.
        // Equivalent to placing it in the deprecated method -[didRotateFromInterfaceOrientation:]
        
        [self.rotator animateConstraintsChangingToOrientation: self.isInLandscape? Landscape: Portrait
                                       ForViewController:self];
        
    }];
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
