//
//  ViewController.h
//  RatingController
//
//  Created by Adam Farah on 28/01/2015.
//  Copyright (c) 2015 Adam Farah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingView.h"

@interface ViewController : UIViewController <RatingViewDelegate>

@property (weak, nonatomic) IBOutlet RatingView *ratingView;

@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;


@end

