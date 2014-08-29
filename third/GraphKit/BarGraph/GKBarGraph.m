//
//  GKBarGraph.m
//  GraphKit
//
//  Copyright (c) 2014 Michal Konturek
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "GKBarGraph.h"

#import "FrameAccessor.h"
#import "NSArray+MK.h"

#import "GKBar.h"
#import "NJDBezierCurve.h"
#import "NumberJumpTextLayer.h"
#import "UIColor+GraphKit.h"

static CGFloat kDefaultBarHeight = 180;
static CGFloat kDefaultBarWidth = 22;
static CGFloat kDefaultBarMargin = 20;
static CGFloat kDefaultLabelWidth = 40;
static CGFloat kDefaultLabelHeight = 15;

static CGFloat kDefaultAnimationDuration = 2.0;

@implementation GKBarGraph

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _init];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _init];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)_init {
    self.animationDuration = kDefaultAnimationDuration;
    self.barHeight = kDefaultBarHeight;
    self.barWidth = kDefaultBarWidth;
    self.marginBar = kDefaultBarMargin;
    
    self.contentView = [[UIScrollView alloc]initWithFrame:self.bounds];
    self.contentView.showsHorizontalScrollIndicator = NO;
    self.contentView.delegate = self;
    self.contentView.bounces = YES;
    self.contentView.backgroundColor = [UIColor gk_cloudsColor];
    [self.contentView setContentSize:CGSizeMake(self.contentView.frame.size.width, self.contentView.bounds.size.height)];
    [self.contentView setContentOffset:CGPointZero];
    [self addSubview:self.contentView];
}

- (void)setAnimated:(BOOL)animated {
    _animated = animated;
    [self.bars mk_each:^(GKBar *item) {
        item.animated = animated;
    }];
}

- (void)setAnimationDuration:(CFTimeInterval)animationDuration {
    _animationDuration = animationDuration;
    [self.bars mk_each:^(GKBar *item) {
        item.animationDuration = animationDuration;
    }];
}

- (void)setBarColor:(UIColor *)color {
    _barColor = color;
    [self.bars mk_each:^(GKBar *item) {
        item.foregroundColor = color;
    }];
}

- (void)draw {
    [self _construct];
    [self _drawBars];
}

- (void)_construct {
    NSAssert(self.dataSource, @"GKBarGraph : No data source is assgined.");

    if ([self _hasBars]) [self _removeBars];
    if ([self _hasLabels]) [self _removeLabels];
    if ([self _hasValues]) {
        [self _removeValues];
    }
    
    [self _constructBars];
    [self _constructLabels];
    [self _constructValues];
    
    [self _positionBars];
    [self _positionLabels];
    [self _positionValues];
    
//     [self.contentView setContentOffset:CGPointZero];
    
}

- (BOOL)_hasBars {
    return ![self.bars mk_isEmpty];
}

- (void)_constructBars {
    NSInteger count = [self.dataSource numberOfBars];
    id items = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger idx = 0; idx < count; idx++) {
        GKBar *item = [GKBar create];
        if ([self barColor]) item.foregroundColor = [self barColor];
        [items addObject:item];
    }
    self.bars = items;
}

- (void)_removeBars {
    [self.bars mk_each:^(id item) {
        [item removeFromSuperview];
    }];
}

- (void)_positionBars {
    CGFloat y = kDefaultLabelHeight;

    __block CGFloat x = [self _barStartX];
    __block CGFloat contentWidth = 0;
    [self.bars mk_each:^(GKBar *item) {
        item.frame = CGRectMake(x, y, _barWidth, _barHeight);
        [self.contentView addSubview:item];
        x += [self _barSpace];
        contentWidth = item.frame.origin.x + item.frame.size.width;
    }];
    
    [self.contentView setContentSize:CGSizeMake(contentWidth + 20, 0)];

   
}

- (CGFloat)_barStartX {
    CGFloat result = self.width;
    CGFloat item = [self _barSpace];
    NSInteger count = [self.dataSource numberOfBars];
    
    result = result - (item * count) + self.marginBar;
    result = (result / 2);
    return result;
}

- (CGFloat)_barSpace {
    return (self.barWidth + self.marginBar);
}

- (CGFloat)_barStartY {
    return (self.height - self.barHeight - kDefaultLabelHeight);
}

