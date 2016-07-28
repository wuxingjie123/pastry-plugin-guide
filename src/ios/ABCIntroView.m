//
//  IntroView.m
//  DrawPad
//
//  Created by Adam Cooper on 2/4/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import "ABCIntroView.h"

//尺寸
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define ONE_PIXEL (1 / [UIScreen mainScreen].scale)//高度为一个像素
#define kFrameGap 15
#define kNavigationBarHeight 64

//字体
#define kFontSize_44 [UIFont systemFontOfSize:22]
#define kFontSize_36 [UIFont systemFontOfSize:18]
#define kFontSize_32 [UIFont systemFontOfSize:16]
#define kFontSize_30 [UIFont systemFontOfSize:15]
#define kFontSize_28 [UIFont systemFontOfSize:14]

#define VIEW_FULL CGRectMake(0, 0, kScreenWidth, kScreenHeight)

@interface ABCIntroView () <UIScrollViewDelegate>
{
    UIButton *doneButton;
    NSArray *imgNames;
    NSArray *bigImgNames;
    
}
@property (strong, nonatomic)  UIScrollView *scrollView;
@property (strong, nonatomic)  UIPageControl *pageControl;

@end

@implementation ABCIntroView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.frame];
        [self addSubview:backgroundImageView];
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.bounces = NO;
        [self addSubview:self.scrollView];
        
        
        
        imgNames = @[@"guide01", @"guide02", @"guide03"];
//        bigImgNames = @[@"start_a_640_960", @"start_b_640_960", @"start_c_640_960", @"start_d_640_960", ];
        [self createImageView];

        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height*.8, self.frame.size.width, 10)];
        self.pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        [self addSubview:self.pageControl];
        self.pageControl.hidden = YES;
        NSInteger pageCount = imgNames.count;
        self.pageControl.numberOfPages = pageCount;
        self.scrollView.contentSize = CGSizeMake(self.frame.size.width*pageCount, self.scrollView.frame.size.height);
        CGPoint scrollPoint = CGPointMake(0, 0);
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
    return self;
}

- (void)onFinishedIntroButtonPressed:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(onDoneButtonPressed)]) {
        
        [self.delegate onDoneButtonPressed];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = CGRectGetWidth(self.bounds);
    CGFloat pageFraction = self.scrollView.contentOffset.x / pageWidth;
    self.pageControl.currentPage = roundf(pageFraction);
    
}


#pragma mark - createImageView
- (void)createImageView
{
    for (int i = 0; i < imgNames.count; i++) {
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth*i, 0, kScreenWidth, kScreenHeight)];
        imageview.image = (kScreenHeight == 480) ? [UIImage imageNamed:bigImgNames[i]] : [UIImage imageNamed:imgNames[i]];
        self.scrollView.delegate = self;
        [self.scrollView addSubview:imageview];
        
        if (i == imgNames.count-1) {
            
            //Done Button
            doneButton = [[UIButton alloc] initWithFrame:CGRectMake(80, kScreenHeight-135-45, kScreenWidth-160, 45)];
            [doneButton setTintColor:[UIColor whiteColor]];
            [doneButton setTitle:@"" forState:UIControlStateNormal];
            doneButton.titleLabel.font = kFontSize_36;
            doneButton.backgroundColor = [UIColor clearColor];
            doneButton.layer.borderColor = [UIColor clearColor].CGColor;
            [doneButton addTarget:self action:@selector(onFinishedIntroButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            doneButton.layer.borderWidth = ONE_PIXEL;
            doneButton.layer.cornerRadius = 3.f;
            [imageview addSubview:doneButton];
            imageview.userInteractionEnabled = YES;
        }
        
    }
}



@end