//
//  RotationUtil.h
//  R&D app
//
//  Created by AlexCheetah on 8/10/16.
//  Copyright © 2016 softserve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define CONSTRAINT_VALID_PRIORITY 999
#define CONSTRAINT_INVALID_PRIORITY 1

typedef enum {
    Portrait,
    Landscape
}Orientation;

@protocol Rotatable;

@interface UiUtil : NSObject

+ (UiUtil *)sharedUtil;

- (void)animateWrongInputOnLayer:(CALayer *)layer;

- (void)animateConstraintsChangingToOrientation:(Orientation) orientation
                              ForViewController:(id <Rotatable>) VC;

- (void)animateChangingOfConstraint:(NSLayoutConstraint *)constraint
                            ToValue:(CGFloat)value
                       WithDuration:(double)duration
                            ForView:(UIView *) view;

- (void)animateChangingOfFrameForView:(UIView *)view
                            ToValue:(CGRect)value
                       WithDuration:(double)duration;

- (void)addNavigationButtonForTarget:(UIViewController *)obj
                            Selector:(SEL)selector
                       ImageWithName:(NSString *)img
                                Size:(CGSize)size
                                Left:(BOOL)isLeft;

@end
