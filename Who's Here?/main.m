//
//  main.m
//  Who's Here?
//
//  Created by Samuel E. Giddins on 1/11/13.
//  Copyright (c) 2013 Samuel E. Giddins. All rights reserved.
//

#import <UI7Kit/UI7Kit.h>

#import "SEGAppDelegate.h"

int main(int argc, char *argv[])
{
    @autoreleasepool {
        [UI7Kit patchIfNeeded];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([SEGAppDelegate class]));
    }
}
