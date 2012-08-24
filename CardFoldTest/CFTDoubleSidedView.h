//
//  CFTDoubleSidedView.h
//  CardFoldTest
//
//  Created by Aqeel Gunja on 8/24/12.
//  Copyright (c) 2012 Aqeel Gunja. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CFTDoubleSidedView : UIView

@property (nonatomic, strong) UIView *frontView;
@property (nonatomic, strong) UIView *backView;

@end
