//
//  YXClickTextView.m
//  Forst
//
//  Created by yunxin bai on 2018/6/26.
//  Copyright © 2018 yunxin bai. All rights reserved.
//

#import "YXClickTextView.h"

@interface YXClickTextModel : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) NSRange range;
@property (nonatomic, copy) YXClickTextBlock textBlock;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIFont *font;

@end

@implementation YXClickTextModel
@end


@interface YXClickTextView ()

@property (nonatomic, strong) NSMutableArray *textArrayM;
@property (nonatomic, strong) YXClickTextModel *model;

@end

@implementation YXClickTextView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.editable = NO;
        self.scrollEnabled = NO;
        self.textContainerInset = UIEdgeInsetsZero;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.textContainer.lineFragmentPadding = 0;
        self.selectable = NO;
        
        _autoHeight = YES;
        _autoWidth = NO;
    }
    return self;
}

#pragma mark - override
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSUInteger location = [self characterIndexAtLocation:[touches.anyObject locationInView:self]];
    if (location == NSNotFound) {
        return [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSUInteger location = [self characterIndexAtLocation:[touches.anyObject locationInView:self]];
    if (location == NSNotFound) {
        return [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self shouldCallBack];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self shouldCallBack];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (newSuperview) {
        UIView *hoderView = [newSuperview viewWithTag:10086];
        if (!hoderView) {
            hoderView = [[UIView alloc] init];
            hoderView.tag = 10086;
            [newSuperview addSubview:hoderView];
        }
    }
}

#pragma mark - private
- (NSUInteger)characterIndexAtLocation:(CGPoint)point {
    NSUInteger index = [self.layoutManager glyphIndexForPoint:point inTextContainer:self.textContainer];
    CGRect rect = [self.layoutManager boundingRectForGlyphRange:NSMakeRange(index, 1) inTextContainer:self.textContainer];
    
    YXClickTextModel *selectModel = nil;
    if (CGRectContainsPoint(rect, point)) {
        for (YXClickTextModel *model in self.textArrayM) {
            if (index >= model.range.location && index < model.range.location + model.range.length) {
                selectModel = model;
                break;
            }
        }
    }
    if (selectModel) {
        self.model = selectModel;
    }else {
        self.model = nil;
    }
    if (_highlightedBackgroundColor) {
        [self changeClickTextBackgroundColor:self.backgroundColor type:0];
    }

    return NSNotFound;
}

- (void)shouldCallBack {
    if (_model.textBlock) {
        _model.textBlock(_model.text, _model.range);
    }
    if (_model && _yxDelegate && [_yxDelegate respondsToSelector:@selector(clickTextView:didClickedText:range:)]) {
        [_yxDelegate clickTextView:self didClickedText:_model.text range:_model.range];
    }
    _model = nil;
}

- (void)allRangeOfText:(NSString *)text inText:(NSString *)theText callBack:(YXClickTextBlock)callback {
    NSRange range = [theText rangeOfString:text];
    while (range.location != NSNotFound) {
        YXClickTextModel *model = [YXClickTextModel new];
        model.text = text;
        model.range = range;
        model.textBlock = callback;
        [self.textArrayM addObject:model];
        NSUInteger length = range.location + range.length;
        range = [theText rangeOfString:text options:kNilOptions range:NSMakeRange(length, theText.length - length)];
    }
}

- (void)changeClickTextBackgroundColor:(UIColor *)bgcolor type:(NSInteger)type {
    if (bgcolor == nil) {
        bgcolor = [UIColor clearColor];
    }
    if (_model) {
        NSMutableAttributedString *mastring = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText?:[[NSAttributedString alloc] initWithString:self.text]];
        if (type == 0) {
            [mastring addAttribute:NSBackgroundColorAttributeName value:bgcolor range:_model.range];
        }else if (type == 1) {
            [mastring removeAttribute:NSBackgroundColorAttributeName range:_model.range];
        }
        self.attributedText = mastring;
    }
}

#pragma mark - public method
- (void)addClickTexts:(NSArray *)texts callback:(YXClickTextBlock)callback {
    NSString *theText = self.text;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if (texts && callback) {
            for (NSString *text in texts) {
                if (text.length == 0) {
                    continue;
                }
                [self allRangeOfText:text inText:theText callBack:callback];
            }
        }
    });
}

- (void)addClickTexts:(NSArray *)texts {
    [self addClickTexts:texts callback:nil];
}

- (void)removeClickText:(NSArray *)texts {
    NSMutableArray *marr = @[].mutableCopy;
    for (NSString *text in texts) {
        if (text.length == 0) {
            continue;
        }
        for (YXClickTextModel *model in _textArrayM) {
            if ([model.text isEqualToString:text]) {
                [marr addObject:model];
            }
        }
    }
    [self.textArrayM removeObjectsInArray:marr];
}

- (void)removeAllClickText {
    [self.textArrayM removeAllObjects];
}

#pragma mark - setters and getters
- (NSMutableArray *)textArrayM {
    if (!_textArrayM) {
        _textArrayM = [NSMutableArray array];
    }
    return _textArrayM;
}

- (void)setText:(NSString *)text {
    [super setText:text];
    if (_autoWidth && _autoHeight) {
        [self sizeToFit];
    }else if (_autoHeight) {
        CGSize size = [self sizeThatFits:self.bounds.size];
        CGRect frame = self.frame;
        frame.size.height = size.height;
        self.frame = frame;
    }else if (_autoWidth) {
        CGSize size = [self sizeThatFits:self.bounds.size];
        CGRect frame = self.frame;
        frame.size.width = size.width;
        self.frame = frame;
    }
}
@end
