//
//  PYPopoverView.m
//  Popover
//
//  Created by Peter Yeung on 2014-02-16.
//  Copyright (c) 2014 Peter Yeung. All rights reserved.
//

#import "PYPopoverView.h"

static const CGFloat kTextLabelHorizontalPadding     = 20.0f;
static const CGFloat kTextLabelVerticalPadding       = 20.0f;
static const CGFloat kTextLabelHeight                = 20.0f;
static const CGFloat kPopoverBorderHorizontalPadding = 10.0f;
static const CGFloat kPopoverBorderVerticalPadding   = 10.0f;
static const CGFloat kPopoverTriangleOffset          = 30.0f;
static const CGFloat kPopoverTriangleHeight          = 6.0f;
static const CGFloat kPopoverTriangleWidth           = 12.0f;

@interface PYPopoverView ()

@end

@implementation PYPopoverView

- (id)initWithFrame:(CGRect)frame andText:(NSString*)text
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _text = text;
        [self configureView];

    }
    return self;
}

- (void)layoutSubviews
{
    //update the popover view to the new size based on the length of the text
    CGRect rect = self.frame;
    rect.size.width = self.textLabel.frame.size.width + 2*kTextLabelHorizontalPadding;
    rect.size.height = self.textLabel.frame.size.height + 2*kTextLabelVerticalPadding;
    rect.origin.x = self.frame.origin.x - (rect.size.width - kPopoverBorderHorizontalPadding - kPopoverTriangleOffset + (kPopoverTriangleWidth/2));
    rect.origin.y = self.frame.origin.y - (rect.size.height - kPopoverBorderVerticalPadding + kPopoverTriangleHeight);
    self.frame = rect;
}

- (void)configureView
{
    //text size
    CGSize textSize = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, CGFLOAT_MAX) options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0f]} context:nil].size;
    
    //setup label
    self.textLabel = [[UILabel alloc]initWithFrame:CGRectMake(kTextLabelHorizontalPadding, kTextLabelVerticalPadding, textSize.width, textSize.height)];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.text = self.text;
    self.textLabel.numberOfLines = 0;
    self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.textLabel.font = [UIFont systemFontOfSize:11.0f];
    [self addSubview:self.textLabel];
    [self setNeedsLayout];
    self.backgroundColor = [UIColor clearColor];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGRect borderRect = CGRectMake(self.bounds.origin.x + kPopoverBorderHorizontalPadding, self.bounds.origin.y + kPopoverBorderVerticalPadding, self.frame.size.width - 2*kPopoverBorderHorizontalPadding, self.frame.size.height - 2*kPopoverBorderVerticalPadding);
    CGFloat radius = self.borderRadius;
    
    // Drawing code for the popover view
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //starting from top left corner
    CGContextMoveToPoint(context, borderRect.origin.x, borderRect.origin.y + radius);
    
    //draw down to bottom left corner
    CGContextAddLineToPoint(context, borderRect.origin.x, borderRect.origin.y + borderRect.size.height - radius);
    CGContextAddArc(context, borderRect.origin.x + radius, borderRect.origin.y + borderRect.size.height - radius,
                    radius, M_PI, M_PI / 2, 1);
    
    //draw right until needs to draw triangle
    CGContextAddLineToPoint(context, borderRect.origin.x + borderRect.size.width - kPopoverTriangleOffset,
                            borderRect.origin.y + borderRect.size.height);
    //draw triangle
    CGContextAddLineToPoint(context, borderRect.origin.x + borderRect.size.width - kPopoverTriangleOffset + (kPopoverTriangleWidth/2), borderRect.origin.y + borderRect.size.height + kPopoverTriangleHeight);
    CGContextAddLineToPoint(context, borderRect.origin.x + borderRect.size.width - kPopoverTriangleOffset + kPopoverTriangleWidth, borderRect.origin.y + borderRect.size.height);
    
    //draw right to bottom right corner
    CGContextAddLineToPoint(context, borderRect.origin.x + borderRect.size.width - radius, borderRect.origin.y + borderRect.size.height);
    CGContextAddArc(context, borderRect.origin.x + borderRect.size.width - radius,
                    borderRect.origin.y + borderRect.size.height - radius, radius, M_PI / 2, 0.0f, 1);
    
    //draw up to upper right corner
    CGContextAddLineToPoint(context, borderRect.origin.x + borderRect.size.width, borderRect.origin.y + radius);
    CGContextAddArc(context, borderRect.origin.x + borderRect.size.width - radius, borderRect.origin.y + radius,
                    radius, 0.0f, -M_PI / 2, 1);
    
    //draw left to upper left corner
    CGContextAddLineToPoint(context, borderRect.origin.x + radius, borderRect.origin.y);
    CGContextAddArc(context, borderRect.origin.x + radius, borderRect.origin.y + radius, radius,
                    -M_PI / 2, M_PI, 1);
    
    CGContextSetStrokeColorWithColor(context, self.borderColor.CGColor);
    CGContextSetFillColorWithColor(context, self.popoverBackgroundColor.CGColor);
    CGContextDrawPath(context, kCGPathFillStroke);
}

@end
