//
//  ABPPamphletView.h
//  CardFoldTest
//
//  Created by Aqeel Gunja on 8/23/12.
//  Copyright (c) 2012 Aqeel Gunja. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ABPTransformView;

@interface ABPPamphletView : UIView

@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *middleView;
@property (nonatomic, strong) UIView *rightView;

@property (nonatomic, strong) ABPTransformView *middleBaseView;

@property (nonatomic, assign, getter=isOpen) BOOL open;

@end
