//
//  DailyForecast.m
//  WeatherApp
//
//  Created by Sai Teja on 6/11/17.
//  Copyright © 2017 Sai Teja. All rights reserved.
//

#import "DailyForecast.h"

@interface DailyForecast ()

@property (nonatomic, strong) UILabel *dayOfWeekTitle;
@property (nonatomic, strong) UILabel *highTemperature;
@property (nonatomic, strong) UILabel *lowTemperature;
@property (nonatomic, strong) UITextView *textDescription;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic) BOOL needsTopBorder;

@end

@implementation DailyForecast

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.dayOfWeekTitle = [[UILabel alloc] init];
        self.dayOfWeekTitle.textColor = [UIColor whiteColor];
        self.dayOfWeekTitle.backgroundColor = [UIColor clearColor];
        self.dayOfWeekTitle.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
        self.dayOfWeekTitle.textAlignment = NSTextAlignmentCenter;
        self.dayOfWeekTitle.text = @"SUN";
        [self addSubview:self.dayOfWeekTitle];
        
        self.textDescription = [[UITextView alloc] init];
        self.textDescription.textColor = [UIColor whiteColor];
        self.textDescription.textAlignment = NSTextAlignmentCenter;
        self.textDescription.backgroundColor = [UIColor clearColor];
        self.textDescription.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.textDescription];
        
        self.highTemperature = [[UILabel alloc] init];
        self.highTemperature.textColor = [UIColor whiteColor];
        self.highTemperature.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
        self.highTemperature.font = [UIFont boldSystemFontOfSize:24];
        self.highTemperature.textAlignment = NSTextAlignmentCenter;
        self.highTemperature.text = @"98° / 86°";
        [self addSubview:self.highTemperature];
        
        self.lineView = [[UIView alloc]init];
        self.lineView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.lineView];
        
        self.lowTemperature = [[UILabel alloc] init];
        self.lowTemperature.textColor = [UIColor whiteColor];
        self.lowTemperature.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
        self.lowTemperature.font = [UIFont boldSystemFontOfSize:24];
        self.lowTemperature.textAlignment = NSTextAlignmentCenter;
        self.lowTemperature.text = @"98° / 86°";
        [self addSubview:self.lowTemperature];
        
        self.backgroundColor = [UIColor colorWithRed:(30.0/255.0) green:(178.0/255.0) blue:(205.00/255.0) alpha:1.0];
    }
    return self;
}

- (void)layoutSubviews {
    self.dayOfWeekTitle.frame = CGRectMake(0, 20, CGRectGetWidth(self.frame), 20);
    self.textDescription.frame = CGRectMake(0, 150, CGRectGetWidth(self.frame), 20);
    self.highTemperature.frame = CGRectMake(0, 54, CGRectGetWidth(self.frame), 40);
    self.lineView.frame = CGRectMake(43, 102, 45, 1);
    self.lowTemperature.frame = CGRectMake(0, 110, CGRectGetWidth(self.frame), 40);
}



- (void)configureBlock:(Forecast*)forecast index:(float)index{
    
    
    UIColor* currentBGColor = [UIColor colorWithRed:(44.0/255.0) green:(210.0/255.0) blue:1.0 alpha:1.0];
    
    //get the hue, brightness, and saturation components of the new color to make a lighter shade for the highlight state
    CGFloat hue, saturation, brightness, alpha;
    [currentBGColor getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    
    //now set highlight state by modifying brightness with a 30% increase
    self.backgroundColor = [UIColor colorWithHue:hue saturation:saturation brightness:(brightness / (1.0 + (index/10.0))) alpha:alpha];
    
    
    self.backgroundColor = [UIColor colorWithRed:(30.0/255.0) green:(178.0/255.0) blue:(205.00/255.0) alpha:1.0];
    self.needsTopBorder = TRUE;
    
    self.dayOfWeekTitle.text = forecast.day;
    self.textDescription.text = forecast.textDescription;
    self.highTemperature.text = [NSString stringWithFormat:@"%@°F", forecast.highTemp];
    self.lowTemperature.text = [NSString stringWithFormat:@"%@°F", forecast.lowTemp];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:(24.0/255.0) green:(157.0/255.0) blue:(178.00/255.0) alpha:1.0].CGColor);
    
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, 1.0f);
    
    if(self.needsTopBorder) {
        CGContextMoveToPoint(context, 0.0f, 1.0f); //start at this point
        
        CGContextAddLineToPoint(context, CGRectGetWidth(self.frame), 1.0f); //draw to this point
        
        // and now draw the Path!
        CGContextStrokePath(context);
    }
}

@end
