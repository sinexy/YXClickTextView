//
//  YXClickTextView.h
//  Forst
//
//  Created by yunxin bai on 2018/6/26.
//  Copyright © 2018 yunxin bai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXKitAssist.h"

@class YXClickTextView;

@protocol YXClickTextViewDelegate <NSObject>

@optional
- (void)clickTextView:(YXClickTextView *)clickTextView didClickedText:(NSString *)text range:(NSRange)range;

@end

typedef void(^YXClickTextBlock)(NSString *text, NSRange range);

@interface YXClickTextView : UITextView

@property (nonatomic, weak) id<YXClickTextViewDelegate> yxDelegate;

@property (nonatomic, assign) BOOL autoHeight;

@property (nonatomic,  assign) BOOL  autoWidth;

@property (nonatomic,  strong) UIColor *highlightedBackgroundColor;

- (void)addClickTexts:(NSArray *)texts callback:(YXClickTextBlock)callback;

- (void)addClickTexts:(NSArray *)texts;

- (void)removeClickText:(NSArray *)texts;

- (void)removeAllClickText;

@end

