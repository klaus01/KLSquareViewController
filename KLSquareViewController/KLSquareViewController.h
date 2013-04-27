//
//  KLSquareViewController.h
//  KLSquareViewControllerDemo
//
//  Created by 柯磊 on 13-4-27.
//  Copyright (c) 2013年 柯磊. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, KLSquareViewControllerActiveView) {
    KLSquareViewControllerActiveViewAll         = 0,
    KLSquareViewControllerActiveViewLeftTop     = 1,
    KLSquareViewControllerActiveViewRightTop    = 2,
    KLSquareViewControllerActiveViewLeftBottom  = 3,
    KLSquareViewControllerActiveViewRightBottom = 4
};

@interface KLSquareViewController : UIViewController
@property (nonatomic, retain) UIViewController *leftTopViewController;
@property (nonatomic, retain) UIViewController *rightTopViewController;
@property (nonatomic, retain) UIViewController *leftBottomViewController;
@property (nonatomic, retain) UIViewController *rightBottomViewController;
@property (nonatomic, retain) UIView *buttonView;
@property (nonatomic, assign, readonly) KLSquareViewControllerActiveView activeView;
@end
