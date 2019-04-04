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
    
    YXClickTextView *clickT = [[YXClickTextView alloc] init];
    [self.view addSubview:clickT];
    clickT.textColor = [UIColor blackColor];
    clickT.backgroundColor = [UIColor grayColor];
    clickT.font = [UIFont systemFontOfSize:14];
    clickT.textAlignment = NSTextAlignmentLeft;
    clickT.highlightedBackgroundColor = [UIColor orangeColor];
    
    clickT.autoWidth = YES;
    clickT.autoHeight = YES; // Default is 'YES'
    
    clickT.frame = CGRectMake(0, 100, 300, 200);
    clickT.text = @"1.每个结点最多有两棵子树，所以二叉树种不存在度大于2的结点；2.左子树和右子树是有顺序的，次序不能任意颠倒；3.即使树中某结点只有一课子树，也要区分它是左子树还是右子树";
    clickT.yxkit_assist.attributedSubstring(@"右子树是有顺序的", [UIColor orangeColor]);
    [clickT addClickTexts:@[@"右子树是有顺序的",] callback:^(NSString *text, NSRange range) {
        NSString *msg = [NSString stringWithFormat:@"text:%@,range:%@",text,NSStringFromRange(range)];
        NSLog(@"%@",msg);

    }];
}


@end
