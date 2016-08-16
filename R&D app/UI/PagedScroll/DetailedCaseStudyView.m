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

@property (strong, nonatomic) UIView *border;
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
        [self addSubviewsFromCS:caseStudy];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)addSubviewsFromCS:(CaseStudy *) caseStudy {
    self.backgroundColor = [UIColor colorWithRed:46/255.0 green:75/255.0 blue:217/255.0 alpha:1];
    self.border = [[UIView alloc] initWithFrame:CGRectZero];
    self.border.translatesAutoresizingMaskIntoConstraints = NO;
    self.border.backgroundColor = [UIColor colorWithRed:23/255.0 green:52/255.0 blue:193/255.0 alpha:1];
    [self addSubview:self.border];
    
    self.photoImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.photoImageView.image = [UIImage imageWithData:caseStudy.image];
    self.photoImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.photoImageView];
    
    self.name = [[UILabel alloc] initWithFrame:CGRectZero];
    self.name.text = caseStudy.name;
    [self.name setFont:[UIFont fontWithName:@"RobotoSlab-Bold" size:32]];
    [self.name setTextColor:[UIColor whiteColor]];
    self.name.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.name];
    
    self.fullDescription = [[UILabel alloc] initWithFrame:CGRectZero];
    self.fullDescription.text = caseStudy.fullDesc;
    [self.fullDescription setFont:[UIFont fontWithName:@"OpenSans-Regular" size:14]];
    [self.fullDescription setTextColor:[UIColor whiteColor]];
    self.fullDescription.lineBreakMode = NSLineBreakByWordWrapping;
    self.fullDescription.numberOfLines = 0;
    self.fullDescription.textAlignment = NSTextAlignmentLeft;
//    [self.fullDescription setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
//    [self.fullDescription setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.fullDescription sizeToFit];
    self.fullDescription.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.fullDescription];
    
    self.viewPageButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.viewPageButton setTitle:@"View" forState:UIControlStateNormal];
    [self.viewPageButton.titleLabel setFont:[UIFont fontWithName:@"MuseoSansCyrl-700" size:16]];
    [self.viewPageButton.titleLabel setTextColor:[UIColor whiteColor]];
    self.viewPageButton.layer.cornerRadius = 3;
    
    self.viewPageButton.backgroundColor = [UIColor colorWithRed:248/255.0 green:84/255.0 blue:81/255.0 alpha:1];
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
    
    // border
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.border
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1.0
                                                      constant:656]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.border
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1.0
                                                      constant:388]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.border
                                                     attribute:NSLayoutAttributeLeading
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeLeading
                                                    multiplier:1.0
                                                      constant:2]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.border
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1.0
                                                      constant:2]];
    
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
                                                     attribute:NSLayoutAttributeBottom
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
