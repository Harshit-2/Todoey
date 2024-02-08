//
//  UIAppearance+Swift.m
//  Chameleon
//
//  Created by Vicc Alexander on 11/26/15.
//  Copyright © 2015 Vicc Alexander. All rights reserved.
//

#import "UIAppearance+Swift.h"

@implementation UIView (UIViewAppearance_Swift)

+ (instancetype)appearanceWhenContainedWithin: (NSArray *)containers {
    
    NSUInteger count = containers.count;
    NSAssert(count <= 10, @"The count of containers greater than 10 is not supported.");
    
    NSArray *classesArray = [containers subarrayWithRange:NSMakeRange(0, MIN(count, 10))];
    return [self appearanceWhenContainedInInstancesOfClasses:classesArray];

}

@end
