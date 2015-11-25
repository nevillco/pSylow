//
//  PSResultsViewController.m
//  pSylow
//
//  Created by Connor Neville on 11/25/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "PSHomeViewController.h"
#import "PSResultsViewController.h"
#import "PSSubgroupController.h"
#import "PSPrimeFactoredNumber.h"
#import "PSSylowSubgroup.h"

@implementation PSResultsViewController

#pragma mark UIViewController

- (void)viewDidLoad {
    [self updateLabels];
    self.pageNumber = 0;
    self.numPages = self.groupSize.factors.count;
    self.pageControl.numberOfPages = self.numPages;
    self.pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
    self.pageControl.pageIndicatorTintColor = [UIColor blackColor];
    [self initializePages];
}

- (void)viewDidAppear:(BOOL)animated {
    for(int i = 0; i < self.numPages; i++) {
        [self loadScrollViewWithPage: i];
    }
    [self initializeScrollView];
}

#pragma mark PSResultsViewController

- (void) updateLabels {
    self.groupSizeLabel.attributedText = [self.groupSize factorizationAsString];
}

- (IBAction)returnButtonPressed:(id)sender {
    PSHomeViewController* presenter = (PSHomeViewController*)[self presentingViewController];
    [presenter clearSizeField];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark scrolling

- (void) initializeScrollView {
    // a page is the width of the scroll view
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize =
    CGSizeMake(CGRectGetWidth(self.scrollView.frame) * self.numPages, CGRectGetHeight(self.scrollView.frame));
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollsToTop = NO;
    self.scrollView.delegate = self;
}

- (void) initializePages {
    self.subgroupControllers = [[NSMutableArray alloc] initWithCapacity:self.numPages];
    for(int i = 0; i < self.numPages; i++) {
        PSSylowSubgroup* subgroup = [[PSSylowSubgroup alloc]
                                     initWithFactor:self.groupSize.factors[i]
                                     withNumber:self.groupSize];
        [self.subgroupControllers addObject: [[PSSubgroupController alloc] initWithSubgroup: subgroup]];
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    // remove all the subviews from our scrollview
    for (UIView *view in self.scrollView.subviews)
    {
        [view removeFromSuperview];
    }
    
    // adjust the contentSize (larger or smaller) depending on the orientation
    self.scrollView.contentSize =
    CGSizeMake(CGRectGetWidth(self.scrollView.frame) * self.numPages, CGRectGetHeight(self.scrollView.frame));
    
    [self loadScrollViewWithPage:self.pageControl.currentPage - 1];
    [self loadScrollViewWithPage:self.pageControl.currentPage];
    [self loadScrollViewWithPage:self.pageControl.currentPage + 1];
    [self gotoPage:NO]; // remain at the same page (don't animate)
    
}

- (void)loadScrollViewWithPage:(NSUInteger)page
{
    if (page >= self.groupSize.factors.count)
        return;
    
    // replace the placeholder if necessary
    PSSubgroupController *controller = [self.subgroupControllers objectAtIndex:page];
    
    // add the controller's view to the scroll view
    if (controller.view.superview == nil)
    {
        CGRect frame = self.scrollView.frame;
        frame.origin.x = CGRectGetWidth(frame) * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        
        [self addChildViewController:controller];
        [self.scrollView addSubview:controller.view];
        [controller didMoveToParentViewController:self];
    }
}

// at the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = CGRectGetWidth(self.scrollView.frame);
    NSUInteger page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
    // a possible optimization would be to unload the views+controllers which are no longer visible
}

- (void)gotoPage:(BOOL)animated
{
    NSInteger page = self.pageControl.currentPage;
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
    // update the scroll view to the appropriate page
    CGRect bounds = self.scrollView.bounds;
    bounds.origin.x = CGRectGetWidth(bounds) * page;
    bounds.origin.y = 0;
    [self.scrollView scrollRectToVisible:bounds animated:animated];
}

- (IBAction)changePage:(id)sender
{
    [self gotoPage:YES];    // YES = animate
}

@end
