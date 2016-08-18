//
//  RDServerManager.h
//  R&D app
//
//  Created by Oleksandr Chechetkin on 8/18/16.
//  Copyright © 2016 softserve. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RDServerManager : NSObject

+ (instancetype)sharedManager;

- (void) authorizeUserWithCredentials:(NSDictionary *) creds
                           Completion:(void(^)(BOOL done)) completion;

- (void) changePasswordWithCredentials:(NSDictionary *) creds
                            Completion:(void(^)(BOOL done)) completion;

@end
