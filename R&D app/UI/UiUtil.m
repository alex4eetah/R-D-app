//
//  RotationUtil.m
//  R&D app
//
//  Created by AlexCheetah on 8/10/16.
//  Copyright © 2016 softserve. All rights reserved.
//

#import "Protocols.h"
#import "UiUtil.h"



@implementation UiUtil

+ (UiUtil *)sharedUtil
{
    static UiUtil *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[UiUtil alloc] init];
    });
    return instance;
}

/*
**** Rotating stuff
*/

- (void)animateConstraintsChangingToOrientation:(Orientation) orientation
                              ForViewController:(id <Rotatable>) VC
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        __weak UiUtil *weakSelf = self;
        [UIView animateWithDuration:0.25 animations:^{
            if (orientation == Portrait) {
                [weakSelf dropConstraintsInArray:VC.landscapeConstraints];
                [weakSelf setConstraintsInArray:VC.potraitConstraints];
            } else {
                [weakSelf dropConstraintsInArray:VC.potraitConstraints];
                [weakSelf setConstraintsInArray:VC.landscapeConstraints];
            }
            [VC.view layoutIfNeeded];
        }];
    }
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
**** Constraint stuff
*/

- (void)animateChangingOfConstraint:(NSLayoutConstraint *)constraint
                            ToValue:(CGFloat)value
                       WithDuration:(double)duration
                            ForView:(UIView *) view
{
    constraint.constant = value;
    [view setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:duration animations:^
     {
         [view layoutIfNeeded];
     }];
}

/*
**** Value stuff
*/

- (void)animateChangingOfFrameForView:(UIView *)view
                              ToValue:(CGRect)value
                         WithDuration:(double)duration
{
    [UIView animateWithDuration:duration animations:^
     {
         view.frame = value;
     }];
}

@end
