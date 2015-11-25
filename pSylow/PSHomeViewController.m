//
//  PSHomeViewController.m
//  pSylow
//
//  Created by Connor Neville on 11/25/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "PSHomeViewController.h"

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
    //segue to results
}

@end
