//
//  YXKitAssist.m
//  YXKit
//
//  Created by yunxin bai on 2017/8/18.
//  Copyright © 2017 yunxin bai. All rights reserved.
//

#import "YXKitAssist.h"
#import <objc/runtime.h>

#define YXKitAssist_imp(sel,imp) \
- (YXKitAssist*(^)(id))sel{ \
    return ^id(id sel){ \
        UIView *view = self.view; \
        do { \
            imp; \
        } while (0); \
        return view.yxkit_assist; \
    }; \
}


@interface YXKitAssist ()

@property (nonatomic, weak) UIView *view;

@end

@implementation YXKitAssist

#pragma mark - UIView

YXKitAssist_imp(tag, ({
    if ([tag isKindOfClass:[NSNumber class]]) {
        view.tag = [tag integerValue];
    }
}))

YXKitAssist_imp(frame, ({
    if ([frame isKindOfClass:[NSValue class]]) {
        view.frame = [frame CGRectValue];
    }
}))

YXKitAssist_imp(alpha, ({
    if ([alpha isKindOfClass:[NSNumber class]]) {
        view.alpha = [alpha floatValue];
    }
}))

YXKitAssist_imp(bgColor, ({
    view.backgroundColor = [UIColor kitAssist:bgColor];
}))

YXKitAssist_imp(bdColor, ({
    view.layer.borderColor = [[UIColor kitAssist:bdColor] CGColor];
}))

YXKitAssist_imp(bdWidth, ({
    if([bdWidth isKindOfClass:[NSNumber class]]){
        view.layer.borderWidth = [bdWidth floatValue];
    }
}))

YXKitAssist_imp(cnRadius, ({
    if([cnRadius isKindOfClass:[NSNumber class]]){
        view.layer.cornerRadius = [cnRadius floatValue];
    }
}))

YXKitAssist_imp(mtBounds, ({
    if([mtBounds isKindOfClass:[NSNumber class]]){
        view.layer.masksToBounds = [mtBounds boolValue];
    }
}))

#pragma mark - UILabel & UITextView & UITextField


YXKitAssist_imp(text, ({
    if([text isKindOfClass:[NSString class]]){
        if ([view respondsToSelector:@selector(setText:)]) {
            [view performSelector:@selector(setText:) withObject:text];
        }
    }
}))

YXKitAssist_imp(font, ({
    if ([font isKindOfClass:[UIFont class]]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            button.titleLabel.font = font;
        }else if ([view respondsToSelector:@selector(setFont:)]) {
            [view performSelector:@selector(setFont:) withObject:font];
        }
    }
}))

YXKitAssist_imp(color, ({
    if([view respondsToSelector:@selector(setTextColor:)]){
        [view performSelector:@selector(setTextColor:) withObject:[UIColor kitAssist:color]];
    }
}))

YXKitAssist_imp(align, ({
    if([align isKindOfClass:[NSNumber class]]){
        if([view respondsToSelector:@selector(setTextAlignment:)]){
            [view performSelector:@selector(setTextAlignment:) withObject:align];
        }
    }
}))

YXKitAssist_imp(lines, ({
    if([view isKindOfClass:[UILabel class]] &&
       [lines isKindOfClass:[NSNumber class]]){
        [(UILabel *)view setNumberOfLines:[lines integerValue]];
    }
}))

YXKitAssist_imp(adjust, ({
    if([view isKindOfClass:[UILabel class]] &&
       [adjust isKindOfClass:[NSNumber class]]){
        [(UILabel *)view setNumberOfLines:[adjust boolValue]];
    }
}))

YXKitAssist_imp(lineSpace, ({
    if([view isKindOfClass:[UILabel class]] &&
       [lineSpace isKindOfClass:[NSNumber class]]){
        UILabel *label = (UILabel *)view;
        CGFloat space = [lineSpace floatValue];
        
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:label.attributedText?:[[NSAttributedString alloc] initWithString:label.text]];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:space < 0 ? 0 : space];
        paragraphStyle.alignment = label.textAlignment;
        [attStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [label.text length])];
        label.attributedText = attStr;
    }
}))

