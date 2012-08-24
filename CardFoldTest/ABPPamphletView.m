//
//  ABPPamphletView.m
//  CardFoldTest
//
//  Created by Aqeel Gunja on 8/23/12.
//  Copyright (c) 2012 Aqeel Gunja. All rights reserved.
//

#import "ABPPamphletView.h"

#import "ABPTransformView.h"

@interface ABPPamphletView ()



@end

@implementation ABPPamphletView

//+ (Class)layerClass
//{
//    return [CATransformLayer class];
//}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _middleBaseView = [[ABPTransformView alloc] initWithFrame:frame];
        _middleBaseView.layer.anchorPoint = CGPointMake(0.0, 0.5);
        [self addSubview:_middleBaseView];
        
        CATransform3D initialTransform = self.layer.sublayerTransform;
        initialTransform.m34 = -1.0 / 1200;
        self.layer.sublayerTransform = initialTransform;
    }
    return self;
}

- (void)setLeftView:(UIView *)leftView
{
    [_leftView removeFromSuperview];
    _leftView = leftView;
    [self addSubview:_leftView];
}

- (void)setMiddleView:(UIView *)middleView
{
    [_middleView removeFromSuperview];
    _middleView = middleView;
    [self.middleBaseView addSubview:_middleView];
}

- (void)setRightView:(UIView *)rightView
{
    [_rightView removeFromSuperview];
    _rightView = rightView;
    CALayer *rightLayer = _rightView.layer;
    rightLayer.anchorPoint = CGPointMake(0.0, 0.5);
    [self.middleBaseView addSubview:_rightView];
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGRect leftBounds = self.leftView.bounds;
    CGRect middleBounds = self.middleView.bounds;
    CGRect rightBounds = self.rightView.bounds;
    CGFloat width = leftBounds.size.width + middleBounds.size.width + rightBounds.size.width;
    CGFloat height = MAX(leftBounds.size.height, middleBounds.size.height);
    height = MAX(height, rightBounds.size.height);
    
    return CGSizeMake(width, height);
}

- (void)layoutSubviews
{
    CGRect bounds = self.bounds;
    CGRect leftFrame = self.leftView.frame;
    CGRect middleFrame = self.middleView.frame;
    CGRect rightFrame = self.rightView.frame;
    
    UIView *leftView = self.leftView;
    UIView *middleView = self.middleView;
    UIView *rightView = self.rightView;
    
    leftFrame.origin = CGPointZero;
    leftView.frame = leftFrame;
    
    UIView *middleBaseView = self.middleBaseView;
    middleBaseView.frame = CGRectMake(leftFrame.size.width, 0, middleFrame.size.width + rightFrame.size.width, bounds.size.height);
    
    middleFrame.origin = CGPointZero;
    middleView.frame = middleFrame;
    
    rightFrame.origin = CGPointMake(middleFrame.size.width, 0);
    rightView.frame = rightFrame;
}

@end
