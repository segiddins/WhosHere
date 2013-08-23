//
//  WhosHereIAPHelper.m
//  Who's Here?
//
//  Created by Samuel E. Giddins on 1/15/13.
//  Copyright (c) 2013 Samuel E. Giddins. All rights reserved.
//

#import "WhosHereIAPHelper.h"

#define IAP_SHARED_SECRET 54ea9598805d41cc9dfd37bdc84fb5c1

@interface IAPHelper ()

- (void)provideContentForProductIdentifier:(NSString *)productIdentifier;

@end

@implementation WhosHereIAPHelper

+ (WhosHereIAPHelper *)sharedInstance {
    static dispatch_once_t once;
    static WhosHereIAPHelper * sharedInstance;
    dispatch_once(&once, ^{
        NSSet * productIdentifiers = [NSSet setWithObject:
                                      @"me.segiddins.whoshere.proupgrade"];
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
    });
    return sharedInstance;
}

- (void)provideContentForProductIdentifier:(NSString *)productIdentifier {
    [super provideContentForProductIdentifier:(NSString *)productIdentifier];
    [[[UIAlertView alloc] initWithTitle:@"Thanks!"
                                message:@"Thank you for purchasing the Pro version of Who's Here"
                               delegate:nil
                      cancelButtonTitle:nil
                      otherButtonTitles:@"OK", nil]
     show];
}

@end
