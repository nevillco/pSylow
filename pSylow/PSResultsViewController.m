//
//  PSResultsViewController.m
//  pSylow
//
//  Created by Connor Neville on 11/25/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "PSResultsViewController.h"
#import "PSPrimeFactoredNumber.h"

@implementation PSResultsViewController

#pragma mark UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateLabels];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark PSResultsViewController

- (void) updateLabels {
    self.groupSizeLabel.text = [NSString stringWithFormat:@"%d", self.groupSize.number];
    
}

@end
