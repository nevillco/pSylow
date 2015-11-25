//
//  PSSubgroupController.m
//  pSylow
//
//  Created by Connor Neville on 11/25/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "PSSubgroupController.h"
#import "PSSylowSubgroup.h"
#import "PSPrimeFactoredNumber.h"

@implementation PSSubgroupController

- (id) initWithSubgroup: (PSSylowSubgroup*) subgroup {
    self = [super init];
    if(self) {
        self.subgroup = subgroup;
        [self makeControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) makeControls {
    self.existenceLabel = [[UILabel alloc] init];
    self.existenceLabel.text = [NSString stringWithFormat:@"By the first Sylow theorem, there exists a %d-Sylow subgroup - that is, a subgroup of order %d.", [self.subgroup.factor intValue], [self.subgroup groupOrder]];
    self.existenceLabel.numberOfLines = 0;
    self.existenceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.existenceLabel.font = [UIFont fontWithName:@"Avenir" size:15.0f];
    [self.view addSubview: self.existenceLabel];
    
    self.numSubgroupsLabel = [[UILabel alloc] init];
    self.numSubgroupsLabel.text = [NSString stringWithFormat:@"Let n denote how many %d-Sylow subgroups there are. By the third Sylow theorem, n is congruent to 1 (mod %d), and n divides %d (%d divided by %d).", [self.subgroup.factor intValue], [self.subgroup.factor intValue], [self.subgroup mValue], self.subgroup.number.number, [self.subgroup groupOrder]];
    self.numSubgroupsLabel.numberOfLines = 0;
    self.numSubgroupsLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.numSubgroupsLabel.font = [UIFont fontWithName:@"Avenir" size:15.0f];
    [self.view addSubview: self.numSubgroupsLabel];
    
    self.conclusionLabel = [[UILabel alloc] init];
    self.conclusionLabel.text = [NSString stringWithFormat:@"In conclusion, a %d element group must have exactly 1 subgroup with %d elements.", self.subgroup.number.number, [self.subgroup groupOrder]];
    self.conclusionLabel.numberOfLines = 0;
    self.conclusionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.conclusionLabel.font = [UIFont fontWithName:@"Avenir-Bold" size:15.0f];
    [self.view addSubview: self.conclusionLabel];
    NSArray* possibleCounts =[self.subgroup possibleNumberOfSubgroups];
    if(possibleCounts.count > 1)
        [self updateConclusionLabel];
    
}

- (void) updateConclusionLabel {
    NSArray* possibleCounts = [self.subgroup possibleNumberOfSubgroups];
    NSString* string = [NSString stringWithFormat:@"In conclusion, a %d element group must have 1", self.subgroup.number.number];
    for(int i = 1; i < possibleCounts.count - 1; i++) {
        string = [string stringByAppendingString:[NSString stringWithFormat:@", %@", possibleCounts[i]]];
    }
    string = [string stringByAppendingString:[NSString stringWithFormat:@", or %@ different subgroups with %d elements.", possibleCounts[possibleCounts.count - 1], [self.subgroup groupOrder]]];
    self.conclusionLabel.text = string;
}

- (void) makeControlConstraints {
    [self.view addConstraints:@[//self.existenceLabel
                                [NSLayoutConstraint constraintWithItem:self.existenceLabel
                                                             attribute:NSLayoutAttributeLeading
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeLeadingMargin
                                                            multiplier:1.0f constant:0.0f],
                                [NSLayoutConstraint constraintWithItem:self.existenceLabel
                                                             attribute:NSLayoutAttributeTrailing
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeTrailingMargin
                                                            multiplier:1.0f constant:0.0f],
                                [NSLayoutConstraint constraintWithItem:self.existenceLabel
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeTop
                                                            multiplier:1.0f constant:0.0f],
                                //self.numSubgroupsLabel
                                [NSLayoutConstraint constraintWithItem:self.numSubgroupsLabel
                                                             attribute:NSLayoutAttributeLeading
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeLeadingMargin
                                                            multiplier:1.0f constant:0.0f],
                                [NSLayoutConstraint constraintWithItem:self.numSubgroupsLabel
                                                             attribute:NSLayoutAttributeTrailing
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeTrailingMargin
                                                            multiplier:1.0f constant:0.0f],
                                [NSLayoutConstraint constraintWithItem:self.numSubgroupsLabel
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.existenceLabel
                                                             attribute:NSLayoutAttributeBottom
                                                            multiplier:1.0f constant:4.0f],
                                //self.conclusionLabel
                                [NSLayoutConstraint constraintWithItem:self.conclusionLabel
                                                             attribute:NSLayoutAttributeLeading
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeLeadingMargin
                                                            multiplier:1.0f constant:0.0f],
                                [NSLayoutConstraint constraintWithItem:self.conclusionLabel
                                                             attribute:NSLayoutAttributeTrailing
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeTrailingMargin
                                                            multiplier:1.0f constant:0.0f],
                                [NSLayoutConstraint constraintWithItem:self.conclusionLabel
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.numSubgroupsLabel
                                                             attribute:NSLayoutAttributeBottom
                                                            multiplier:1.0f constant:4.0f],
                                ]];
}
@end
