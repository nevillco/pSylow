//
//  PSPrimeFactoredNumber.m
//  pSylow
//
//  Created by Connor Neville on 11/25/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "PSPrimeFactoredNumber.h"
#import <CoreText/CTStringAttributes.h>

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

//Can check for a prime if its prime factorization is itself
- (BOOL) isPrime {
    return [self.exponents isEqual: @[@1].mutableCopy];
}

//Returns a string representation of the factorization
//including superscripts for exponents
- (NSMutableAttributedString*) factorizationAsString {
    //Initial string
    NSMutableAttributedString *attrString =
    [[NSMutableAttributedString alloc] initWithString:
     [NSString stringWithFormat:@"%d=%d%d", self.number,
      [self.factors[0] intValue], [self.exponents[0] intValue]]];
    //Superscript last index
    int lastIndex = (int)attrString.length - 1;
    [attrString addAttribute:(id)kCTSuperscriptAttributeName
                       value:(id)@1 range:NSMakeRange(lastIndex, 1)];
    //Loop through additional factor/exponent pairs
    for(int i = 1; i < self.factors.count; i++) {
        NSMutableAttributedString* concat =
        [[NSMutableAttributedString alloc] initWithString:
         [NSString stringWithFormat:@"*%d%d",
          [self.factors[i] intValue], [self.exponents[i] intValue]]];
        
        int lastIndex = (int)concat.length - 1;
        [concat addAttribute:(id)kCTSuperscriptAttributeName
                           value:(id)@1 range:NSMakeRange(lastIndex, 1)];
        [attrString appendAttributedString:concat];
        
    }
    return attrString;
}

@end
