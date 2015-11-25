//
//  PSHomeViewController.m
//  pSylow
//
//  Created by Connor Neville on 11/25/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "PSHomeViewController.h"
#import "PSResultsViewController.h"
#import "PSPrimeFactoredNumber.h"

@interface PSHomeViewController ()

@property (weak, nonatomic) IBOutlet UITextField *sizeField;

@end

@implementation PSHomeViewController

#pragma mark UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fixAppearance];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark PSHomeViewController

//Appearance tweaks not easily made in IB
- (void) fixAppearance {
    self.sizeField.layer.borderColor = [UIColor blackColor].CGColor;
    self.sizeField.layer.borderWidth = 2.0f;
    self.sizeField.layer.cornerRadius = 5.0f;
}

- (IBAction)goButtonPressed:(id)sender {
    //0 if field text
    int groupSize = [self.sizeField.text intValue];
    if(groupSize < 2) {
        [self alertInvalidInput];
        return;
    }
    //segue to results
    [self performSegueWithIdentifier:@"ShowResultsSegue" sender:self];
}

//Pass groupSize to results controller
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PSResultsViewController* destination = (PSResultsViewController*)[segue destinationViewController];
    destination.groupSize = [[PSPrimeFactoredNumber alloc] initWithNumber:[self.sizeField.text intValue]];
}

//On invalid input, present alert controller
- (void) alertInvalidInput {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Invalid" message:@"Please enter an integer group size that is at least 2." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction: action];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
