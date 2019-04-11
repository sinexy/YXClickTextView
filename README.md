# YXClickTextView
 一个简单的可点击 textView
 
 主要应用场景：
 
 * 各种服务协议的点击
 
 * 一些简单的富文本应用
 
 示例图：
 ![图](https://github.com/sinexy/YXClickTextView/blob/master/example.jpg)

使用示例：
```
    YXClickTextView *textView1 = [[YXClickTextView alloc] init];
    textView1.frame = CGRectMake(20, 140, 300, 30);
    textView1.text = @"您已阅读并同意《注册与服务协议》";
    textView1.yxkit_assist.attributedSubstring(@"《注册与服务协议》", [UIColor blueColor]);
    [textView1 addClickTexts:@[@"《注册与服务协议》",] callback:^(NSString *text, NSRange range) {
        NSString *msg = [NSString stringWithFormat:@"text:%@,range:%@",text,NSStringFromRange(range)];
        NSLog(@"%@",msg);
    }];
```

在 block 中加入点击事件的响应即可

