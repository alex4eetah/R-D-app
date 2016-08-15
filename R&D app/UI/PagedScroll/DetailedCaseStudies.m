//
//  DetailedCaseStudies.m
//  R&D app
//
//  Created by Oleksandr Chechetkin on 8/12/16.
//  Copyright © 2016 softserve. All rights reserved.
//

#import "DetailedCaseStudies.h"
#import "DetailedCaseStudyView.h"

@interface DetailedCaseStudies () <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scroll;
@property (strong, nonatomic) UIView *containerView;

@end

@implementation DetailedCaseStudies

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *pics = [NSArray arrayWithObjects:
                 @{
                   @"name":@"BioLock",
                   @"img":[UIImage imageNamed:@"group7.png"],
                   @"desc":@"Smart Identity Verification"},
                 @{
                   @"name":@"Barista",
                   @"img":[UIImage imageNamed:@"2016072852631.png"],
                   @"desc":@"Smart Coffee Machine"},
                 @{
                   @"name":@"Alexa",
                   @"img":[UIImage imageNamed:@"2016072854009.png"],
                   @"desc":@"VoiceMyBot"},
                 @{
                   @"name":@"Batista",
                   @"img":[UIImage imageNamed:@"2016072852631.png"],
                   @"desc":@"Smart Coffee Machine"},
                 @{
                   @"name":@"AlexaAAA",
                   @"img":[UIImage imageNamed:@"2016072854009.png"],
                   @"desc":@"VoiceMyBot"}, nil];
    
    
    self.scroll.delegate = self;
    self.scroll.scrollEnabled = YES;
    
    self.containerView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    NSMutableArray *viewsArr = [[NSMutableArray alloc] init];
    
    DetailedCaseStudyView *viewToAdd = [[DetailedCaseStudyView alloc] initWithFrame:CGRectZero];
    viewToAdd.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scroll addSubview:viewToAdd];
    [viewsArr addObject:viewToAdd];
    
    DetailedCaseStudyView *viewToAdd1 = [[DetailedCaseStudyView alloc] initWithFrame:CGRectZero];
    viewToAdd1.backgroundColor = [UIColor blackColor];
    viewToAdd1.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scroll addSubview:viewToAdd1];
    [viewsArr addObject:viewToAdd1];
    
    DetailedCaseStudyView *viewToAdd2 = [[DetailedCaseStudyView alloc] initWithFrame:CGRectZero];
    viewToAdd2.backgroundColor = [UIColor redColor];
    viewToAdd2.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scroll addSubview:viewToAdd2];
    [viewsArr addObject:viewToAdd2];
    
    [self.scroll addConstraint:[NSLayoutConstraint constraintWithItem:viewsArr.firstObject
                                                            attribute:NSLayoutAttributeWidth
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:nil
                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                           multiplier:1.0
                                                             constant:660]];
    
    [self.scroll addConstraint:[NSLayoutConstraint constraintWithItem:viewsArr.firstObject
                                                            attribute:NSLayoutAttributeHeight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:nil
                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                           multiplier:1.0
                                                             constant:392]];
    
    [self.scroll addConstraint:[NSLayoutConstraint constraintWithItem:viewsArr.firstObject
                                                            attribute:NSLayoutAttributeLeft
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.scroll
                                                            attribute:NSLayoutAttributeLeft
                                                           multiplier:1.0
                                                             constant:53]];
    
    [self.scroll addConstraint:[NSLayoutConstraint constraintWithItem:viewsArr.firstObject
                                                            attribute:NSLayoutAttributeTop
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.scroll
                                                            attribute:NSLayoutAttributeTop
                                                           multiplier:1.0
                                                             constant:0]];
    
    
    for (int i = 1; i < viewsArr.count - 1; i ++) {
        [self.scroll addConstraint:[NSLayoutConstraint constraintWithItem:viewsArr[i]
                                                                attribute:NSLayoutAttributeWidth
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:nil
                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                               multiplier:1.0
                                                                 constant:660]];
        
        [self.scroll addConstraint:[NSLayoutConstraint constraintWithItem:viewsArr[i]
                                                                attribute:NSLayoutAttributeHeight
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:nil
                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                               multiplier:1.0
                                                                 constant:392]];
        
        [self.scroll addConstraint:[NSLayoutConstraint constraintWithItem:viewsArr[i]
                                                                attribute:NSLayoutAttributeTop
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.scroll
                                                                attribute:NSLayoutAttributeTop
                                                               multiplier:1.0
                                                                 constant:0]];
        
        [self.scroll addConstraint:[NSLayoutConstraint constraintWithItem:viewsArr[i]
                                                                attribute:NSLayoutAttributeLeft
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:viewsArr[i-1]
                                                                attribute:NSLayoutAttributeRight
                                                               multiplier:1.0
                                                                 constant:106]];
        
    }
    
    [self.scroll addConstraint:[NSLayoutConstraint constraintWithItem:viewsArr.lastObject
                                                            attribute:NSLayoutAttributeWidth
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:nil
                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                           multiplier:1.0
                                                             constant:660]];
    
    [self.scroll addConstraint:[NSLayoutConstraint constraintWithItem:viewsArr.lastObject
                                                            attribute:NSLayoutAttributeHeight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:nil
                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                           multiplier:1.0
                                                             constant:392]];
    
    
    [self.scroll addConstraint:[NSLayoutConstraint constraintWithItem:viewsArr.lastObject
                                                            attribute:NSLayoutAttributeLeft
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:viewsArr[viewsArr.count-2]
                                                            attribute:NSLayoutAttributeRight
                                                           multiplier:1.0
                                                             constant:106]];
    
    [self.scroll addConstraint:[NSLayoutConstraint constraintWithItem:viewsArr.lastObject
                                                            attribute:NSLayoutAttributeRight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.scroll
                                                            attribute:NSLayoutAttributeRight
                                                           multiplier:1.0
                                                             constant:53]];
    
    [self.scroll addConstraint:[NSLayoutConstraint constraintWithItem:viewsArr.lastObject
                                                            attribute:NSLayoutAttributeTop
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.scroll
                                                            attribute:NSLayoutAttributeTop
                                                           multiplier:1.0
                                                             constant:0]];
    
    
    
    //self.scroll.contentSize = CGSizeMake(self.scroll.frame.size.width * 3, self.scroll.frame.size.height);
    
}

-(void)viewDidLayoutSubviews
{
    self.scroll.contentSize = CGSizeMake(self.scroll.frame.size.width * 3, self.scroll.frame.size.height);
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
