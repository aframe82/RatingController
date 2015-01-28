//
//  ViewController.m
//  RatingController
//
//  Created by Adam Farah on 28/01/2015.
//  Copyright (c) 2015 Adam Farah. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *ratingBackgroundView;
@property (nonatomic, strong) UIView *maskView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.ratingView.zeroStarImage = [UIImage imageNamed:@"emptystar"];
    self.ratingView.oneStarImage = [UIImage imageNamed:@"star"];
    self.ratingView.halfStarImage = [UIImage imageNamed:@"halfstar"];
    
    self.ratingView.rating = 0.0;
    
    self.ratingView.editable = YES;
    
    self.ratingView.maxRating = 5;
    
    self.ratingView.delegate = self;
}

- (void)ratingView:(RatingView *)ratingView didChangeRatingTo:(float)rating {
    
    self.ratingLabel.text = [NSString stringWithFormat:@"Rating: %.1f", rating];
}

@end
