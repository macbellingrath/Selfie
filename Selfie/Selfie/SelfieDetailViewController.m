//
//  SelfieDetailViewController.m
//  Camera
//
//  Created by Mac Bellingrath on 10/19/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

#import "SelfieDetailViewController.h"

@interface SelfieDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *selfieDetailImageView;
@property (weak, nonatomic) IBOutlet UILabel *selfieDetailCaptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *selfieDetailProfileIconImageView;
- (IBAction)twitterButtonPressed:(id)sender;
- (IBAction)winkButtonPressed:(id)sender;
- (IBAction)flagButtonPressed:(id)sender;

@end

@implementation SelfieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateInfo];
 
}

-(void)updateInfo{
    
    NSLog(@"%@", self.selfie);
    self.selfieDetailCaptionLabel.text = self.selfie[@"caption"];
    PFFile *userImageFile = self.selfie[@"imageFile"];
    
    [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            
            self.selfieDetailImageView.image = [UIImage imageWithData:imageData];
            [self.view setNeedsDisplay];
            
        }
    }];
    
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

- (IBAction)twitterButtonPressed:(UIButton *)sender {
}

- (IBAction)winkButtonPressed:(id)sender {
}

- (IBAction)flagButtonPressed:(id)sender {
}
@end
