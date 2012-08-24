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
    CALayer *leftLayer = _leftView.layer;
    leftLayer.position = CGPointZero;
    [self addSubview:_leftView];
}

- (void)setMiddleView:(UIView *)middleView
{
    [_middleView removeFromSuperview];
    _middleView = middleView;
    CALayer *middleLayer = _middleView.layer;
    middleLayer.anchorPoint = CGPointZero;
    middleLayer.position = CGPointZero;
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

- (void)layoutSubviews
{
    CGRect selfBounds = [self bounds];

    //Layout middle base view
    UIView *middleBaseView = [self middleBaseView];
    CGRect middleBaseViewBounds = middleBaseView.bounds;
    middleBaseView.frame = selfBounds;
    middleBaseView.layer.position = CGPointMake(self.layer.bounds.size.width * 0.5, 0);

    //Layout middle view
    UIView *rightView = [self rightView];
    rightView.layer.position = CGPointMake(middleBaseViewBounds.size.width, middleBaseViewBounds.size.height / 2);

    [self bringSubviewToFront:self.leftView];
    [self sendSubviewToBack:self.middleBaseView];
    [self.middleBaseView bringSubviewToFront:self.rightView];
}

@end
