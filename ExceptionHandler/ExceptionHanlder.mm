//
//  ExceptionHanlder.m
//  ExceptionHandler
//
//  Created by Jiang LinShan on 2023/6/25.
//

#import "ExceptionHanlder.h"
#import <UIKit/UIKit.h>
@interface ExceptionHanlder()
@end

@implementation ExceptionHanlder
void exceptionHanler(NSException* exception) {
    
    NSArray *stackArray = [exception callStackSymbols];

    NSString* crashInfo = [NSString stringWithFormat:@"name:%@,reason:%@,userInfo:%@,stack:%@",exception.name,exception.reason,exception.userInfo,stackArray];
    NSLog(@"crashInfo:%@",crashInfo);
    
    avoidCrash();
    
}

void avoidCrash() {

    UIAlertController* alert = [[UIAlertController alloc] init];
    alert.title = @"程序发生了异常!!";
    alert.message = @"继续运行可能会有位置错误，是否继续执行？";
    UIAlertAction* actionCancel = [UIAlertAction actionWithTitle:@"崩溃吧" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        /// 杀掉app
        kill(getpid(), SIGKILL);
    }];
    UIAlertAction* actionSure = [UIAlertAction actionWithTitle:@"起死回生吧" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:actionCancel];
    [alert addAction:actionSure];
    [UIApplication.sharedApplication.keyWindow.rootViewController presentViewController:alert animated:YES completion:NULL];

    ///取出当前的mode让它继续跑。
    CFRunLoopRef rlp = CFRunLoopGetCurrent();
    CFArrayRef allModel = CFRunLoopCopyAllModes(rlp);
    while (true) {
        for (NSString* mode in (__bridge NSArray*)allModel) {
            CFRunLoopRunInMode((__bridge CFRunLoopMode)mode, 0.00001, false);
        }
    }
    CFRelease(allModel);
    
    ///TODO:回传崩溃信息
    
}

+ (void)initExcptionHanlder {
    NSSetUncaughtExceptionHandler(&exceptionHanler);
}


@end