YXKitAssist_imp(autoWidth, ({
    if([view isKindOfClass:[UILabel class]]){
        
        UILabel *label = (UILabel *)view;
        
        CGRect frame = label.frame;
        label.numberOfLines = 1;
        [label sizeToFit];
        
        if ([autoWidth floatValue] > 0 &&
            label.frame.size.width > [autoWidth floatValue])
        {
            frame.size.width = [autoWidth floatValue];
        }else{
            frame.size.width = label.frame.size.width;
        }
        label.frame = frame;
    }
}))

YXKitAssist_imp(autoHeight, ({
    if([view isKindOfClass:[UILabel class]]){
        
        UILabel *label = (UILabel *)view;
        
        CGRect frame = label.frame;
        label.numberOfLines = 0;
        [label sizeToFit];
        
        if ([autoHeight floatValue] > 0 &&
            label.frame.size.height > [autoHeight floatValue]) {
            frame.size.height = [autoHeight floatValue];
        }else{
            frame.size.height = label.frame.size.height;
        }
        label.frame = frame;
    }
}))

- (YXKitAssist*(^)(id,id))attributedSubstring{
    return ^id(id string, id value){
        UIView *view = self.view;
        
        if ([view respondsToSelector:@selector(attributedText)]) {
            
            NSString *text = [view performSelector:@selector(text)];
            NSAttributedString *attributedText = [view performSelector:@selector(attributedText)];
            if (!attributedText) {
                attributedText = [[NSAttributedString alloc] initWithString:text];
            }
            
            // color
            if ([value isKindOfClass:[UIColor class]]) {
                NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:attributedText];
                [attStr addAttribute:NSForegroundColorAttributeName value:value range:[text rangeOfString:string]];
                [view performSelector:@selector(setAttributedText:) withObject:attStr];
            }
            // font
            else if ([value isKindOfClass:[UIFont class]]){
                NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:attributedText];
                [attStr addAttribute:NSFontAttributeName value:value range:[text rangeOfString:string]];
                [view performSelector:@selector(setAttributedText:) withObject:attStr];
            }
        }
        
        return view.yxkit_assist;
    };
}


- (YXKitAssist*(^)(id,id,id))attributedSubstringInRange{
    return ^id(id string, id value, id range){
        UIView *view = self.view;
        
        if ([view respondsToSelector:@selector(attributedText)]) {
            
            NSString *text = [view performSelector:@selector(text)];
            NSAttributedString *attributedText = [view performSelector:@selector(attributedText)];
            if (!attributedText) {
                attributedText = [[NSAttributedString alloc] initWithString:text];
            }
            
            // color
            if ([value isKindOfClass:[UIColor class]] &&
                [range isKindOfClass:[NSValue class]]) {
                NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:attributedText];
                [attStr addAttribute:NSForegroundColorAttributeName value:value range:[range rangeValue]];
                [view performSelector:@selector(setAttributedText:) withObject:attStr];
            }
            // font
            else if ([value isKindOfClass:[UIFont class]] &&
                     [range isKindOfClass:[NSValue class]]){
                NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:attributedText];
                [attStr addAttribute:NSFontAttributeName value:value range:[range rangeValue]];
                [view performSelector:@selector(setAttributedText:) withObject:attStr];
            }
        }
        
        return view.yxkit_assist;
    };
}



#pragma mark - UIButton

- (YXKitAssist*(^)(id,id))titleForState{
    return ^id(id title, id state){
        UIView *view = self.view;
        
        if ([view isKindOfClass:[UIButton class]] &&
            [title isKindOfClass:[NSString class]] &&
            [state isKindOfClass:[NSNumber class]]) {
            [(UIButton *)view setTitle:title forState:[state integerValue]];
        }
        
        return view.yxkit_assist;
    };
}

- (YXKitAssist*(^)(id,id))colorForState{
    return ^id(id color, id state){
        UIView *view = self.view;
        
        if ([view isKindOfClass:[UIButton class]]&&
            [state isKindOfClass:[NSNumber class]]) {
            [(UIButton *)view setTitleColor:[UIColor kitAssist:color] forState:[state integerValue]];
        }
        
        return view.yxkit_assist;
    };
}

