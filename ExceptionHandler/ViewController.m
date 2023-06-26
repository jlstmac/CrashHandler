//
//  ViewController.m
//  ExceptionHandler
//
//  Created by Jiang LinShan on 2023/6/25.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    const CGFloat BTN_WIDTH = 200;
    const CGFloat BTN_Height = 50;
    const CGFloat BTN_Gap = 30;

    CGFloat top = 100;

    UIButton* btn = [self createButton:@"数组越界" action:@selector(makeArrayException)];
    btn.frame = CGRectMake((self.view.frame.size.width - BTN_WIDTH)/2, top, BTN_WIDTH, BTN_Height);
    top += BTN_Height + BTN_Gap;
    
    btn = [self createButton:@"数组插入空值" action:@selector(makeArrayInsertNil)];
    btn.frame = CGRectMake((self.view.frame.size.width - BTN_WIDTH)/2, top, BTN_WIDTH, BTN_Height);
    top += BTN_Height + BTN_Gap;
    

}

- (void)makeArrayInsertNil {
    NSMutableArray* arr = NSMutableArray.new;
    [arr insertObject:nil atIndex:0];
}

- (void)makeArrayException {
    NSArray* arr = NSArray.new;
    id obj = [arr objectAtIndex:2];
}

- (UIButton*)createButton:(NSString*)title action:(nonnull SEL)action {
    UIButton* button = UIButton.new;
    button.backgroundColor = UIColor.redColor;
    [button setTitle:title forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

@end
