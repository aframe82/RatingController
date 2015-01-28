//
//  RatingView.m
//  RatingController
//
//  Created by Adam Farah on 28/01/2015.
//  Copyright (c) 2015 Adam Farah. All rights reserved.
//

#import "RatingView.h"

@implementation RatingView

#pragma mark - Init methods

- (void)initVars {
    
    _zeroStarImage = nil;
    _halfStarImage = nil;
    _oneStarImage = nil;
    
    _rating = 0;
    _maxRating = 5;
    
    _editable = NO;
    
    _imageViewsArray = [[NSMutableArray alloc] init];

    _middleMargin = 5;
    _leftMargin = 0;
    
    _minImageSize = CGSizeMake(5,5);
    
    _delegate = nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initVars];
    }
    
    return  self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self initVars];
    }
    
    return self;
}

#pragma mark - Refresh method

- (void)refresh {
    
    for (int i = 0; i < self.imageViewsArray.count; i++) {
        
        UIImageView *imageView = [self.imageViewsArray objectAtIndex:i];
        
        if (self.rating >= i + 1)
        {
            imageView.image = self.oneStarImage;
        }
        else if (self.rating > i)
        {
            imageView.image = self.halfStarImage;
        }
        else
        {
            imageView.image = self.zeroStarImage;
        }
    }
}

#pragma mark layoutSubviews override

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    if (!self.zeroStarImage) {
        return;
    }
    
    float desiredImageWidth = (self.frame.size.width - (self.leftMargin * 2) - (self.middleMargin * self.imageViewsArray.count)) / self.imageViewsArray.count;
    
    float imageWidth = MAX(self.minImageSize.width, desiredImageWidth);
    float imageHeight = MAX(self.minImageSize.height, self.frame.size.height);
    
    for (int i = 0; i < self.imageViewsArray.count; i++) {
        
        UIImageView *imageView = [self.imageViewsArray objectAtIndex:i];
        
        CGRect imageFrame = CGRectMake(self.leftMargin + i * (self.middleMargin+imageWidth),
                                       0,
                                       imageWidth,
                                       imageHeight);
        
        imageView.frame = imageFrame;
    }
}

#pragma mark - Variable overrides

- (void)setMaxRating:(int)maxRating {
    
    _maxRating = maxRating;
    
    // Remove old imageViews
    for (int i = 0; i < self.imageViewsArray.count; i++) {
        
        UIImageView *imageView = [self.imageViewsArray objectAtIndex:i];
        [imageView removeFromSuperview];
    }
    
    [self.imageViewsArray removeAllObjects];
    
    // Add new imageViews
    for (int i = 0; i < maxRating; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.imageViewsArray addObject:imageView];
        [self addSubview:imageView];
    }
    
    // Relayout & refresh
    [self setNeedsLayout];
    [self refresh];
}

- (void)setZeroStarImage:(UIImage *)zeroStarImage {
    
    _zeroStarImage = zeroStarImage;
    [self refresh];
}

- (void)setHalfStarImage:(UIImage *)halfStarImage {
    
    _halfStarImage = halfStarImage;
    [self refresh];
}

- (void)setOneStarImage:(UIImage *)oneStarImage {
    
    _oneStarImage = oneStarImage;
    [self refresh];
}

- (void)setRating:(float)rating {
    
    _rating = rating;
    [self refresh];
}

#pragma mark - Touch handling

- (void)handleTouchAtPoint:(CGPoint)touchPoint {
    
    if (!self.isEditable) {
        return;
    }
    
    float newRating = 0.0;
    
    for (int i = (int)self.imageViewsArray.count - 1; i>= 0; i--) {
        
        UIImageView *imageView = [self.imageViewsArray objectAtIndex:i];
        
        CGFloat distance = touchPoint.x - imageView.frame.origin.x;
        
        CGFloat frameWidth = imageView.frame.size.width;
        
        if (distance <= 0) {
            continue;
        }
        
        // If we are further than half way, mark it as a full rating
        if (distance / frameWidth > 0.5)
        {
            newRating = i + 1;
            break;
        }
        else
            //if (distance / frameWidth <= 0.5)
        {
            newRating = i + 0.5;
            break;
        }
    }
    
    self.rating = newRating;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    [self handleTouchAtPoint:touchPoint];
    [self.delegate ratingView:self didChangeRatingTo:self.rating];

}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    [self handleTouchAtPoint:touchPoint];
    [self.delegate ratingView:self didChangeRatingTo:self.rating];

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
//    [self.delegate ratingView:self didChangeRatingTo:self.rating];
}


@end