- (YXKitAssist*(^)(id,id))imageForState{
    return ^id(id image, id state){
        UIView *view = self.view;
        
        if ([view isKindOfClass:[UIButton class]] &&
            [image isKindOfClass:[NSString class]] &&
            [state isKindOfClass:[NSNumber class]]) {
            [(UIButton *)view setImage:image forState:[state integerValue]];
        }
        
        return view.yxkit_assist;
    };
}

- (YXKitAssist*(^)(id,id))bgImageForState{
    return ^id(id bgImage, id state){
        UIView *view = self.view;
        
        if ([view isKindOfClass:[UIButton class]] &&
            [bgImage isKindOfClass:[NSString class]] &&
            [state isKindOfClass:[NSNumber class]]) {
            [(UIButton *)view setBackgroundImage:bgImage forState:[state integerValue]];
        }
        
        return view.yxkit_assist;
    };
}

- (YXKitAssist*(^)(id,id))lineSpaceForState{
    return ^id(id lineSpace, id state){
        UIView *view = self.view;
        
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            CGFloat space = [lineSpace integerValue];
            
            NSAttributedString *attributedString = [button attributedTitleForState:[state integerValue]]?:[[NSAttributedString alloc] initWithString:button.currentTitle];
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:attributedString];
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle setLineSpacing:space < 0 ? 0 : space];
            paragraphStyle.alignment = button.titleLabel.textAlignment;
            [attStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [button.currentAttributedTitle.string length])];
            [button setAttributedTitle:attStr forState:[state integerValue]];
        }
        
        return view.yxkit_assist;
    };
}

- (YXKitAssist*(^)(id))imageUpTitleDown{
    return ^id(id offsetY){
        UIView *view = self.view;
        
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            CGFloat Y = [offsetY floatValue];
            
            [button layoutSubviews];
            [button setImageEdgeInsets:UIEdgeInsetsMake(-button.titleLabel.intrinsicContentSize.height-Y,0,0,-button.titleLabel.intrinsicContentSize.width)];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0,-CGRectGetWidth(button.imageView.frame),-CGRectGetHeight(button.imageView.frame)-Y,0)];
            
        }
        
        return view.yxkit_assist;
    };
}

- (YXKitAssist*(^)(id))imageDownTitleUp{
    return ^id(id offsetY){
        UIView *view = self.view;
        
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            CGFloat Y = [offsetY floatValue];
            
            [button layoutSubviews];
            [button setImageEdgeInsets:UIEdgeInsetsMake(button.titleLabel.intrinsicContentSize.height+Y,0,0,-button.titleLabel.intrinsicContentSize.width)];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(-CGRectGetWidth(button.imageView.frame)-Y,-CGRectGetWidth(button.imageView.frame),0,0)];
            
        }
        
        return view.yxkit_assist;
    };
}

- (YXKitAssist*(^)(id))imageRightTitleLeft{
    return ^id(id offsetX){
        UIView *view = self.view;
        
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            CGFloat X = [offsetX floatValue];
            
            [button layoutSubviews];
            [button setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,-button.titleLabel.intrinsicContentSize.width*2-X)];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0,-button.imageView.frame.size.width*2-X,0,0)];
            
        }
        
        return view.yxkit_assist;
    };
}

- (YXKitAssist*(^)(id))imageLeftTitleRight{
    return ^id(id offsetX){
        UIView *view = self.view;
        
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            CGFloat X = [offsetX floatValue];
            
            [button layoutSubviews];
            [button setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,X)];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0,X,0,0)];
            
        }
        
        return view.yxkit_assist;
    };
}

- (YXKitAssist*(^)(void))imageCenterTitleCenter{
    return ^id(){
        UIView *view = self.view;
        
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            
            [button layoutSubviews];
            [button setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,-button.titleLabel.intrinsicContentSize.width)];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0,-button.imageView.frame.size.width,0,0)];
            
        }
        
        return view.yxkit_assist;
    };
}

