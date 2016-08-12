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

@interface CaseStudiesCollectionViewController()

@property(strong, nonatomic) NSArray *pics;

@property (weak, nonatomic) IBOutlet UIImageView *backGroundImageView;
@property(assign, nonatomic) BOOL isInLandscape;

@end

@implementation CaseStudiesCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isInLandscape = (self.view.frame.size.width > self.view.frame.size.height);
    
    [self configureBGImage];

    [self configureNavigationBar];

    self.pics = [NSArray arrayWithObjects:
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
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"footerGradient"]
                                                  forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBottomBorderColor:[UIColor colorWithRed:17 green:163 blue:224 alpha:1] height:1];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    [self addNavigationButtonForTarget:self
                              Selector:@selector(search)
                         ImageWithName:@"searchNavBarIcon"
                                  Size:CGSizeMake(18, 18)
                                  Left:YES];
    [self addNavigationButtonForTarget:self
                              Selector:@selector(more)
                         ImageWithName:@"changeVIewNavBarIcon"
                                  Size:CGSizeMake(28, 20)
                                  Left:NO];
    [self addNavigationButtonForTarget:self
                              Selector:@selector(changeView)
                         ImageWithName:@"moreNavBarIcon"
                                  Size:CGSizeMake(5, 17)
                                  Left:NO];
}

- (void)addNavigationButtonForTarget:(id)obj
                            Selector:(SEL)selector
                         ImageWithName:(NSString *)img
                                Size:(CGSize)size
                                  Left:(BOOL)isLeft
{
    UIImage* image = [UIImage imageNamed:img];
    CGRect frameimg = CGRectMake(0, 0, size.width, size.height);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:image forState:UIControlStateNormal];
    [someButton addTarget:obj action:selector forControlEvents:UIControlEventTouchUpInside];
    [someButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *BarButton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    if (isLeft) {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        [arr addObject:BarButton];
        for (UIBarButtonItem *item in self.navigationItem.leftBarButtonItems)
        {
            [arr addObject:item];
        }
        
        self.navigationItem.leftBarButtonItems = arr;
    } else {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        [arr addObject:BarButton];
        for (UIBarButtonItem *item in self.navigationItem.rightBarButtonItems)
        {
            [arr addObject:item];
        }
        
        self.navigationItem.rightBarButtonItems = arr;
    }
}

- (void)search
{
    
}

-(void)more
{
    
}

-(void)changeView
{
    
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    [self.navigationController.navigationBar setBottomBorderColor:[UIColor colorWithRed:17 green:163 blue:224 alpha:1] height:1];
    
    self.isInLandscape = (size.width > size.height);
    
    [self configureBGImage];
    
    UICollectionViewFlowLayout *flowLayout = self.collectionView.collectionViewLayout;
    
    
    [flowLayout invalidateLayout];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CaseStudiesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CaseStudyCell"
                                                                      forIndexPath:indexPath];
    cell.image.image = (self.pics[indexPath.row])[@"img"];
    cell.name.text = (self.pics[indexPath.row])[@"name"];
    cell.shortDescription.text = (self.pics[indexPath.row])[@"desc"];
    
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

/*- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionView *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (self.isInLandscape)
        return 40;
    else
        return 0;
}*/

@end