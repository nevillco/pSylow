//
//  PSSylowSubgroup.m
//  pSylow
//
//  Created by Connor Neville on 11/25/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "PSSylowSubgroup.h"
#import "PSPrimeFactoredNumber.h"

@implementation PSSylowSubgroup

- (id) initWithFactor:(NSNumber *)factor withNumber:(PSPrimeFactoredNumber *)number {
    self = [super init];
    if(self) {
        self.factor = factor;
        self.number = number;
        self.exponent = number.exponents[[number.factors indexOfObject: factor]];
    }
    return self;
}

- (int) groupOrder {
    return pow([self.factor intValue], [self.exponent intValue]);
}

- (int) mValue {
    return self.number.number / [self groupOrder];
}

- (NSArray*) possibleNumberOfSubgroups {
    NSMutableArray* results = [[NSMutableArray alloc] init];
    int m = [self mValue];
    for(int i = 1; i <= m; i += [self.factor intValue]) {
        if(m % i == 0) {
            [results addObject:[NSNumber numberWithInt:i]];
        }
    }
    return results;
}

@end
