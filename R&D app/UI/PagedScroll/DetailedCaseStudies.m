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
#import "UINavigationBar+Helper.h"
#import "PopoverViewController.h"

#import "RDServerManager.h"
#import "WebVIewController.h"

#import "FPPopoverController.h"

@interface DetailedCaseStudies () <UIScrollViewDelegate, UIPopoverPresentationControllerDelegate, PopoverDelegate, Rotatable, DetailedCaseStudyOwner>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property(strong, nonatomic) NSArray *caseStudies;
@property (strong, nonatomic) CoreDataManager *manager;
@property (strong, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIPageControl *pageIndicator;

@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *portraitIBConstraints;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *landscapeIBConstraints;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *LandscapeSeparators;

@property (assign, nonatomic) BOOL isInLandscape;
@property (strong, nonatomic) UiUtil *animator;
@property (strong, nonatomic) NSMutableArray *potraitConstraints;
@property (strong, nonatomic) NSMutableArray *landscapeConstraints;

@property (assign, nonatomic) BOOL scrollProgressFlag;

//@property(nonatomic,strong) UIPopoverController *morePopover;
@property (weak, nonatomic) IBOutlet UIView *changePasswordModal;
@property (weak, nonatomic) IBOutlet UIView *modalWaitForeground;
@property (weak, nonatomic) IBOutlet UITextField *currentPasswordField;
@property (weak, nonatomic) IBOutlet UITextField *passwordToSetField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordField;
@property (weak, nonatomic) IBOutlet UILabel *currentPassLabel;
@property (weak, nonatomic) IBOutlet UILabel *passToSetLabel;
@property (weak, nonatomic) IBOutlet UILabel *confirmPassLabel;

@property (strong, nonatomic) RDServerManager *serverManager;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@property (weak, nonatomic) FPPopoverController *popover;

//@property (strong, nonatomic) NSMutableDictionary *buttonTagsAndUrls;

@end

@implementation DetailedCaseStudies

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureSelf];
}

- (void)viewDidLayoutSubviews
{
    if (self.caseStudyToPresentName) {
        for (CaseStudy *s in self.caseStudies) {
            if (s.name == self.caseStudyToPresentName) {
                NSInteger i = [self.caseStudies indexOfObject:s];
                CGFloat x = i * self.scroll.frame.size.width;
                [self.scroll setContentOffset:CGPointMake(x, 0) animated:YES];
            }
        }
    }
    if (self.isInLandscape) {
        [self showLandscapeSeparators];
    } else {
        [self hideLandscapeSeparators];
    }
}

- (void)configureSelf
{
    self.serverManager = [RDServerManager sharedManager];
    
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
    
    //[self.manager updateCaseStudies];
    
    [self createScrollViewLayoutFromArray:self.caseStudies];
    
    self.scrollProgressFlag = YES;
    
    self.spinner.layer.zPosition = -1;
    
    [self configureBGImage];
    
    [self configureNavigationBar];
    
}

- (void)configureNavigationBar
{
    self.navigationController.navigationBar.topItem.title = @"Case Studies";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:16]}];
    
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationGradient"]
                                                  forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBottomBorderColor:[UIColor colorWithRed:17/255.0 green:163/255.0 blue:224/255.0 alpha:1] height:1];
    
    [self.animator addNavigationButtonForTarget:self
                                       Selector:@selector(back)
                                  ImageWithName:@"backNavButton"
                                           Size:CGSizeMake(20, 20)
                                           Left:YES];
    [self.animator addNavigationButtonForTarget:self
                                       Selector:@selector(back)
                                  ImageWithName:@"changeViewToGeneral"
                                           Size:CGSizeMake(20, 20)
                                           Left:NO];
    [self.animator addNavigationButtonForTarget:self
                                       Selector:@selector(more:)
                                  ImageWithName:@"moreNavBarIcon"
                                           Size:CGSizeMake(20, 20)
                                           Left:NO];
}

- (void)configureBGImage
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (self.isInLandscape) {
            self.backgroundImageView.image = [UIImage imageNamed:@"collectionViewBackgroundLandscape"];
        } else {
            self.backgroundImageView.image = [UIImage imageNamed:@"detailedCaseStudyBG"];
        }
    }
}

- (void)showLandscapeSeparators
{
    for (UIImageView *im in self.LandscapeSeparators) {
        [UIView transitionWithView:im
                          duration:0.4
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            im.hidden = NO;
                        }
                        completion:NULL];
    }
}

