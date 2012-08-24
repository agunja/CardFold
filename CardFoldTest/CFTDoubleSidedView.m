//
//  CFTDoubleSidedView.m
//  CardFoldTest
//
//  Created by Aqeel Gunja on 8/24/12.
//  Copyright (c) 2012 Aqeel Gunja. All rights reserved.
//

#import "CFTDoubleSidedView.h"

@implementation CFTDoubleSidedView

+ (Class)layerClass
{
    return [CATransformLayer class];
}

- (void)setBackView:(UIView *)backView
{
    [_backView removeFromSuperview];
    _backView = backView;
    [self addSubview:_backView];
    CALayer *backLayer = _backView.layer;
    backLayer.doubleSided = NO;
    backLayer.anchorPoint = CGPointMake(0.0, 0.5);
    backLayer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
}

- (void)setFrontView:(UIView *)frontView
{
    [_frontView removeFromSuperview];
    _frontView = frontView;
    [self addSubview:_frontView];
    _frontView.layer.doubleSided = NO;
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGRect selfRect = CGRectIntersection(self.frontView.bounds, self.backView.bounds);
    return selfRect.size;
}

- (void)layoutSubviews
{
    CGRect frontFrame = self.frontView.frame;
    frontFrame.origin = CGPointZero;
    self.frontView.frame = frontFrame;
    
    CGRect backFrame = self.backView.frame;
    backFrame.origin = CGPointMake(frontFrame.size.width, 0);
    self.backView.frame = backFrame;
    
    [self bringSubviewToFront:self.frontView];
}

@end
