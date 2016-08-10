//
//  RotationUtil.h
//  R&D app
//
//  Created by AlexCheetah on 8/10/16.
//  Copyright © 2016 softserve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    Portrait,
    Landscape
}Orientation;

@protocol Rotatable;

@interface UiUtil : NSObject

+ (UiUtil *)sharedUtil;

- (void)animateConstraintsChangingToOrientation:(Orientation) orientation
                              ForViewController:(id <Rotatable>) VC;

- (void)animateChangingOfConstraint:(NSLayoutConstraint *)constraint
                            ToValue:(CGFloat)value
                       WithDuration:(double)duration
                            ForView:(UIView *) view;

- (void)animateChangingOfFrameForView:(UIView *)view
                            ToValue:(CGRect)value
                       WithDuration:(double)duration;

@end
