//
//  CaseStudy+CoreDataProperties.h
//  R&D app
//
//  Created by Oleksandr Chechetkin on 8/15/16.
//  Copyright © 2016 softserve. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CaseStudy.h"

NS_ASSUME_NONNULL_BEGIN

@interface CaseStudy (CoreDataProperties)

@property (nullable, nonatomic, retain) NSData *cache;
@property (nullable, nonatomic, retain) NSString *fullDesc;
@property (nullable, nonatomic, retain) NSData *image;
@property (nullable, nonatomic, retain) NSString *link;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *shortDesc;

@end

NS_ASSUME_NONNULL_END