- (YXKitAssist*(^)(id,id,id))attributedSubstringForState{
    return ^id(id substring, id value, id state){
        UIView *view = self.view;
        
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            
            // color
            if ([value isKindOfClass:[UIColor class]]) {
                NSAttributedString *attributedString = [button attributedTitleForState:[state integerValue]]?:[[NSAttributedString alloc] initWithString:button.currentTitle];
                NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:attributedString];
                [attStr addAttribute:NSForegroundColorAttributeName value:value range:[attributedString.string rangeOfString:substring]];
                [button setAttributedTitle:attStr forState:[state integerValue]];
            }
            // font
            else if ([value isKindOfClass:[UIFont class]]){
                NSAttributedString *attributedString = [button attributedTitleForState:[state integerValue]]?:[[NSAttributedString alloc] initWithString:button.currentTitle];
                NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:attributedString];
                [attStr addAttribute:NSFontAttributeName value:value range:[attributedString.string rangeOfString:substring]];
                [button setAttributedTitle:attStr forState:[state integerValue]];
            }
        }
        
        return view.yxkit_assist;
    };
}

- (YXKitAssist*(^)(id,id,id,id))attributedSubstringInRangeForState{
    return ^id(id substring, id value, id range, id state){
        UIView *view = self.view;
        
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            
            // color
            if ([value isKindOfClass:[UIColor class]] &&
                [range isKindOfClass:[NSValue class]]) {
                NSAttributedString *attributedString = [button attributedTitleForState:[state integerValue]]?:[[NSAttributedString alloc] initWithString:button.currentTitle];
                NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:attributedString];
                [attStr addAttribute:NSForegroundColorAttributeName value:value range:[range rangeValue]];
                [button setAttributedTitle:attStr forState:[state integerValue]];
            }
            // font
            else if ([value isKindOfClass:[UIFont class]] &&
                     [range isKindOfClass:[NSValue class]]){
                NSAttributedString *attributedString = [button attributedTitleForState:[state integerValue]]?:[[NSAttributedString alloc] initWithString:button.currentTitle];
                NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:attributedString];
                [attStr addAttribute:NSFontAttributeName value:value range:[range rangeValue]];
                [button setAttributedTitle:attStr forState:[state integerValue]];
            }
        }
        
        return view.yxkit_assist;
    };
}

#pragma mark - UIImageView

YXKitAssist_imp(image, ({
    if ([view isKindOfClass:[UIImageView class]]) {
        if ([image isKindOfClass:[NSString class]]) {
            [view performSelector:@selector(setImage:) withObject:[UIImage imageNamed:image]];
        }else if ([image isKindOfClass:[UIImage class]]){
            [view performSelector:@selector(setImage:) withObject:image];
        }
    }
}))

