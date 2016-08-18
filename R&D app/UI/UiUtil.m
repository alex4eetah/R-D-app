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

- (void)animateWrongInputOnLayer:(CALayer *)layer
{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.duration = 0.1;
    anim.repeatCount = 4;
    anim.autoreverses = YES;
    anim.removedOnCompletion = YES;
    anim.fromValue = [NSNumber numberWithFloat:-5.f];
    anim.toValue = [NSNumber numberWithFloat:5.f];
    [layer addAnimation:anim forKey:nil];
}

- (void)addNavigationButtonForTarget:(UIViewController *)obj
                            Selector:(SEL)selector
                       ImageWithName:(NSString *)img
                                Size:(CGSize)size
                                Left:(BOOL)isLeft
{
    UIImage* image = [UIImage imageNamed:img];
    CGRect frameimg = CGRectMake(0, 0, size.width, size.height);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:image forState:UIControlStateNormal];
    [someButton addTarget:obj action:selector forControlEvents:UIControlEventTouchUpInside];
    [someButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *BarButton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    if (isLeft) {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        [arr addObject:BarButton];
        for (UIBarButtonItem *item in obj.navigationItem.leftBarButtonItems)
        {
            [arr addObject:item];
        }
        
        obj.navigationItem.leftBarButtonItems = arr;
    } else {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        [arr addObject:BarButton];
        for (UIBarButtonItem *item in obj.navigationItem.rightBarButtonItems)
        {
            [arr addObject:item];
        }
        
        obj.navigationItem.rightBarButtonItems = arr;
    }
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
