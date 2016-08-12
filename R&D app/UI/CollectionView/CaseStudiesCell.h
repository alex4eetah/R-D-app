//
//  CaseStudiesCell.h
//  R&D app
//
//  Created by AlexCheetah on 8/10/16.
//  Copyright © 2016 softserve. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CaseStudiesCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *shortDescription;

@end
