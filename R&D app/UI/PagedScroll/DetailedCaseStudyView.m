//
//  DetailedCaseStudyView.m
//  R&D app
//
//  Created by AlexCheetah on 8/13/16.
//  Copyright © 2016 softserve. All rights reserved.
//

#import "DetailedCaseStudyView.h"
#import "CaseStudy.h"

@interface DetailedCaseStudyView ()

@property (strong, nonatomic) UIImageView *photoImageView;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *fullDescription;
@property (strong, nonatomic) UIButton *viewPageButton;
@property (assign, nonatomic) BOOL hasSetupConstraints;

@end

@implementation DetailedCaseStudyView

- (id)initWithCaseStudy:(CaseStudy *)caseStudy {
    
    self.hasSetupConstraints = NO;
    
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        [self addSubviewsFromCS:caseStudy];
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)addSubviewsFromCS:(CaseStudy *) caseStudy {
    self.photoImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.photoImageView.image = [UIImage imageWithData:caseStudy.image];
    self.photoImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.photoImageView];
    
    self.name = [[UILabel alloc] initWithFrame:CGRectZero];
    self.name.text = caseStudy.name;
    self.name.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.name];
    
    self.fullDescription = [[UILabel alloc] initWithFrame:CGRectZero];
    self.fullDescription.text = caseStudy.fullDesc;
    self.fullDescription.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.fullDescription];
    
    self.viewPageButton = [[UIButton alloc] initWithFrame:CGRectZero];
    self.viewPageButton.titleLabel.text = @"GO";
    self.viewPageButton.backgroundColor = [UIColor redColor];
    self.viewPageButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.viewPageButton];
    
}

- (void)updateConstraints {

    if (!self.hasSetupConstraints) {
        [self setupConstraints];
        self.hasSetupConstraints = YES;
    }
    [super updateConstraints];
    
}

- (void)setupConstraints {
    
    // photoImageView
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.photoImageView
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute 
                                                    multiplier:1.0 
                                                      constant:262]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.photoImageView
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1.0
                                                      constant:375]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.photoImageView
                                                     attribute:NSLayoutAttributeLeading
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeLeading
                                                    multiplier:1.0
                                                      constant:62]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.photoImageView
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1.0
                                                      constant:-32]];
    
    // nameLabel
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.name
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1.0
                                                      constant:43]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.name
                                                     attribute:NSLayoutAttributeLeading
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.photoImageView
                                                     attribute:NSLayoutAttributeTrailing
                                                    multiplier:1.0
                                                      constant:37]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.name
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1.0
                                                      constant:49]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.name
                                                     attribute:NSLayoutAttributeTrailing
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTrailing
                                                    multiplier:1.0
                                                      constant:0.0]];
    // descriptionLabel
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.fullDescription
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1.0
                                                      constant:152]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.fullDescription
                                                     attribute:NSLayoutAttributeLeading
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.photoImageView
                                                     attribute:NSLayoutAttributeTrailing
                                                    multiplier:1.0
                                                      constant:37]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.fullDescription
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.name
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1.0
                                                      constant:11]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.fullDescription
                                                     attribute:NSLayoutAttributeTrailing
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTrailing
                                                    multiplier:1.0
                                                      constant:0.0]];
    
    // viewPageButton
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.viewPageButton
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1.0
                                                      constant:115]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.viewPageButton
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1.0
                                                      constant:42]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.viewPageButton
                                                     attribute:NSLayoutAttributeLeading
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.photoImageView
                                                     attribute:NSLayoutAttributeTrailing
                                                    multiplier:1.0
                                                      constant:37]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.viewPageButton
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.fullDescription
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1.0
                                                      constant:28]];
}
@end
