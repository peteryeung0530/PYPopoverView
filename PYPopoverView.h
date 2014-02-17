//
//  PYPopoverView.h
//  Popover
//
//  Created by Peter Yeung on 2014-02-16.
//  Copyright (c) 2014 Peter Yeung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PYPopoverView : UIView

@property (nonatomic,strong) NSString* text;
@property (nonatomic,strong) UILabel* textLabel;
@property (nonatomic,strong) UIColor* borderColor;
@property (nonatomic,assign) CGFloat borderRadius;

- (id)initWithFrame:(CGRect)frame andText:(NSString*)text;

@end
