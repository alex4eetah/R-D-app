//
//  CoreDataManager.m
//  R&D app
//
//  Created by Oleksandr Chechetkin on 8/15/16.
//  Copyright © 2016 softserve. All rights reserved.
//

#import "CoreDataManager.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "CaseStudy.h"

@implementation CoreDataManager

+(instancetype)sharedManager {
    static CoreDataManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CoreDataManager alloc] init];
    });
    return instance;
}

-(void)fakeFromArray:(NSArray *)arr
{
    for (NSDictionary *dict in arr) {
        [self saveCaseStudyWithName:dict[@"name"]
                               Link:dict[@"link"]
                   ShortDeskription:dict[@"shortDesc"]
                        Description:dict[@"fullDesc"]
                              Image:dict[@"image"]
                              Cache:dict[@"cache"]
                               Save:NO];
    }
    [self.context save:nil];
}

- (NSManagedObjectContext *)context
{
    if (!_context)
    {
        AppDelegate *delegate = [AppDelegate sharedDelegate];
        _context = delegate.managedObjectContext;
    }
    return _context;
}

- (void)updateCaseStudyWithName:(NSString *)name Force:(BOOL)force
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CaseStudy" inManagedObjectContext:self.context];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", name];
    [fetchRequest setPredicate:predicate];
     NSError *error = nil;
    NSArray *result = [self.context executeFetchRequest:fetchRequest error:&error];
    
    if([result count] == 1) {
        CaseStudy *instance = [result objectAtIndex:0];
        
        if (!instance.cache || force) {
            NSURL *url = [NSURL URLWithString:instance.link];
            NSError *error;
            NSString *page = [NSString stringWithContentsOfURL:url
                                                      encoding:NSASCIIStringEncoding
                                                         error:&error];
            if (!error) {
                instance.cache = page;
            }
            
            [self.context save:nil];
        }
    }
}

- (void)updateCaseStudies
{
    NSArray *arr = [self getArrayOfCaseStudies];
    for (CaseStudy *instance in arr) {
        if (instance.cache == nil && instance.link) {
            NSString *urlStr = instance.link;
            NSURL *url = [NSURL URLWithString:urlStr];
            NSError *error;
            NSString *page = [NSString stringWithContentsOfURL:url
                                                            encoding:NSASCIIStringEncoding
                                                               error:&error];
            if (!error) {
                instance.cache = page;
            }
        }
    }
}

- (void)saveCaseStudyWithName:(NSString *)name
                         Link:(NSString *)link
             ShortDeskription:(NSString *)shortDesc
                  Description:(NSString *)fullDesc
                        Image:(UIImage *)image
                        Cache:(NSString *)cache
                         Save:(BOOL)save
{
    CaseStudy *coreDataInstance = [NSEntityDescription insertNewObjectForEntityForName:@"CaseStudy" inManagedObjectContext:self.context];
    coreDataInstance.name = name;
    coreDataInstance.link = link;
    coreDataInstance.shortDesc = shortDesc;
    coreDataInstance.fullDesc = fullDesc;
    coreDataInstance.image = UIImageJPEGRepresentation(image,1);
    coreDataInstance.cache = cache;
    if (save) {
        [self.context save:nil];
    }
}

- (void)deleteCaseStudy:(CaseStudy *)instance
{
    [self.context deleteObject:(NSManagedObject *)instance];
    [self.context save:nil];
}

- (NSArray *)getArrayOfCaseStudies
{
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription * description =
    [NSEntityDescription entityForName:@"CaseStudy"
                inManagedObjectContext:self.context];
    [request setEntity:description];
    
    NSArray *fetchResult = [self.context executeFetchRequest:request error:nil];
    
    return fetchResult;
}

- (NSArray *)getSortedArrayOfCaseStudiesAscending:(BOOL) ascending
{
    //TODO sort
    return [self getArrayOfCaseStudies];
}



@end
