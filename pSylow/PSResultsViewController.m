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
    self.groupSizeLabel.attributedText = [self.groupSize factorizationAsString];
}

- (IBAction)returnButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
