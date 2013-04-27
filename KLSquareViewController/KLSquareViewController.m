//
//  KLSquareViewController.m
//  KLSquareViewControllerDemo
//
//  Created by 柯磊 on 13-4-27.
//  Copyright (c) 2013年 柯磊. All rights reserved.
//

#import "KLSquareViewController.h"

#define kKeyPath_frame @"frame"
#define kKeyPath_bounds @"bounds"

@interface KLSquareViewController ()
{
    @private
    CGSize _selfViewSize;
    BOOL _buttonViewMoveing;
    CGPoint _beginMovePoint;
}
@end

@implementation KLSquareViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        _selfViewSize = CGSizeZero;
        _activeView = KLSquareViewControllerActiveViewAll;
        _buttonViewMoveing = NO;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    [self.view addObserver:self forKeyPath:kKeyPath_frame options:NSKeyValueObservingOptionNew context:nil];
    [self.view addObserver:self forKeyPath:kKeyPath_bounds options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqual:kKeyPath_frame] || [keyPath isEqual:kKeyPath_bounds])
    {
        NSValue *nsRect = [change objectForKey:NSKeyValueChangeNewKey];
        CGRect rect = nsRect.CGRectValue;
        if (!CGSizeEqualToSize(_selfViewSize, rect.size))
        {
            _selfViewSize = rect.size;
            [self childViewResize:_selfViewSize];
        }
    }
}

