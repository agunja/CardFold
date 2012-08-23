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

@property (nonatomic, strong) ABPTransformView *middleBaseView;

@end

@implementation ABPPamphletView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
}

- (void)setLeftView:(UIView *)leftView
{
    [_leftView removeFromSuperview];
    _leftView = leftView;
}


@end
