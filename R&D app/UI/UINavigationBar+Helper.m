//
//  UINavigationBar+Helper.m
//  R&D app
//
//  Created by AlexCheetah on 8/11/16.
//  Copyright © 2016 softserve. All rights reserved.
//

#import "UINavigationBar+Helper.h"

@implementation UINavigationBar (Helper)

- (void)setBottomBorderColor:(UIColor *)color height:(CGFloat)height {
    for (UIView *v in self.subviews) {
        if (v.tag == 245245) {
            [v removeFromSuperview];
        }
    }
    CGRect bottomBorderRect = CGRectMake(0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), height);
    UIView *bottomBorder = [[UIView alloc] initWithFrame:bottomBorderRect];
    bottomBorder.tag = 245245;
    [bottomBorder setBackgroundColor:color];
    [self addSubview:bottomBorder];
}

@end
