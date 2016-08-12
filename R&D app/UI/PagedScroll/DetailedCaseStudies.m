//
//  DetailedCaseStudies.m
//  R&D app
//
//  Created by Oleksandr Chechetkin on 8/12/16.
//  Copyright © 2016 softserve. All rights reserved.
//

#import "DetailedCaseStudies.h"
#import "DetailedCaseStudyViewController.h"

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
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    for (int i=0; i<5; i++) {
        DetailedCaseStudyViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"DetailedCaseStudiesVC"];
        
        vc.imageViewToSEt.image = (pics[i])[@"img"];
        vc.view.frame = CGRectMake(self.scroll.frame.size.width * i, 0, self.scroll.frame.size.width, self.scroll.frame.size.height);
        
        
        [self.scroll addSubview:vc.view];
        [arr addObject:vc];
    }

    self.scroll.contentSize = CGSizeMake(self.scroll.frame.size.width * pics.count, self.scroll.frame.size.height);
    
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
