//
//  RotationConfigurableNavigationController.m
//  R&D app
//
//  Created by AlexCheetah on 8/24/16.
//  Copyright © 2016 softserve. All rights reserved.
//

#import "RotationConfigurableNavigationController.h"

@implementation RotationConfigurableNavigationController

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskPortrait;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

@end
