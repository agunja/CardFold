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
        
        _open = NO;
        _middleBaseView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
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

    rightLayer.transform = CATransform3DMakeRotation(-M_PI, 0, 1, 0);
}

- (void)setOpen:(BOOL)open
{
    if (_open != open)
    {
        if (open)
        {
            // Rotate middle base layer
            CALayer *middleBaseLayer = self.middleBaseView.layer;
            CATransform3D oldTransform = middleBaseLayer.transform;
            middleBaseLayer.transform = CATransform3DIdentity;
            CAKeyframeAnimation *transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
            transformAnimation.duration = 2.0;
            
            CATransform3D midTransform = CATransform3DMakeRotation(M_PI_2, 0, 1, 0);
            transformAnimation.values = @[ [NSValue valueWithCATransform3D:oldTransform], [NSValue valueWithCATransform3D:midTransform], [NSValue valueWithCATransform3D:middleBaseLayer.transform]];
            
            [middleBaseLayer addAnimation:transformAnimation forKey:@"transform"];
            
            // Rotate right layer
            CALayer *rightLayer = self.rightView.layer;
            oldTransform = rightLayer.transform;
            rightLayer.transform = CATransform3DIdentity;
            CAKeyframeAnimation *rightAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
            rightAnimation.duration = 2.0;
            
            midTransform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
            rightAnimation.values = @[ [NSValue valueWithCATransform3D:oldTransform], [NSValue valueWithCATransform3D:midTransform], [NSValue valueWithCATransform3D:rightLayer.transform]];
            
            [rightLayer addAnimation:rightAnimation forKey:@"transform"];
        }
        else
        {
            CALayer *middleBaseLayer = self.middleBaseView.layer;
            middleBaseLayer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
            CAKeyframeAnimation *transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
            transformAnimation.duration = 2.0;
            
            CATransform3D midTransform = CATransform3DMakeRotation(M_PI_2, 0, 1, 0);
            transformAnimation.values = @[ [NSValue valueWithCATransform3D:CATransform3DIdentity], [NSValue valueWithCATransform3D:midTransform], [NSValue valueWithCATransform3D:middleBaseLayer.transform]];
            
            [middleBaseLayer addAnimation:transformAnimation forKey:@"transform"];
            
            
            CALayer *rightLayer = self.rightView.layer;
            rightLayer.transform = CATransform3DMakeRotation(-M_PI, 0, 1, 0);
            CAKeyframeAnimation *rightAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
            rightAnimation.duration = 2.0;
            
            midTransform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
            rightAnimation.values = @[ [NSValue valueWithCATransform3D:CATransform3DIdentity], [NSValue valueWithCATransform3D:midTransform], [NSValue valueWithCATransform3D:rightLayer.transform]];
            
            [rightLayer addAnimation:rightAnimation forKey:@"transform"];
        }
        
        _open = open;
    }
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
