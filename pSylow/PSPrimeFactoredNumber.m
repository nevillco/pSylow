//
//  PSPrimeFactoredNumber.m
//  pSylow
//
//  Created by Connor Neville on 11/25/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "PSPrimeFactoredNumber.h"

@implementation PSPrimeFactoredNumber

- (id) initWithNumber: (int) number {
    self = [super init];
    if(self) {
        self.number = number;
        self.factors = [[NSMutableArray alloc] initWithCapacity:5];
        self.exponents = [[NSMutableArray alloc] initWithCapacity:5];
        [self generateFactorizationForNumber: number];
    }
    return self;
}

//Parameter in method necessary for recursive call
- (void) generateFactorizationForNumber: (int) number {
    for(int i = 2; i <= number; i++) {
        if(number % i == 0) { //If i is a factor
            [self addFactorInstance: i];
            //Recursive call on remainder of number
            if((number / i) >= 2)
                [self generateFactorizationForNumber: (number / i)];
            return;
        }
    }
}

- (void) addFactorInstance: (int) factor {
    NSNumber* wrapper = [NSNumber numberWithInt: factor];
    //If the number is already a factor, just increment exponent
    if([self.factors containsObject: wrapper]) {
        int index = (int)[self.factors indexOfObject: wrapper];
        NSNumber* exponent = self.exponents[index];
        [self.exponents setObject:
         [NSNumber numberWithInt: [exponent intValue] + 1] atIndexedSubscript:index];
    }
    //Otherwise add the factor with an exponent of 1
    else {
        [self.factors addObject:[NSNumber numberWithInt: factor]];
        [self.exponents addObject:[NSNumber numberWithInt: 1]];
    }
}

@end
