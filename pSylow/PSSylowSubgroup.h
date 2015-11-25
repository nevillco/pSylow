//
//  PSSylowSubgroup.h
//  pSylow
//
//  Created by Connor Neville on 11/25/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PSPrimeFactoredNumber;

@interface PSSylowSubgroup : NSObject

@property NSNumber* factor;
@property NSNumber* exponent;
@property PSPrimeFactoredNumber* number;

- (id) initWithFactor: (NSNumber*) factor withNumber: (PSPrimeFactoredNumber*) number;

- (int) groupOrder;
- (int) mValue;
- (NSArray*) possibleNumberOfSubgroups;

@end