- (void)hideLandscapeSeparators
{
    for (UIImageView *im in self.LandscapeSeparators) {
        [UIView transitionWithView:im
                          duration:0.2
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            im.hidden = YES;
                            self.scrollProgressFlag = NO;
                        }
                        completion:NULL];
    }
}

- (void)createScrollViewLayoutFromArray:(NSArray *)arr
{
    if (!arr) {
        return;
    }
    
    NSMutableArray *viewsArr = [[NSMutableArray alloc] init];
    
    int tag = 1;
    
    for (CaseStudy *obj in arr) {
        
        DetailedCaseStudyView *viewToAdd = [[DetailedCaseStudyView alloc] initWithCaseStudy:obj Tag:tag];
        viewToAdd.owner = self;
        viewToAdd.translatesAutoresizingMaskIntoConstraints = NO;
        [self.scroll addSubview:viewToAdd];
        [viewsArr addObject:viewToAdd];
        tag++;
    }
    
    if (viewsArr.count) {
        [self addConstraintsForViewsArr:viewsArr];
        
        [self.scroll addConstraints:self.potraitConstraints];
        [self.scroll addConstraints:self.landscapeConstraints];
        
        [self.potraitConstraints addObjectsFromArray:self.portraitIBConstraints];
        [self.landscapeConstraints addObjectsFromArray:self.landscapeIBConstraints];
        
        [self.animator animateConstraintsChangingToOrientation: self.isInLandscape? Landscape: Portrait
                                             ForViewController:self];
    }
    
}

- (void)addConstraintsForViewsArr:(NSArray *)viewsArr
{
    /*
     *      Constraints:
     *               Portrait ---
     *           Landscape ---
     *               Portrait ---
     *           landscape ---
     */
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    
    
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
    }
    else {
        
        [self.potraitConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr.firstObject
                                                                        attribute:NSLayoutAttributeWidth
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:1.0
                                                                         constant:300]];
        
     /*   [self.landscapeConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr.firstObject
                                                                          attribute:NSLayoutAttributeWidth
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1.0
                                                                           constant:769]];*/
        
        [self.potraitConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr.firstObject
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:1.0
                                                                         constant:408]];
        
      /*  [self.landscapeConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr.firstObject
                                                                          attribute:NSLayoutAttributeHeight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1.0
                                                                           constant:370]];*/
        
        [self.potraitConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr.firstObject
                                                                        attribute:NSLayoutAttributeLeft
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.scroll
                                                                        attribute:NSLayoutAttributeLeft
                                                                       multiplier:1.0
                                                                         constant:(self.view.frame.size.width-300)/2]];
        
    /*    [self.landscapeConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr.firstObject
                                                                          attribute:NSLayoutAttributeLeft
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self.scroll
                                                                          attribute:NSLayoutAttributeLeft
                                                                         multiplier:1.0
                                                                           constant:127]];*/
        
        [self.potraitConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr.firstObject
                                                                        attribute:NSLayoutAttributeTop
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.scroll
                                                                        attribute:NSLayoutAttributeTop
                                                                       multiplier:1.0
                                                                         constant:0]];
        
        /*[self.landscapeConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr.firstObject
                                                                          attribute:NSLayoutAttributeTop
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self.scroll
                                                                          attribute:NSLayoutAttributeTop
                                                                         multiplier:1.0
                                                                           constant:0]];*/
        
        
        for (int i = 1; i < viewsArr.count - 1; i ++) {
            
            [self.potraitConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr[i]
                                                                            attribute:NSLayoutAttributeWidth
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:nil
                                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                                           multiplier:1.0
                                                                             constant:300]];
            
         /*   [self.landscapeConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr[i]
                                                                              attribute:NSLayoutAttributeWidth
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:nil
                                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                                             multiplier:1.0
                                                                               constant:769]];*/
            
            [self.potraitConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr[i]
                                                                            attribute:NSLayoutAttributeHeight
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:nil
                                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                                           multiplier:1.0
                                                                             constant:408]];
            
           /* [self.landscapeConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr[i]
                                                                              attribute:NSLayoutAttributeHeight
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:nil
                                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                                             multiplier:1.0
                                                                               constant:370]];*/
            
            
            [self.potraitConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr[i]
                                                                            attribute:NSLayoutAttributeTop
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self.scroll
                                                                            attribute:NSLayoutAttributeTop
                                                                           multiplier:1.0
                                                                             constant:0]];
            
          /*  [self.landscapeConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr[i]
                                                                              attribute:NSLayoutAttributeTop
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self.scroll
                                                                              attribute:NSLayoutAttributeTop
                                                                             multiplier:1.0
                                                                               constant:0]];*/
            
            [self.potraitConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr[i]
                                                                            attribute:NSLayoutAttributeLeft
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:viewsArr[i-1]
                                                                            attribute:NSLayoutAttributeRight
                                                                           multiplier:1.0
                                                                             constant:(self.view.frame.size.width-300)]];
            
            /*[self.landscapeConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr[i]
                                                                              attribute:NSLayoutAttributeLeft
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:viewsArr[i-1]
                                                                              attribute:NSLayoutAttributeRight
                                                                             multiplier:1.0
                                                                               constant:127*2]];*/
            
        }
        
        [self.potraitConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr.lastObject
                                                                        attribute:NSLayoutAttributeWidth
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:1.0
                                                                         constant:300]];
        
        /*[self.landscapeConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr.lastObject
                                                                          attribute:NSLayoutAttributeWidth
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1.0
                                                                           constant:769]];*/
        
        [self.potraitConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr.lastObject
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:1.0
                                                                         constant:408]];
        
       /* [self.landscapeConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr.lastObject
                                                                          attribute:NSLayoutAttributeHeight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1.0
                                                                           constant:370]];*/
        
        
        [self.potraitConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr.lastObject
                                                                        attribute:NSLayoutAttributeLeft
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:viewsArr[viewsArr.count-2]
                                                                        attribute:NSLayoutAttributeRight
                                                                       multiplier:1.0
                                                                         constant:(self.view.frame.size.width-300)]];
        
       /* [self.landscapeConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr.lastObject
                                                                          attribute:NSLayoutAttributeLeft
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:viewsArr[viewsArr.count-2]
                                                                          attribute:NSLayoutAttributeRight
                                                                         multiplier:1.0
                                                                           constant:127*2]];*/
        
        [self.potraitConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr.lastObject
                                                                        attribute:NSLayoutAttributeRight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.scroll
                                                                        attribute:NSLayoutAttributeRight
                                                                       multiplier:1.0
                                                                         constant:-((self.view.frame.size.width-300)/2)]];
        
      /*  [self.landscapeConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr.lastObject
                                                                          attribute:NSLayoutAttributeRight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self.scroll
                                                                          attribute:NSLayoutAttributeRight
                                                                         multiplier:1.0
                                                                           constant:-127]];*/
        
        [self.potraitConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr.lastObject
                                                                        attribute:NSLayoutAttributeTop
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.scroll
                                                                        attribute:NSLayoutAttributeTop
                                                                       multiplier:1.0
                                                                         constant:0]];
        
       /* [self.landscapeConstraints addObject:[NSLayoutConstraint constraintWithItem:viewsArr.lastObject
                                                                          attribute:NSLayoutAttributeTop
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self.scroll
                                                                          attribute:NSLayoutAttributeTop
                                                                         multiplier:1.0
                                                                           constant:0]];*/
    }
}

