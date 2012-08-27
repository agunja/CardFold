//
//  ABPPamphletView.m
//  CardFoldTest
//
//  Created by Aqeel Gunja on 8/23/12.
//  Copyright (c) 2012 Aqeel Gunja. All rights reserved.
//

#import "ABPPamphletView.h"

#import "ABPTransformView.h"
#import "CFTDoubleSidedView.h"

@interface ABPPamphletView ()

@property (nonatomic, strong) CAGradientLayer *middleGradientLayer;

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

        _middleGradientLayer = [CAGradientLayer layer];
        _middleGradientLayer.startPoint = CGPointMake(0.0, 0.5);
        _middleGradientLayer.endPoint = CGPointMake(1.0, 0.5);
        UIColor *leftColor = [UIColor blackColor];
        UIColor *rightColor = [UIColor blackColor];
        _middleGradientLayer.colors = @[ (id)leftColor.CGColor, (id)rightColor.CGColor];
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
    [self.middleGradientLayer removeFromSuperlayer];
    _middleView = middleView;
    [self.middleBaseView addSubview:_middleView];
    if ([middleView isKindOfClass:[CFTDoubleSidedView class]])
    {
        CFTDoubleSidedView *doubleMiddleView = (CFTDoubleSidedView *)middleView;
        [doubleMiddleView.frontView.layer addSublayer:self.middleGradientLayer];
    }
    else
    {
        [_middleView.layer addSublayer:self.middleGradientLayer];
    }
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

- (NSArray *)colorsForOpen:(BOOL)open
{
    CGColorRef leftColor;
    CGColorRef rightColor;
    if (open) {
        leftColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0].CGColor;
        rightColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0].CGColor;
    }
    else
    {
        leftColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9].CGColor;
        rightColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9].CGColor;
    }
    return @[ (__bridge id)leftColor, (__bridge id)rightColor ];
}

- (void)animateGradientToOpen:(BOOL)open withDuration:(CGFloat)duration
{
    NSArray *newColors = [self colorsForOpen:open];
    NSArray *oldColors = [(CAGradientLayer *)self.middleGradientLayer.presentationLayer colors];
    
    self.middleGradientLayer.colors = newColors;
    
    UIColor *midLeftColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.25];
    UIColor *midRightColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.75];
    NSArray *midColors = @[ (id)midLeftColor.CGColor, (id)midRightColor.CGColor ];
    
    CAKeyframeAnimation *gradientAnimation = [CAKeyframeAnimation animationWithKeyPath:@"colors"];
    gradientAnimation.duration = duration;
    gradientAnimation.values = @[ oldColors, midColors, newColors ];
    [self.middleGradientLayer addAnimation:gradientAnimation forKey:@"colors"];
}

- (void)setOpen:(BOOL)open
{
    if (_open != open)
    {
        [CATransaction begin];
        if (open)
        {
            CGFloat duration = 2.0;
            // Rotate middle base layer
            CALayer *middleBaseLayer = self.middleBaseView.layer;
            CATransform3D oldTransform = [(CALayer *)(middleBaseLayer.presentationLayer) transform];
            middleBaseLayer.transform = CATransform3DIdentity;
            CAKeyframeAnimation *transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
            transformAnimation.duration = duration;
            
            CATransform3D midTransform = CATransform3DMakeRotation(M_PI_2, 0, 1, 0);
            transformAnimation.values = @[ [NSValue valueWithCATransform3D:oldTransform], [NSValue valueWithCATransform3D:midTransform], [NSValue valueWithCATransform3D:middleBaseLayer.transform]];
            
            [middleBaseLayer addAnimation:transformAnimation forKey:@"transform"];
            [self animateGradientToOpen:open withDuration:duration];
            
            // Rotate right layer
            CALayer *rightLayer = self.rightView.layer;
            oldTransform = [(CALayer *)rightLayer.presentationLayer transform];
            rightLayer.transform = CATransform3DIdentity;
            CAKeyframeAnimation *rightAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
            rightAnimation.duration = duration;
            
            midTransform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
            rightAnimation.values = @[ [NSValue valueWithCATransform3D:oldTransform], [NSValue valueWithCATransform3D:midTransform], [NSValue valueWithCATransform3D:rightLayer.transform]];
            
            [rightLayer addAnimation:rightAnimation forKey:@"transform"];
        }
        else
        {
            CGFloat duration = 2.0;
            
            CALayer *middleBaseLayer = self.middleBaseView.layer;
            CATransform3D oldTransform = [(CALayer *)(middleBaseLayer.presentationLayer) transform];      
            middleBaseLayer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
            CAKeyframeAnimation *transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
            transformAnimation.duration = duration;
            
            CATransform3D midTransform = CATransform3DMakeRotation(M_PI_2, 0, 1, 0);
            transformAnimation.values = @[ [NSValue valueWithCATransform3D:oldTransform], [NSValue valueWithCATransform3D:midTransform], [NSValue valueWithCATransform3D:middleBaseLayer.transform]];
            
            [middleBaseLayer addAnimation:transformAnimation forKey:@"transform"];
            [self animateGradientToOpen:open withDuration:duration];            
            
            CALayer *rightLayer = self.rightView.layer;
            oldTransform = [(CALayer *)rightLayer.presentationLayer transform];          
            rightLayer.transform = CATransform3DMakeRotation(-M_PI, 0, 1, 0);
            CAKeyframeAnimation *rightAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
            rightAnimation.duration = duration;
            
            midTransform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
            rightAnimation.values = @[ [NSValue valueWithCATransform3D:oldTransform], [NSValue valueWithCATransform3D:midTransform], [NSValue valueWithCATransform3D:rightLayer.transform]];
            
            [rightLayer addAnimation:rightAnimation forKey:@"transform"];
        }
        
        _open = open;
        [CATransaction commit];
    }
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGFloat width, height;
    CGRect leftBounds = self.leftView.bounds;    
    if (self.open)
    {
        CGRect middleBounds = self.middleView.bounds;
        CGRect rightBounds = self.rightView.bounds;
        width = leftBounds.size.width + middleBounds.size.width + rightBounds.size.width;
        height = MAX(leftBounds.size.height, middleBounds.size.height);
        height = MAX(height, rightBounds.size.height);
    }
    else
    {
        width = leftBounds.size.width;
        height = leftBounds.size.height;
    }
    
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
    self.middleGradientLayer.frame = middleView.bounds;
    
    [self.middleBaseView bringSubviewToFront:self.middleView];
    
    rightFrame.origin = CGPointMake(middleFrame.size.width, 0);
    rightView.frame = rightFrame;
}

@end
