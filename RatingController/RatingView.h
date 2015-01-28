//
//  RatingView.h
//  RatingController
//
//  Created by Adam Farah on 28/01/2015.
//  Copyright (c) 2015 Adam Farah. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RatingView;

@protocol RatingViewDelegate

- (void)ratingView:(RatingView *)ratingView didChangeRatingTo:(float)rating;

@end

@interface RatingView : UIView

// Star Images for state of rating
@property (nonatomic, strong) UIImage *zeroStarImage;
@property (nonatomic, strong) UIImage *halfStarImage;
@property (nonatomic, strong) UIImage *oneStarImage;

// Array of Images for the RatingView
@property (nonatomic, strong) NSMutableArray *imageViewsArray;

// Current Rating
@property (nonatomic, assign) float rating;

// Max Rating
@property (nonatomic, assign) int maxRating;

// Can the rating be given, or is it read only?
@property (nonatomic, assign, getter=isEditable) BOOL editable;

// Margins between stars
@property (nonatomic, assign) int middleMargin;
@property (nonatomic, assign) int leftMargin;

// Minimum image size
@property (nonatomic, assign) CGSize minImageSize;

// Delegate property
@property (nonatomic, assign) id <RatingViewDelegate> delegate;

@end
