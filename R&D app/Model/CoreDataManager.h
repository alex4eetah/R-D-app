//
//  CoreDataManager.h
//  R&D app
//
//  Created by Oleksandr Chechetkin on 8/15/16.
//  Copyright © 2016 softserve. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NSManagedObjectContext;
@class CaseStudy;
@class UIImage;

@interface CoreDataManager : NSObject

@property (nonatomic, strong) NSManagedObjectContext *context;

+(instancetype)sharedManager;

- (void)saveCaseStudyWithName:(NSString *)name
                         Link:(NSString *)link
             ShortDeskription:(NSString *)shortDesc
                  Description:(NSString *)fullDesc
                        Image:(UIImage *)image
                        Cache:(NSData *)cache
                         Save:(BOOL)save;

- (void)deleteCaseStudy:(CaseStudy *)instance;

- (NSArray *)getArrayOfCaseStudies;

- (NSArray *)getSortedArrayOfCaseStudiesAscending:(BOOL) ascending;

-(void)fakeFromArray:(NSArray *)arr;

@end