#pragma mark - navigation buttons action

- (void)more:(UIButton *)sender
{
    /*UIStoryboard *storyboard = self.storyboard;
     PopoverViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"popoverVC"];
     UIPopoverController* aPopover = [[UIPopoverController alloc]
     initWithContentViewController:vc];
     aPopover.delegate = self;
     
     aPopover.popoverContentSize = CGSizeMake(213, 104);
     vc.delegate = self;
     self.morePopover = aPopover;
     
     [self.morePopover presentPopoverFromRect:CGRectMake(self.view.frame.size.width-30, 0, 20, 60)  inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];*/
    
    UIStoryboard *storyboard = self.storyboard;
    PopoverViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"popoverVC"];
    vc.delegate = self;
    FPPopoverController *popover = [[FPPopoverController alloc] initWithViewController:vc];
    popover.title = nil;
    popover.border = NO;
    popover.tint = FPPopoverWhiteTint;
    popover.arrowDirection = FPPopoverArrowDirectionUp;
    popover.contentSize = CGSizeMake(240, 135);
    self.popover = popover;
    
    [popover presentPopoverFromView:sender];
}

- (void)back
{
    [self.scroll.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.scroll removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ScrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.scrollProgressFlag && self.isInLandscape) {
        [self hideLandscapeSeparators];
    }
    
    static NSInteger previousPage = 0;
    CGFloat pageWidth = scrollView.frame.size.width;
    float fractionalPage = scrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    if (previousPage != page) {
        self.pageIndicator.currentPage = page;
        previousPage = page;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.isInLandscape) {
        [self showLandscapeSeparators];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.isInLandscape) {
        self.scrollProgressFlag = YES;  
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
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
            
            Orientation orient = self.isInLandscape? Landscape: Portrait;
            
            [self.animator animateConstraintsChangingToOrientation: orient
                                                 ForViewController:self];
            [self configureBGImage];
            
            if (self.isInLandscape) {
                [self showLandscapeSeparators];
            }
            else {
                [self hideLandscapeSeparators];
            }
            
        } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
            CGFloat x = self.pageIndicator.currentPage * self.scroll.frame.size.width;
            [self.scroll setContentOffset:CGPointMake(x, 0) animated:YES];
        }];
    }
}
//
//#pragma mark - popover
//- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
//    
//    return UIModalPresentationNone;
//}

