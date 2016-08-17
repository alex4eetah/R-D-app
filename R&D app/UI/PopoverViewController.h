//
//  PopoverViewController.h
//  R&D app
//
//  Created by Oleksandr Chechetkin on 8/17/16.
//  Copyright © 2016 softserve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Protocols.h"

@interface PopoverViewController : UIViewController

@property (weak, nonatomic) id<PopoverDelegate> delegate;

@end
