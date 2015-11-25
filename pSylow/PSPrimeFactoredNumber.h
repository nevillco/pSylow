//
//  PSPrimeFactoredNumber.h
//  pSylow
//
//  Created by Connor Neville on 11/25/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSPrimeFactoredNumber : NSObject

- (id) initWithNumber: (int) number;

@property int number;
@property NSMutableArray* factors;
@property NSMutableArray* exponents;

- (BOOL) isPrime;
- (NSMutableAttributedString*) factorizationAsString;

@end