#pragma mark - popover deledate
- (void)dismissToRoot
{
    UIViewController *vc = self;
    while (vc.presentingViewController) {
        vc = vc.presentingViewController;
    }
    [vc dismissViewControllerAnimated:YES completion:nil];

}

- (void)showChangePasswordModal
{
    [UIView transitionWithView:self.changePasswordModal
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [self.popover dismissPopoverAnimated:YES];
                        self.changePasswordModal.hidden = NO;
                        self.navigationController.navigationBar.layer.zPosition = -1;
                    }
                    completion:NULL];
}

#pragma mark password changing delegate
- (IBAction)changePassword:(id)sender
{
    NSString *oldPass = self.currentPasswordField.text;
    NSString *newPass = self.passwordToSetField.text;
    NSString *confirmPass = self.confirmPasswordField.text;
    
    CALayer *currentPassAnimatable = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)? self.currentPassLabel.layer: self.currentPasswordField.layer;
    CALayer *newPassAnimatable = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)? self.passToSetLabel.layer: self.passwordToSetField.layer;
    CALayer *confirmPassAnimatable = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)? self.confirmPassLabel.layer: self.confirmPasswordField.layer;
    
    if ([oldPass isEqualToString: @""] || [oldPass isEqualToString:@" "]) {
        
        [self.animator animateWrongInputOnLayer:currentPassAnimatable];
        
    } else if ([newPass isEqualToString: @""] || [newPass isEqualToString:@" "]) {
        
        [self.animator animateWrongInputOnLayer:newPassAnimatable];
        
    } else if ([confirmPass isEqualToString: @""] || [confirmPass isEqualToString:@" "] || ![confirmPass isEqualToString:newPass]) {
        
        [self.animator animateWrongInputOnLayer:confirmPassAnimatable];
        
    } else {
        self.modalWaitForeground.hidden = NO;
        self.spinner.layer.zPosition = 20;
        
        [self.spinner startAnimating];
        [self.serverManager changePasswordWithCredentials:@{@"oldPass":oldPass,@"newPass":newPass} Completion:^(BOOL done) {
            self.modalWaitForeground.hidden = YES;
            [self.spinner stopAnimating];
            self.spinner.layer.zPosition = -1;
            
            if (done == YES) {
                [UIView transitionWithView:self.changePasswordModal
                                  duration:0.4
                                   options:UIViewAnimationOptionTransitionCrossDissolve
                                animations:^{
                                    self.changePasswordModal.hidden = YES;
                                    self.navigationController.navigationBar.layer.zPosition = 0;
                                }
                                completion:NULL];
            } else {
                [self.animator animateWrongInputOnLayer:self.currentPasswordField.layer];
            }
        }];
    }
}

- (IBAction)dismissChangePasswordModal:(id)sender
{
    [UIView transitionWithView:self.changePasswordModal
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        self.changePasswordModal.hidden = YES;
                        self.navigationController.navigationBar.layer.zPosition = 0;
                    }
                    completion:NULL];
}

#pragma mark - DetailedCaseStudyOwnerDelegate

- (void)showWebContentForUrl:(UIButton *) sender
{
    CaseStudy *chosenItem = self.caseStudies[sender.tag-1];
    [self.manager updateCaseStudyWithName:chosenItem.name Force:YES];
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    WebVIewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"webVC"];
    vc.url = chosenItem.link;
    vc.cache = chosenItem.cache;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)next
{
    NSInteger toGo = self.pageIndicator.currentPage + 1;
    if (self.pageIndicator.numberOfPages > toGo) {
        CGFloat x = toGo * self.scroll.frame.size.width;
        [self.scroll setContentOffset:CGPointMake(x, 0) animated:YES];
    }
}

- (void)prev
{
    NSInteger toGo = self.pageIndicator.currentPage - 1;
    if (toGo > 0) {
        CGFloat x = toGo * self.scroll.frame.size.width;
        [self.scroll setContentOffset:CGPointMake(x, 0) animated:YES];
    }
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
