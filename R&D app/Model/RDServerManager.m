//
//  RDServerManager.m
//  R&D app
//
//  Created by Oleksandr Chechetkin on 8/18/16.
//  Copyright © 2016 softserve. All rights reserved.
//

#import "RDServerManager.h"

@implementation RDServerManager

+ (instancetype)sharedManager
{
    static RDServerManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[RDServerManager alloc] init];
    });
    return instance;
}

- (void) authorizeUserWithCredentials:(NSDictionary *) creds
                           Completion:(void(^)(BOOL done)) completion
{
        /*
         -----------TODO: request to service, autorize, get result
         */
        
        if ([creds[@"Login"] isEqualToString: @"Root" ] && [creds[@"Password"] isEqualToString: @"Root"]) {
            completion(YES);
        } else {
            completion(NO);
        }
}

@end
