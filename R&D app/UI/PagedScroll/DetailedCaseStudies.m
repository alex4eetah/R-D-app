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
    
   /* NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];

    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    for (int i=0; i<5; i++) {
        DetailedCaseStudyViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"DetailedCaseStudiesVC"];
        
        vc.imageViewToSEt.image = (pics[i])[@"img"];
        vc.view.frame = CGRectMake(self.scroll.frame.size.width * i, 0, self.scroll.frame.size.width, self.scroll.frame.size.height);
        
        
        
        
        [self.scroll addSubview:];
        [arr addObject:vc];
    }

    self.scroll.contentSize = CGSizeMake(self.scroll.frame.size.width * pics.count, self.scroll.frame.size.height);*/
    
    NSMutableArray *viewsArr = [[NSMutableArray alloc] init];
    
    DetailedCaseStudyView *viewToAdd = [[DetailedCaseStudyView alloc] init];
    viewToAdd.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scroll addSubview:viewToAdd];
    [viewsArr addObject:viewToAdd];
    
    DetailedCaseStudyView *viewToAdd1 = [[DetailedCaseStudyView alloc] init];
    viewToAdd1.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scroll addSubview:viewToAdd1];
    [viewsArr addObject:viewToAdd1];
    
    DetailedCaseStudyView *viewToAdd2 = [[DetailedCaseStudyView alloc] init];
    viewToAdd2.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scroll addSubview:viewToAdd2];
    [viewsArr addObject:viewToAdd2];
    
    [self.scroll addConstraint:[NSLayoutConstraint constraintWithItem:viewsArr.firstObject
                                                            attribute:NSLayoutAttributeWidth
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.scroll
                                                            attribute:NSLayoutAttributeWidth
                                                           multiplier:1.0
                                                             constant:0.0]];
    
    [self.scroll addConstraint:[NSLayoutConstraint constraintWithItem:viewsArr.firstObject
                                                            attribute:NSLayoutAttributeHeight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.scroll
                                                            attribute:NSLayoutAttributeWidth
                                                           multiplier:1.0
                                                             constant:0.0]];
    
    [self.scroll addConstraint:[NSLayoutConstraint constraintWithItem:viewsArr.firstObject
                                                            attribute:NSLayoutAttributeLeading
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.scroll
                                                            attribute:NSLayoutAttributeLeading
                                                           multiplier:1.0
                                                             constant:53]];
    
    [self.scroll addConstraint:[NSLayoutConstraint constraintWithItem:viewsArr.firstObject
                                                            attribute:NSLayoutAttributeTop
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.scroll
                                                            attribute:NSLayoutAttributeTop
                                                           multiplier:1.0
                                                             constant:32]];
    
    for (int i = 1; i < viewsArr.count; i ++) {
        [self.scroll addConstraint:[NSLayoutConstraint constraintWithItem:viewsArr[i]
                                                                attribute:NSLayoutAttributeWidth
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.scroll
                                                                attribute:NSLayoutAttributeWidth
                                                               multiplier:1.0
                                                                 constant:0.0]];
        
        [self.scroll addConstraint:[NSLayoutConstraint constraintWithItem:viewsArr[i]
                                                                attribute:NSLayoutAttributeHeight
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.scroll
                                                                attribute:NSLayoutAttributeWidth
                                                               multiplier:1.0
                                                                 constant:0.0]];
        
        [self.scroll addConstraint:[NSLayoutConstraint constraintWithItem:viewsArr[i]
                                                                attribute:NSLayoutAttributeLeading
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:viewsArr[i-1]
                                                                attribute:NSLayoutAttributeLeading
                                                               multiplier:1.0
                                                                 constant:53]];
        
        [self.scroll addConstraint:[NSLayoutConstraint constraintWithItem:viewsArr[i]
                                                                attribute:NSLayoutAttributeTop
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.scroll
                                                                attribute:NSLayoutAttributeTop
                                                               multiplier:1.0
                                                                 constant:32]];
    }
    
    
    
    
    
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
