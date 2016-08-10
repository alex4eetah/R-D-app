//
//  RotationUtil.m
//  R&D app
//
//  Created by AlexCheetah on 8/10/16.
//  Copyright © 2016 softserve. All rights reserved.
//

#import "Protocols.h"
#import <UIKit/UIKit.h>
#import "RotationUtil.h"

#define CONSTRAINT_VALID_PRIORITY 999
#define CONSTRAINT_INVALID_PRIORITY 1

@implementation RotationUtil

+ (RotationUtil *)sharedUtil
{
    static RotationUtil *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[RotationUtil alloc] init];
    });
    return instance;
}

- (void)animateConstraintsChangingToOrientation:(Orientation) orientation
                              ForViewController:(id <Rotatable>) VC
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        __weak RotationUtil *weakSelf = self;
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

@end