- (BOOL)_hasLabels {
    return ![self.labels mk_isEmpty];
}

- (void)_constructLabels {
    
    NSInteger count = [self.dataSource numberOfBars];
    id items = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger idx = 0; idx < count; idx++) {
        
        CGRect frame = CGRectMake(0, 0, kDefaultLabelWidth, kDefaultLabelHeight);
        UILabel *item = [[UILabel alloc] initWithFrame:frame];
        item.textAlignment = NSTextAlignmentCenter;
        item.font = [UIFont boldSystemFontOfSize:13];
        item.textColor = [UIColor lightGrayColor];
        item.text = [self.dataSource titleForBarAtIndex:idx];
        
        [items addObject:item];
    }
    self.labels = items;
}

- (void)_removeLabels {
    [self.labels mk_each:^(id item) {
        [item removeFromSuperview];
    }];
}

- (void)_positionLabels {

    __block NSInteger idx = 0;
    [self.bars mk_each:^(GKBar *bar) {
        
        CGFloat labelWidth = kDefaultLabelWidth;
        CGFloat labelHeight = kDefaultLabelHeight;
        CGFloat startX = bar.x - ((labelWidth - self.barWidth) / 2);
        CGFloat startY = labelHeight + kDefaultBarHeight;
        
        UILabel *label = [self.labels objectAtIndex:idx];
        label.x = startX;
        label.y = startY;
        
        [self.contentView addSubview:label];
        
        idx++;
    }];
}

- (BOOL)_hasValues {
    return ![self.values mk_isEmpty];
}

- (void)_constructValues {
    
    NSInteger count = [self.dataSource numberOfBars];
    id items = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger idx = 0; idx < count; idx++) {
        
        CGRect frame = CGRectMake(0, 0, kDefaultLabelWidth, kDefaultLabelHeight);
        NumberJumpTextLayer *textLayer = [[NumberJumpTextLayer alloc] init];
        textLayer.frame = frame;
        textLayer.foregroundColor = [[UIColor lightGrayColor] CGColor];
        textLayer.alignmentMode = kCAAlignmentCenter;
        textLayer.font = (__bridge CFTypeRef)([UIFont boldSystemFontOfSize:11]);
        textLayer.fontSize = 11;
        textLayer.string = [[self.dataSource valueForBarAtIndex:idx] stringValue];
        [items addObject:textLayer];
    }
    self.values = items;
}

- (void)_removeValues {
    [self.values mk_each:^(id item) {
        [item removeFromSuperlayer];
    }];
}

- (void)_positionValues {
   __block NumberJumpTextLayer *label;
    __block NSInteger idx = 0;
    [self.bars mk_each:^(GKBar *bar) {
        
        CGFloat labelWidth = kDefaultLabelWidth;
//        CGFloat labelHeight = kDefaultLabelHeight;
        CGFloat startX = bar.x - ((labelWidth - self.barWidth) / 2);
        CGFloat startY = 0;
        
        label = [self.values objectAtIndex:idx];
        label.frame = CGRectMake(startX, startY, label.frame.size.width, label.frame.size.height);
        
        [self.contentView.layer addSublayer:label];
        [label jumpNumberWithDuration:2 fromNumber:0 toNumber:[label.string integerValue]];
        idx++;
    }];
}

- (void)_drawBars {
    __block NSInteger idx = 0;
    id source = self.dataSource;
    [self.bars mk_each:^(GKBar *item) {
        
        if ([source respondsToSelector:@selector(animationDurationForBarAtIndex:)]) {
            item.animationDuration = [source animationDurationForBarAtIndex:idx];
        }
        
        if ([source respondsToSelector:@selector(colorForBarAtIndex:)]) {
            item.foregroundColor = [source colorForBarAtIndex:idx];
        }
        
        if ([source respondsToSelector:@selector(colorForBarBackgroundAtIndex:)]) {
            item.backgroundColor = [source colorForBarBackgroundAtIndex:idx];
        }
        
        item.percentage = [[source valueForBarAtIndex:idx] doubleValue];
        idx++;
    }];
}

- (void)reset {
    [self.bars mk_each:^(GKBar *item) {
        [item reset];
    }];
}

#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
//    [self.contentView setContentOffset:CGPointMake(scrollView.contentOffsetX,0)];
    
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
}

@end
