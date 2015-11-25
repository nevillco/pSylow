//
//  PSSubgroupController.h
//  pSylow
//
//  Created by Connor Neville on 11/25/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PSSylowSubgroup;

@interface PSSubgroupController : UIViewController

@property PSSylowSubgroup* subgroup;

@property UILabel* existenceLabel;
@property UILabel* numSubgroupsLabel;
@property UILabel* conclusionLabel;

- (id) initWithSubgroup: (PSSylowSubgroup*) subgroup;

@end
