//
//  ViewController.m
//  YXClickTextViewDemo
//
//  Created by yunxin bai on 2019/4/4.
//  Copyright © 2019 yunxin bai. All rights reserved.
//

#import "ViewController.h"
#import "YXClickTextView/YXClickTextView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    YXClickTextView *textView1 = [[YXClickTextView alloc] init];
    [self.view addSubview:textView1];
    textView1.textColor = [UIColor blackColor];
    textView1.font = [UIFont systemFontOfSize:14];
    textView1.textAlignment = NSTextAlignmentLeft;
    textView1.highlightedBackgroundColor = [UIColor orangeColor];
    
    textView1.autoWidth = YES;
    textView1.autoHeight = YES; // Default is 'YES'
    
    textView1.frame = CGRectMake(20, 140, 300, 30);
    textView1.text = @"您已阅读并同意《注册与服务协议》";
    textView1.yxkit_assist.attributedSubstring(@"《注册与服务协议》", [UIColor blueColor]);
    [textView1 addClickTexts:@[@"《注册与服务协议》",] callback:^(NSString *text, NSRange range) {
        NSString *msg = [NSString stringWithFormat:@"text:%@,range:%@",text,NSStringFromRange(range)];
        NSLog(@"%@",msg);
    }];
    
    
    
    YXClickTextView *textView2 = [[YXClickTextView alloc] init];
    [self.view addSubview:textView2];
    textView2.textColor = [UIColor blackColor];
    textView2.backgroundColor = [UIColor grayColor];
    textView2.font = [UIFont systemFontOfSize:14];
    textView2.textAlignment = NSTextAlignmentLeft;
    textView2.highlightedBackgroundColor = [UIColor orangeColor];
    
    textView2.autoWidth = YES;
    textView2.autoHeight = YES; // Default is 'YES'
    
    textView2.frame = CGRectMake(20, 200, 300, 200);
    textView2.text = @"在调用工厂类的工厂方法时，由于工厂方法是静态方法，使用起来很方便，可通过类名直接调用，而且只需要传入一个简单的参数即可，在实际开发中，还可以在调用时将所传入的参数保存在XML等格式的配置文件中，修改参数时无须修改任何源代码。";
    textView2.yxkit_assist.attributedSubstring(@"在实际开发中", [UIColor orangeColor]);
    [textView2 addClickTexts:@[@"在实际开发中",] callback:^(NSString *text, NSRange range) {
        NSString *msg = [NSString stringWithFormat:@"text:%@,range:%@",text,NSStringFromRange(range)];
        NSLog(@"%@",msg);
    }];
}


@end
