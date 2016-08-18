//
//  Protocols.h
//  R&D app
//
//  Created by AlexCheetah on 8/10/16.
//  Copyright © 2016 softserve. All rights reserved.
//

#ifndef Protocols_h
#define Protocols_h

@class NSArray;
@class UIView;

@protocol Rotatable

- (UIView *)view;
- (NSArray *)potraitConstraints;
- (NSArray *)landscapeConstraints;

@end

@protocol PopoverDelegate

- (void)dismissToRoot;
- (void)showChangePasswordModal;

@end

#endif /* Protocols_h */
