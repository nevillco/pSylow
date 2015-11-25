//
//  PSResultsViewController.h
//  pSylow
//
//  Created by Connor Neville on 11/25/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PSPrimeFactoredNumber;

@interface PSResultsViewController : UIViewController <UIScrollViewDelegate>

@property PSPrimeFactoredNumber* groupSize;
@property NSUInteger pageNumber;
@property NSUInteger numPages;
@property NSMutableArray* subgroupControllers;
@property (weak, nonatomic) IBOutlet UILabel *groupSizeLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end
