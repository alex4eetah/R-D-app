//
//  RotationUtil.h
//  R&D app
//
//  Created by AlexCheetah on 8/10/16.
//  Copyright © 2016 softserve. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    Portrait,
    Landscape
}Orientation;

@protocol Rotatable;

@interface RotationUtil : NSObject

+ (RotationUtil *)sharedUtil;

- (void)animateConstraintsChangingToOrientation:(Orientation) orientation
                              ForViewController:(id <Rotatable>) VC;

@end
