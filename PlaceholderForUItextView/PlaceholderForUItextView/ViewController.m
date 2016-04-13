//
//  ViewController.m
//  PlaceholderForUItextView
//
//  Created by zcx on 16/4/14.
//  Copyright © 2016年 继续前行. All rights reserved.
//

#import "ViewController.h"
#import "UITextView+Placeholder.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _textView.placeholder = @"继续前行";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
