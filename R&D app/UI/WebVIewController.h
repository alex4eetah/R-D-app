//
//  WebVIewController.h
//  R&D app
//
//  Created by Oleksandr Chechetkin on 8/18/16.
//  Copyright © 2016 softserve. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebVIewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) NSString *url;

@end
