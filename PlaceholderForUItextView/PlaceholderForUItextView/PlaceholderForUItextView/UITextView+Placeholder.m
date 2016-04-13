//
//  UITextView+Placeholder.m
//  PlaceholderForUItextView
//
//  Created by zcx on 16/4/14.
//  Copyright © 2016年 继续前行. All rights reserved.
//

#import "UITextView+Placeholder.h"
#import <objc/runtime.h>

static char kPlaceholderLabelKey;
static char kPlaceholderStringKey;

@interface UITextView ()

@property (strong, nonatomic) UILabel *placeholderLabel;

@end

@implementation UITextView (Placeholder)

- (void)dealloc {
    [self removeTextDidChangeNotificationObserver];
}

- (void)removeTextDidChangeNotificationObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
}

- (void)setPlaceholder:(NSString *)placeholder {
    [self removeTextDidChangeNotificationObserver];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChangeNotification:) name:UITextViewTextDidChangeNotification object:self];
    objc_setAssociatedObject(self, &kPlaceholderStringKey, placeholder, OBJC_ASSOCIATION_COPY);
    
    self.placeholderLabel.text  = placeholder;
    self.placeholderLabel.font  = self.font;
    self.placeholderLabel.frame = CGRectMake(5, 8, self.placeholderLabel.intrinsicContentSize.width, self.placeholderLabel.intrinsicContentSize.height);
    self.placeholderLabel.hidden = self.text.length;
}

- (NSString *)placeholder {
    return [objc_getAssociatedObject(self, &kPlaceholderStringKey) copy];
}

- (UILabel *)placeholderLabel {
    UILabel *label = objc_getAssociatedObject(self, &kPlaceholderLabelKey);
    if (!label) {
        label = [[UILabel alloc] init];
        label.textColor = [UIColor lightGrayColor];
        label.font = self.font;
        [self addSubview:label];
        objc_setAssociatedObject(self, &kPlaceholderLabelKey, label, OBJC_ASSOCIATION_ASSIGN);
    }
    return label;
}

- (void)textDidChangeNotification:(NSNotification *)notification {
    if (self.placeholderLabel) {
        self.placeholderLabel.hidden = self.text.length;
    }
}

@end