#pragma mark - touch method

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint locationPoint = [touch locationInView:self.view];
    if (CGRectContainsPoint(_buttonView.frame, locationPoint))
    {
        _buttonViewMoveing = YES;
        _beginMovePoint = locationPoint;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    if (_buttonViewMoveing)
    {
        UITouch *touch = [touches anyObject];
        CGPoint locationPoint = [touch locationInView:self.view];
        CGPoint newPorint;
        newPorint.x = _buttonView.center.x - _beginMovePoint.x + locationPoint.x;
        newPorint.y = _buttonView.center.y - _beginMovePoint.y + locationPoint.y;
        _beginMovePoint = locationPoint;
        [self moveChildViewWithButtonCenterPoint:newPorint];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    _buttonViewMoveing = NO;
    [self moveChildViewWithActiveView:[self activeViewWithButtonCenterPoint] animated:YES];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    _buttonViewMoveing = NO;
    [self moveChildViewWithActiveView:[self activeViewWithButtonCenterPoint] animated:YES];
}

#pragma mark - private method

- (void)childViewResize:(CGSize)size;
{
    CGRect frame;
    
    frame = _leftTopViewController.view.frame;
    frame.size = size;
    _leftTopViewController.view.frame = frame;
    
    frame = _rightTopViewController.view.frame;
    frame.size = size;
    _rightTopViewController.view.frame = frame;
    
    frame = _leftBottomViewController.view.frame;
    frame.size = size;
    _leftBottomViewController.view.frame = frame;
    
    frame = _rightBottomViewController.view.frame;
    frame.size = size;
    _rightBottomViewController.view.frame = frame;
    
    [self moveChildViewWithActiveView:_activeView animated:NO];
}

- (void)moveChildViewWithButtonCenterPoint:(CGPoint)point
{
    _buttonView.center = point;
    
    CGRect frame;
    
    frame = _leftTopViewController.view.frame;
    frame.origin.x = point.x - frame.size.width;
    frame.origin.y = point.y - frame.size.height;
    _leftTopViewController.view.frame = frame;
    
    frame = _rightTopViewController.view.frame;
    frame.origin.x = point.x;
    frame.origin.y = point.y - frame.size.height;
    _rightTopViewController.view.frame = frame;
    
    frame = _leftBottomViewController.view.frame;
    frame.origin.x = point.x - frame.size.width;
    frame.origin.y = point.y;
    _leftBottomViewController.view.frame = frame;
    
    frame = _rightBottomViewController.view.frame;
    frame.origin.x = point.x;
    frame.origin.y = point.y;
    _rightBottomViewController.view.frame = frame;
}

- (void)moveChildViewWithActiveView:(KLSquareViewControllerActiveView)activeView
{
    CGPoint buttonCenterPoint;
    switch (activeView) {
        case KLSquareViewControllerActiveViewLeftTop:
            buttonCenterPoint = CGPointMake(0, 0);
            break;
        case KLSquareViewControllerActiveViewRightTop:
            buttonCenterPoint = CGPointMake(_selfViewSize.width, 0);
            break;
        case KLSquareViewControllerActiveViewLeftBottom:
            buttonCenterPoint = CGPointMake(0, _selfViewSize.height);
            break;
        case KLSquareViewControllerActiveViewRightBottom:
            buttonCenterPoint = CGPointMake(_selfViewSize.width, _selfViewSize.height);
            break;
        default:
            buttonCenterPoint = CGPointMake(_selfViewSize.width * 0.5, _selfViewSize.height * 0.5);
            break;
    }
    [self moveChildViewWithButtonCenterPoint:buttonCenterPoint];
}

- (void)moveChildViewWithActiveView:(KLSquareViewControllerActiveView)activeView
                           animated:(BOOL)animated;
{
    if (animated)
        [UIView animateWithDuration:0.2 animations:^{
            [self moveChildViewWithActiveView:activeView];
        }];
    else
        [self moveChildViewWithActiveView:activeView];
}

/*
 ---------------------------------
 |               |               |
 |               |               |
 |               |               |
 |     LT        |       RT      |
 |               |               |
 |               |               |
 |        ---------------        |
 |        |             |        |
 |        |             |        |
 |--------|      C      |--------|
 |        |             |        |
 |        |             |        |
 |        ---------------        |
 |               |               |
 |               |               |
 |               |               |
 |               |               |
 |     LB        |       RB      |
 |               |               |
 |               |               |
 |               |               |
 |               |               |
 ---------------------------------
*/
- (KLSquareViewControllerActiveView)activeViewWithButtonCenterPoint
{
    CGPoint buttonCenterPoint = _buttonView.center;
    CGRect centerFrame = CGRectMake(_selfViewSize.width / 3.0, _selfViewSize.height / 3.0, _selfViewSize.width / 3.0, _selfViewSize.height / 3.0);
    if (CGRectContainsPoint(centerFrame, buttonCenterPoint))
    return KLSquareViewControllerActiveViewAll;
    
    CGPoint selfCenterPoint = CGPointMake(_selfViewSize.width / 2.0, _selfViewSize.height / 2.0);
    
    CGRect leftTopFrame;
    leftTopFrame.origin = CGPointZero;
    leftTopFrame.size = CGSizeMake(selfCenterPoint.x, selfCenterPoint.y);
    if (CGRectContainsPoint(leftTopFrame, buttonCenterPoint))
        return KLSquareViewControllerActiveViewLeftTop;
    
    CGRect rightTopFrame;
    rightTopFrame.origin = CGPointMake(selfCenterPoint.x, 0);
    rightTopFrame.size = leftTopFrame.size;
    if (CGRectContainsPoint(rightTopFrame, buttonCenterPoint))
        return KLSquareViewControllerActiveViewRightTop;
    
    CGRect leftBottomFrame;
    leftBottomFrame.origin = CGPointMake(0, selfCenterPoint.y);
    leftBottomFrame.size = leftTopFrame.size;
    if (CGRectContainsPoint(leftBottomFrame, buttonCenterPoint))
        return KLSquareViewControllerActiveViewLeftBottom;
    
    return KLSquareViewControllerActiveViewRightBottom;
}

#pragma mark - property method

- (void)setLeftTopViewController:(UIViewController *)leftTopViewController
{
    if (leftTopViewController == _leftTopViewController) return;
    [self.view addSubview:leftTopViewController.view];
    if (_leftTopViewController)
    {
        leftTopViewController.view.frame = _leftTopViewController.view.frame;
        [_leftTopViewController.view removeFromSuperview];
        [_leftTopViewController release];
    }
    _leftTopViewController = [leftTopViewController retain];
}

- (void)setRightTopViewController:(UIViewController *)rightTopViewController
{
    if (rightTopViewController == _rightTopViewController) return;
    [self.view addSubview:rightTopViewController.view];
    if (_rightTopViewController)
    {
        rightTopViewController.view.frame = _rightTopViewController.view.frame;
        [_rightTopViewController.view removeFromSuperview];
        [_rightTopViewController release];
    }
    _rightTopViewController = [rightTopViewController retain];
}

- (void)setLeftBottomViewController:(UIViewController *)leftBottomViewController
{
    if (leftBottomViewController == _leftBottomViewController) return;
    [self.view addSubview:leftBottomViewController.view];
    if (_leftBottomViewController)
    {
        leftBottomViewController.view.frame = _leftBottomViewController.view.frame;
        [_leftBottomViewController.view removeFromSuperview];
        [_leftBottomViewController release];
    }
    _leftBottomViewController = [leftBottomViewController retain];
}

- (void)setRightBottomViewController:(UIViewController *)rightBottomViewController
{
    if (rightBottomViewController == _rightBottomViewController) return;
    [self.view addSubview:rightBottomViewController.view];
    if (_rightBottomViewController)
    {
        rightBottomViewController.view.frame = _rightBottomViewController.view.frame;
        [_rightBottomViewController.view removeFromSuperview];
        [_rightBottomViewController release];
    }
    _rightBottomViewController = [rightBottomViewController retain];
}

- (void)setButtonView:(UIView *)buttonView
{
    if (buttonView == _buttonView) return;
    [self.view addSubview:buttonView];
    if (_buttonView)
    {
        buttonView.center = _buttonView.center;
        [_buttonView removeFromSuperview];
    }
    _buttonView = buttonView;
}

@end
