//
//  DetailedCaseStudies.m
//  R&D app
//
//  Created by Oleksandr Chechetkin on 8/12/16.
//  Copyright © 2016 softserve. All rights reserved.
//

#import "DetailedCaseStudies.h"
#import "DetailedCaseStudyView.h"
#import "CoreDataManager.h"
#import "CaseStudy.h"
#import "UiUtil.h"

@interface DetailedCaseStudies () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property(strong, nonatomic) NSArray *caseStudies;
@property (strong, nonatomic) CoreDataManager *manager;
@property (strong, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIPageControl *pageIndicator;

@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *portraitIBConstraints;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *landscapeIBConstraints;

@property (assign, nonatomic) BOOL isInLandscape;
@property (strong, nonatomic) UiUtil *animator;
@property (strong, nonatomic) NSMutableArray *potraitConstraints;
@property (strong, nonatomic) NSMutableArray *landscapeConstraints;

@end

@implementation DetailedCaseStudies

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureSelf];
    
    [self configureBGImage];
}

- (void)configureSelf
{
    self.manager = [CoreDataManager sharedManager];
    self.caseStudies = [self.manager getArrayOfCaseStudies];
    
    self.scroll.delegate = self;
    self.scroll.scrollEnabled = YES;
    
    self.scroll.pagingEnabled = YES;
    self.pageIndicator.numberOfPages = self.caseStudies.count;
    [self.pageIndicator addTarget:self action:@selector(PageControllDidChangePage:) forControlEvents:UIControlEventValueChanged];
    
    self.potraitConstraints = [[NSMutableArray alloc] init];
    self.landscapeConstraints = [[NSMutableArray alloc] init];
    
    self.animator = [UiUtil sharedUtil];
    self.isInLandscape = (self.view.frame.size.width > self.view.frame.size.height);
    
    [self createScrollViewLayoutFromArray:self.caseStudies];
}

