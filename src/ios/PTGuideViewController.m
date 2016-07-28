//
//  PTGuideViewController.m
//  HelloWorld
//
//  Created by 耿远超 on 16/7/26.
//
//

#import "PTGuideViewController.h"

@interface PTGuideViewController () {
    void(^_completeBlock)(id object);
}

@end

@implementation PTGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)displayView {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    BOOL isUpDated = ![[def objectForKey:@"currentVersion"] isEqualToString:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
//    if (isUpDated) {
//        
//        guideView = [[ABCIntroView alloc] initWithFrame:self.window.rootViewController.view.frame];
//        guideView.delegate = self;
//        guideView.backgroundColor = [UIColor whiteColor];
//        [self.window.rootViewController.view addSubview:guideView];
//        
//    }
    
    return isUpDated;
}

- (void)completion:(void(^)(id object))completeBlock {
    if (self.displayView) {
        // 显示 引导页面
        _completeBlock = completeBlock;
    } else {
        // 不显示 引导页面
        completeBlock(nil);
    }
}

- (IBAction)buttonClick:(id)sender {
//    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        guideView.alpha = 0;
//    } completion:^(BOOL finished) {
//        [guideView removeFromSuperview];
//    }];
    
    [[NSUserDefaults standardUserDefaults] setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:@"currentVersion"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    _completeBlock(nil);
}


@end
