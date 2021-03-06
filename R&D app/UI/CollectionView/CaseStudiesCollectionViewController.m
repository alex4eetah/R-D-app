//
//  CaseStudiesCollectionViewController.m
//  R&D app
//
//  Created by AlexCheetah on 8/10/16.
//  Copyright © 2016 softserve. All rights reserved.
//

#import "CaseStudiesCollectionViewController.h"
#import "CaseStudiesCell.h"
#import "UINavigationBar+Helper.h"
#import "CoreDataManager.h"
#import "CaseStudy.h"
#import "UiUtil.h"
#import "PopoverViewController.h"

#import "FPPopoverController.h"

@interface CaseStudiesCollectionViewController()<PopoverDelegate>


@property (strong, nonatomic) CoreDataManager *manager;
@property(strong, nonatomic) NSArray *caseStudies;
@property (weak, nonatomic) IBOutlet UIImageView *backGroundImageView;
@property(assign, nonatomic) BOOL isInLandscape;
@property (strong, nonatomic) UiUtil *animator;
@property (weak, nonatomic) FPPopoverController *popover;

@end

@implementation CaseStudiesCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.manager = [CoreDataManager sharedManager];
    
    //TEST DATA
    [self.manager fakeFromArray:[NSArray arrayWithObjects:
                                 @{
                                   @"name":@"BioLock",
                                   @"image":[UIImage imageNamed:@"SmartIdentityVerifImage.png"],
                                   @"shortDesc":@"Smart Identity Verification",
                                   @"fullDesc":@"A smart system by SoftServe for continuous authentication and monitoring of human well-being, based on electrocardiogram (ECG) analysis with biosensors embedded into a vehicle’s steering wheel and a mobile application working in offline mode",
                                   @"link":@"https://readymag.com/u34879872/560620/"},
                                 @{
                                   @"name":@"Barista",
                                   @"image":[UIImage imageNamed:@"BaristaImage.png"],
                                   @"shortDesc":@"Smart Coffee Machine",
                                   @"fullDesc":@"SoftServe Barista is a system for combining personal health and fully automated coffee preparation",
                                   @"link":@"http://demo.softserveinc.com/barista/"}, nil]];
    
    [self configureSelf];
    
    [self configureBGImage];
    
    [self configureNavigationBar];

}

- (void)configureSelf
{
    self.caseStudies = [self.manager getArrayOfCaseStudies];
    
    self.isInLandscape = (self.view.frame.size.width > self.view.frame.size.height);
    
    self.animator = [UiUtil sharedUtil];
}

- (void)configureBGImage
{
    if (self.isInLandscape) {
        self.backGroundImageView.image = [UIImage imageNamed:@"collectionViewBackgroundLandscape"];
    } else {
        self.backGroundImageView.image = [UIImage imageNamed:@"collectionViewBackground"];
    }
}

- (void)configureNavigationBar
{
    self.navigationController.navigationBar.topItem.title = @"Case Studies";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:16]}];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationGradient"]
                                                  forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBottomBorderColor:[UIColor colorWithRed:17/255.0 green:163/255.0 blue:224/255.0 alpha:1] height:1];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    [self.animator addNavigationButtonForTarget:self
                              Selector:@selector(search)
                         ImageWithName:@"searchNavBarIcon"
                                  Size:CGSizeMake(20, 20)
                                  Left:YES];
    [self.animator addNavigationButtonForTarget:self
                              Selector:@selector(changeView)
                         ImageWithName:@"changeVIewNavBarIcon"
                                  Size:CGSizeMake(28, 20)
                                  Left:NO];
    [self.animator addNavigationButtonForTarget:self
                                       Selector:@selector(more:)
                         ImageWithName:@"moreNavBarIcon"
                                  Size:CGSizeMake(20, 20)
                                  Left:NO];
}

#pragma mark - actions

- (void)search
{
    
}

-(void)more:(UIButton *) sender
{
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

-(void)changeView
{
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"PagedScrollCaseStudies"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - CollectionView

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.caseStudies.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CaseStudiesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CaseStudyCell"
                                                                      forIndexPath:indexPath];
    CaseStudy *object = (CaseStudy *)self.caseStudies[indexPath.row];
    cell.image.image = [UIImage imageWithData:object.image];
    cell.name.text = object.name;
    cell.shortDescription.text = object.shortDesc;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (self.isInLandscape)
        {
            return CGSizeMake(282.f, 322.f);
        }
        return CGSizeMake(277.f, 277.f);
    } else {
        if (self.isInLandscape)
        {
            return CGSizeMake(282.f, 256.f);
        }
        return CGSizeMake(282.f, 256.f);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (self.isInLandscape)
            return UIEdgeInsetsMake(92, 40, 0, 40);
        else
            return UIEdgeInsetsMake(98, 72, 0, 72);
    } else {
        if (self.isInLandscape)
            return UIEdgeInsetsMake(52, 47, 0, 46);
        else
            return UIEdgeInsetsMake(52, 47, 0, 46);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionView *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (!self.isInLandscape)
            return 98;
        else
            return 98;
    } else {
        if (!self.isInLandscape)
            return 52;
        else
            return 52;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *view;
    
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer" forIndexPath:indexPath];
    }

    return view;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
        return CGSizeMake(self.view.frame.size.width, 65);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CaseStudy *object = (CaseStudy *)self.caseStudies[indexPath.row];
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"PagedScrollCaseStudies"];
    
    [vc setValue:object.name forKey:@"caseStudyToPresentName"];
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - rotation

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        self.isInLandscape = (size.width > size.height);
        
        [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
            
            [self configureBGImage];
            
            UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
            
            [flowLayout invalidateLayout];
            
        } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
            
            [self.navigationController.navigationBar setBottomBorderColor:[UIColor colorWithRed:17/255.0 green:163/255.0 blue:224/255.0 alpha:1] height:1];
            
        }];
    }
}

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
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController<PopoverDelegate> *vc = [storyboard instantiateViewControllerWithIdentifier:@"PagedScrollCaseStudies"];
    [self.navigationController pushViewController:vc animated:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popover dismissPopoverAnimated:YES];
        [vc showChangePasswordModal];
        
    });
}


@end