- (void)createScrollViewLayoutFromArray:(NSArray *)arr
{
    if (!arr) {
        return;
    }
    
    NSMutableArray *viewsArr = [[NSMutableArray alloc] init];
    
    for (CaseStudy *obj in arr) {
        DetailedCaseStudyView *viewToAdd = [[DetailedCaseStudyView alloc] initWithCaseStudy:obj];
        viewToAdd.translatesAutoresizingMaskIntoConstraints = NO;
        [self.scroll addSubview:viewToAdd];
        [viewsArr addObject:viewToAdd];
    }
    
/*
 *      Constraints:
 *               Portrait ---
 *           Landscape ---
 *               Portrait ---
 *           landscape ---
 */
    [self.potraitConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr.firstObject
                                                            attribute:NSLayoutAttributeWidth
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:nil
                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                           multiplier:1.0
                                                             constant:660]];
    
    [self.landscapeConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr.firstObject
                                                                    attribute:NSLayoutAttributeWidth
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:nil
                                                                    attribute:NSLayoutAttributeNotAnAttribute
                                                                   multiplier:1.0
                                                                     constant:769]];
    
    [self.potraitConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr.firstObject
                                                            attribute:NSLayoutAttributeHeight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:nil
                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                           multiplier:1.0
                                                             constant:392]];
    
    [self.landscapeConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr.firstObject
                                                                    attribute:NSLayoutAttributeHeight
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:nil
                                                                    attribute:NSLayoutAttributeNotAnAttribute
                                                                   multiplier:1.0
                                                                     constant:370]];
    
    [self.potraitConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr.firstObject
                                                            attribute:NSLayoutAttributeLeft
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.scroll
                                                            attribute:NSLayoutAttributeLeft
                                                           multiplier:1.0
                                                             constant:53]];
    
    [self.landscapeConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr.firstObject
                                                                    attribute:NSLayoutAttributeLeft
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.scroll
                                                                    attribute:NSLayoutAttributeLeft
                                                                   multiplier:1.0
                                                                     constant:127]];
    
    [self.potraitConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr.firstObject
                                                            attribute:NSLayoutAttributeTop
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.scroll
                                                            attribute:NSLayoutAttributeTop
                                                           multiplier:1.0
                                                             constant:0]];
    
    [self.landscapeConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr.firstObject
                                                                    attribute:NSLayoutAttributeTop
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.scroll
                                                                    attribute:NSLayoutAttributeTop
                                                                   multiplier:1.0
                                                                     constant:0]];
    
    
    for (int i = 1; i < viewsArr.count - 1; i ++) {
        
        [self.potraitConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr[i]
                                                                attribute:NSLayoutAttributeWidth
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:nil
                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                               multiplier:1.0
                                                                 constant:660]];
        
        [self.landscapeConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr[i]
                                                                          attribute:NSLayoutAttributeWidth
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1.0
                                                                           constant:769]];
        
        [self.potraitConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr[i]
                                                                attribute:NSLayoutAttributeHeight
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:nil
                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                               multiplier:1.0
                                                                 constant:392]];
        
        [self.landscapeConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr[i]
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:1.0
                                                                         constant:370]];
        
        
        [self.potraitConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr[i]
                                                                attribute:NSLayoutAttributeTop
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.scroll
                                                                attribute:NSLayoutAttributeTop
                                                               multiplier:1.0
                                                                 constant:0]];
        
        [self.landscapeConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr[i]
                                                                        attribute:NSLayoutAttributeTop
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.scroll
                                                                        attribute:NSLayoutAttributeTop
                                                                       multiplier:1.0
                                                                         constant:0]];
        
        [self.potraitConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr[i]
                                                                attribute:NSLayoutAttributeLeft
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:viewsArr[i-1]
                                                                attribute:NSLayoutAttributeRight
                                                               multiplier:1.0
                                                                 constant:106]];
        
        [self.landscapeConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr[i]
                                                                        attribute:NSLayoutAttributeLeft
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:viewsArr[i-1]
                                                                        attribute:NSLayoutAttributeRight
                                                                       multiplier:1.0
                                                                         constant:127*2]];
        
    }
    
    [self.potraitConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr.lastObject
                                                            attribute:NSLayoutAttributeWidth
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:nil
                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                           multiplier:1.0
                                                             constant:660]];
    
    [self.landscapeConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr.lastObject
                                                                    attribute:NSLayoutAttributeWidth
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:nil
                                                                    attribute:NSLayoutAttributeNotAnAttribute
                                                                   multiplier:1.0
                                                                     constant:769]];
    
    [self.potraitConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr.lastObject
                                                            attribute:NSLayoutAttributeHeight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:nil
                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                           multiplier:1.0
                                                             constant:392]];
    
    [self.landscapeConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr.lastObject
                                                                    attribute:NSLayoutAttributeHeight
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:nil
                                                                    attribute:NSLayoutAttributeNotAnAttribute
                                                                   multiplier:1.0
                                                                     constant:370]];
    
    
    [self.potraitConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr.lastObject
                                                            attribute:NSLayoutAttributeLeft
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:viewsArr[viewsArr.count-2]
                                                            attribute:NSLayoutAttributeRight
                                                           multiplier:1.0
                                                             constant:106]];
    
    [self.landscapeConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr.lastObject
                                                                    attribute:NSLayoutAttributeLeft
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:viewsArr[viewsArr.count-2]
                                                                    attribute:NSLayoutAttributeRight
                                                                   multiplier:1.0
                                                                     constant:127*2]];
    
    [self.potraitConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr.lastObject
                                                            attribute:NSLayoutAttributeRight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.scroll
                                                            attribute:NSLayoutAttributeRight
                                                           multiplier:1.0
                                                             constant:-53]];
    
    [self.landscapeConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr.lastObject
                                                                    attribute:NSLayoutAttributeRight
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.scroll
                                                                    attribute:NSLayoutAttributeRight
                                                                   multiplier:1.0
                                                                     constant:-127]];
    
    [self.potraitConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr.lastObject
                                                            attribute:NSLayoutAttributeTop
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.scroll
                                                            attribute:NSLayoutAttributeTop
                                                           multiplier:1.0
                                                             constant:0]];
    
    [self.landscapeConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr.lastObject
                                                                    attribute:NSLayoutAttributeTop
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.scroll
                                                                    attribute:NSLayoutAttributeTop
                                                                   multiplier:1.0
                                                                     constant:0]];
    
    [self.scroll addConstraints:self.potraitConstraints];
    [self.scroll addConstraints:self.landscapeConstraints];
    
    [self.potraitConstraints addObjectsFromArray:self.portraitIBConstraints];
    [self.landscapeConstraints addObjectsFromArray:self.landscapeIBConstraints];
    
    [self.animator animateConstraintsChangingToOrientation: self.isInLandscape? Landscape: Portrait
                                         ForViewController:self];
    
}

- (void)configureBGImage
{
    if (self.isInLandscape) {
        self.backgroundImageView.image = [UIImage imageNamed:@"collectionViewBackgroundLandscape"];
    } else {
        self.backgroundImageView.image = [UIImage imageNamed:@"detailedCaseStudyBG"];
    }
}

#pragma mark - ScrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    static NSInteger previousPage = 0;
    CGFloat pageWidth = scrollView.frame.size.width;
    float fractionalPage = scrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    if (previousPage != page) {
        self.pageIndicator.currentPage = page;
        previousPage = page;
    }
}

- (void)PageControllDidChangePage:(UIPageControl *)sender {
    CGFloat x = sender.currentPage * self.scroll.frame.size.width;
    [self.scroll setContentOffset:CGPointMake(x, 0) animated:YES];
}

#pragma mark - Ipad rotating

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    self.isInLandscape = (size.width > size.height);
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
        [self.animator animateConstraintsChangingToOrientation: self.isInLandscape? Landscape: Portrait
                                             ForViewController:self];
        [self configureBGImage];
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
    }];
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
