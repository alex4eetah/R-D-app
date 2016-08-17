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

@interface CaseStudiesCollectionViewController()

@property (strong, nonatomic) CoreDataManager *manager;
@property(strong, nonatomic) NSArray *caseStudies;
@property (weak, nonatomic) IBOutlet UIImageView *backGroundImageView;
@property(assign, nonatomic) BOOL isInLandscape;
@property (strong, nonatomic) UiUtil *animator;

@end

@implementation CaseStudiesCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureSelf];
    
    [self configureBGImage];
    
    [self configureNavigationBar];
    
    //TEST DATA
   /* [self.manager fakeFromArray:[NSArray arrayWithObjects:
                                 @{
                                   @"name":@"BioLock",
                                   @"image":[UIImage imageNamed:@"SmartIdentityVerifImage.png"],
                                   @"shortDesc":@"Smart Identity Verification",
                                   @"fullDesc":@"Smart Identity VerificationSmart Identity VerificationSmart Identity VerificationSmart Identity VerificationSmart Identity VerificationSmart Identity VerificationSmart Identity Verification",
                                   @"link":@"google.com"},
                                 @{
                                   @"name":@"Barista",
                                   @"image":[UIImage imageNamed:@"BaristaImage.png"],
                                   @"shortDesc":@"Smart Coffee Machine",
                                   @"fullDesc":@"Smart Coffee MachineSmart Coffee MachineSmart Coffee MachineSmart Coffee MachineSmart Coffee MachineSmart Coffee MachineSmart Coffee MachineSmart Coffee Machine",
                                   @"link":@"google.com"},
                                 @{
                                   @"name":@"Alexa",
                                   @"image":[UIImage imageNamed:@"VoiceMyBotImage.png"],
                                   @"shortDesc":@"VoiceMyBot",
                                   @"fullDesc":@"SVoiceMyBotVoiceMyBotVoiceMyBotVoiceMyBotVoiceMyBot",
                                   @"link":@"google.com"},
                                 @{
                                   @"name":@"SecondAlexa",
                                   @"image":[UIImage imageNamed:@"VoiceMyBotImage.png"],
                                   @"shortDesc":@"VoiceSecond",
                                   @"fullDesc":@"SecondMyBotVoiceMyBotVoiceMyBotSecondSecondSecondSecondSecondSecondSecondSecondSecondSecond",
                                   @"link":@"google.com"},
                                 @{
                                   @"name":@"BaristaTwo",
                                   @"image":[UIImage imageNamed:@"BaristaImage.png"],
                                   @"shortDesc":@"Smart Coffee Machine",
                                   @"fullDesc":@"Smart Coffee MachineSmart Coffee MachineSmart Coffee MachineSmart Coffee MachineSmart Coffee MachineSmart Coffee MachineSmart Coffee MachineSmart Coffee Machine",
                                   @"link":@"google.com"},
                                 @{
                                   @"name":@"BioLockTwo",
                                   @"image":[UIImage imageNamed:@"SmartIdentityVerifImage.png"],
                                   @"shortDesc":@"Smart Identity Verification",
                                   @"fullDesc":@"Smart Identity VerificationSmart Identity VerificationSmart Identity VerificationSmart Identity VerificationSmart Identity VerificationSmart Identity VerificationSmart Identity Verification",
                                   @"link":@"google.com"}, nil]];
    
 */
    
}

- (void)configureSelf
{
    self.manager = [CoreDataManager sharedManager];
    
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
                              Selector:@selector(more)
                         ImageWithName:@"moreNavBarIcon"
                                  Size:CGSizeMake(20, 20)
                                  Left:NO];
}

- (void)search
{
    
}

-(void)more
{
    
}

-(void)changeView
{
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"PagedScrollCaseStudies"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    self.isInLandscape = (size.width > size.height);
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
        [self configureBGImage];
        
        UICollectionViewFlowLayout *flowLayout = self.collectionView.collectionViewLayout;
        
        [flowLayout invalidateLayout];
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
        [self.navigationController.navigationBar setBottomBorderColor:[UIColor colorWithRed:17/255.0 green:163/255.0 blue:224/255.0 alpha:1] height:1];
        
    }];
}

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
    if (self.isInLandscape)
    {
        return CGSizeMake(282.f, 322.f);
    }
    return CGSizeMake(277.f, 277.f);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (self.isInLandscape)
        return UIEdgeInsetsMake(92, 40, 0, 40);
    else
        return UIEdgeInsetsMake(98, 72, 0, 72);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionView *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (!self.isInLandscape)
        return 98;
    else
        return 98;
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



/*- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionView *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (self.isInLandscape)
        return 40;
    else
        return 0;
}*/

@end
