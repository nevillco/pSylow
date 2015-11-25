//
//  PSResultsViewController.h
//  pSylow
//
//  Created by Connor Neville on 11/25/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PSPrimeFactoredNumber;

@interface PSResultsViewController : UIViewController

@property PSPrimeFactoredNumber* groupSize;
@property (weak, nonatomic) IBOutlet UILabel *groupSizeLabel;

@end
