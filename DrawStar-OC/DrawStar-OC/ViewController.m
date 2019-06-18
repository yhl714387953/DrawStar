//
//  ViewController.m
//  DrawStar-OC
//
//  Created by 嘴爷 on 2019/6/18.
//  Copyright © 2019 嘴爷. All rights reserved.
//

#import "ViewController.h"
#import "StarView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet StarView *starView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)stepChange:(UIStepper *)sender {
    [self.starView drawStar:sender.value count:7];
}

@end