- (YXKitAssist*(^)(id,id))imageForTintColor{
    return ^id(id image, id color){
        UIView *view = self.view;
        
        if ([view isKindOfClass:[UIImageView class]]) {
            UIImageView *imageView = (UIImageView *)view;
            imageView.tintColor = [UIColor kitAssist:color];
            
            if ([image isKindOfClass:[NSString class]]) {
                imageView.image = [[UIImage imageNamed:image]
                                   imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            }else if ([image isKindOfClass:[UIImage class]]){
                imageView.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            }
        }
        
        return view.yxkit_assist;
    };
}


#pragma mark - UITextField

YXKitAssist_imp(bdStyle, ({
    if ([view isKindOfClass:[UITextField class]] &&
        [bdStyle isKindOfClass:[NSNumber class]]) {
        [view performSelector:@selector(setBorderStyle:) withObject:bdStyle];
    }
}))

YXKitAssist_imp(pHolder, ({
    if ([view isKindOfClass:[UITextField class]] &&
        [pHolder isKindOfClass:[NSString class]]) {
        [view performSelector:@selector(setPlaceholder:) withObject:pHolder];
    }
}))

YXKitAssist_imp(pHColor, ({
    if ([view isKindOfClass:[UITextField class]]) {
        [view setValue:[UIColor kitAssist:pHColor] forKeyPath:@"_placeholderLabel.textColor"];
    }
}))

YXKitAssist_imp(pHFont, ({
    if ([view isKindOfClass:[UITextField class]] &&
        [pHFont isKindOfClass:[UIFont class]]) {
        [self setValue:pHFont forKeyPath:@"_placeholderLabel.font"];
    }
}))

YXKitAssist_imp(cbMode, ({
    if ([view isKindOfClass:[UITextField class]] &&
        [cbMode isKindOfClass:[NSNumber class]]) {
        [view performSelector:@selector(setClearButtonMode:) withObject:cbMode];
    }
}))

YXKitAssist_imp(lvMode, ({
    if ([view isKindOfClass:[UITextField class]] &&
        [lvMode isKindOfClass:[NSNumber class]]) {
        [view performSelector:@selector(setLeftViewMode:) withObject:lvMode];
    }
}))

YXKitAssist_imp(rvMode, ({
    if ([view isKindOfClass:[UITextField class]] &&
        [rvMode isKindOfClass:[NSNumber class]]) {
        [view performSelector:@selector(setRightViewMode:) withObject:rvMode];
    }
}))

YXKitAssist_imp(lfView, ({
    if ([view isKindOfClass:[UITextField class]] &&
        [lfView isKindOfClass:[UIView class]]) {
        [view performSelector:@selector(setLeftView:) withObject:lfView];
    }
}))

YXKitAssist_imp(rtView, ({
    if ([view isKindOfClass:[UITextField class]] &&
        [rtView isKindOfClass:[UIView class]]) {
        [view performSelector:@selector(setRightView:) withObject:rtView];
    }
}))

YXKitAssist_imp(secure, ({
    if ([view isKindOfClass:[UITextField class]] &&
        [secure isKindOfClass:[NSNumber class]]) {
        [view performSelector:@selector(setSecureTextEntry:) withObject:secure];
    }
}))

@end

@implementation UIView (YXKitAssist)

- (void)setYxkit_assist:(YXKitAssist *)yxkit_assist {
    objc_setAssociatedObject(self, @selector(yxkit_assist), yxkit_assist, OBJC_ASSOCIATION_RETAIN);
}

- (YXKitAssist *)yxkit_assist {
    YXKitAssist *kitAssist = objc_getAssociatedObject(self, _cmd);
    if (!kitAssist) {
        kitAssist = [[YXKitAssist alloc] init];
        [kitAssist setValue:self forKey:@"view"];
        self.yxkit_assist = kitAssist;
    }
    return kitAssist;
}

@end

@implementation UIColor (YXKitAssist)
+ (UIColor *)kitAssist:(id)color{
    if ([color isKindOfClass:[NSString class]]){
        return [self colorWithString:color];
    }
    else if ([color isKindOfClass:[UIColor class]]){
        return color;
    }
    return [UIColor blackColor];
}

+ (UIColor *)colorWithString:(NSString *)string{
    NSString *xxStr = [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // length is 6 or 8
    if ([xxStr length] < 6){
        return [UIColor blackColor];
    }
    
    // 0x
    if ([xxStr hasPrefix:@"0x"] || [xxStr hasPrefix:@"0X"]){
        xxStr = [xxStr substringFromIndex:2];
    }
    
    // #
    if ([xxStr hasPrefix:@"#"]){
        xxStr = [xxStr substringFromIndex:1];
    }
    
    if ([xxStr length] != 6){
        return [UIColor blackColor];
    }
    
    // r, g, b
    NSRange range;
    range.location = 0;
    range.length = 2;
    // r
    NSString *rStr = [xxStr substringWithRange:range];
    // g
    range.location = 2;
    NSString *gStr = [xxStr substringWithRange:range];
    // b
    range.location = 4;
    NSString *bStr = [xxStr substringWithRange:range];
    
    //
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rStr] scanHexInt:&r];
    [[NSScanner scannerWithString:gStr] scanHexInt:&g];
    [[NSScanner scannerWithString:bStr] scanHexInt:&b];
    
    UIColor *xxColor = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
    
    return xxColor;
}


@end
