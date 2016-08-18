//
//  DetailedCaseStudyView.h
//  R&D app
//
//  Created by AlexCheetah on 8/13/16.
//  Copyright © 2016 softserve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UiUtil.h"
#import "Protocols.h"

@class CaseStudy;

@interface DetailedCaseStudyView : UIView

@property (weak, nonatomic) UIViewController<DetailedCaseStudyOwner> *owner;

- (id)initWithCaseStudy:(CaseStudy *)caseStudy Tag:(NSInteger)tag;

- (void)updateConstraintsForOrientation:(Orientation)orientation;

@end
