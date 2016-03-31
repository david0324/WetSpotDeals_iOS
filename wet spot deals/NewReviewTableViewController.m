//
//  NewReviewTableViewController.m
//  wet spot deals
//
//  Created by KOMI Marketing on 31/03/15.
//  Copyright (c) 2015 KOMI Marketing All rights reserved.
//

#import "NewReviewTableViewController.h"
#import <FBSDKCoreKit/FBSDKAccessToken.h>
#import <FBSDKCoreKit/FBSDKProfile.h>
#import "RestManager.h"

@interface NewReviewTableViewController ()

@end

@implementation NewReviewTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if ([FBSDKAccessToken currentAccessToken]) {
        [_facebookProfile setProfileID:[[FBSDKAccessToken currentAccessToken] userID]];
        FBSDKProfile * profile = [FBSDKProfile currentProfile];
        NSString * name =[profile name];
        _nameTxt.text =  name;
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Type your message here..."]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Type your message here...";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float height = 50;
    float cells;
    switch (indexPath.row) {
        case 0:
        case 3:
            height = 50;
            break;
        case 1:
            height = 110;
            break;
        case 2:
            if (self.navigationController.navigationController.navigationBar.translucent) {
                cells = 210 +self.navigationController.navigationBar.frame.size.height;
            }else{
                cells = 210;
            }
            height = (self.view.frame.size.height - cells);
            break;
        default:
            height =  50;
            break;
    }
    return height;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)setRate:(float)rate{
    UIImage * enableStar = [UIImage imageNamed:@"star_enable_item_wetspotdepot.png"];
    UIImage * disableStar = [UIImage imageNamed:@"star_disable_item_wetspotdepot.png"];
    
    for (UIButton* star in _stars) {
        [star setImage:disableStar forState:UIControlStateNormal];
    }
    
    if (rate >= 1) {
        [[_stars objectAtIndex:0] setImage:enableStar forState:UIControlStateNormal];
    }
    if (rate >= 2) {
        [[_stars objectAtIndex:1] setImage:enableStar forState:UIControlStateNormal];
    }
    if (rate >= 3) {
        [[_stars objectAtIndex:2] setImage:enableStar forState:UIControlStateNormal];
    }
    if (rate >= 4) {
        [[_stars objectAtIndex:3] setImage:enableStar forState:UIControlStateNormal];
    }
    if (rate >= 5) {
        [[_stars objectAtIndex:4] setImage:enableStar forState:UIControlStateNormal];
        rate = 5 ;
    }
    //    NSLog(@"%@",[NSString stringWithFormat:@"%.2f",rate]);
    _rateTxt.text = [NSString stringWithFormat:@"%.1f",rate];
    
}

- (IBAction)rateChange:(id)sender {
    float rate = [[_rateTxt text] floatValue];
    [self setRate:rate];
}

- (IBAction)star1:(id)sender {
    [self setRate:1.0];
}

- (IBAction)star2:(id)sender {
    [self setRate:2];
}

- (IBAction)star3:(id)sender {
    [self setRate:3];
}

- (IBAction)star4:(id)sender {
    [self setRate:4];
}

- (IBAction)star5:(id)sender {
    [self setRate:5];
}

- (IBAction)sendReview:(id)sender {
    
    
    
    
    if ([FBSDKAccessToken currentAccessToken]) {
        [_facebookProfile setProfileID:[[FBSDKAccessToken currentAccessToken] userID]];
        NSString *userId = [NSString stringWithFormat:@"%@",[[FBSDKAccessToken currentAccessToken] userID]];
        [RestManager sendReviewWithUser_name:_nameTxt.text Tagline:_taglineTxt.text Rate:[[_rateTxt text] floatValue] Inventory:_inventoryID UserFacebookId:userId Description:_messageTxt.text  CallBack:^(Review *newReview) {
            if (newReview != nil) {
                [self.delegate addReview:newReview];
                [self.navigationController popViewControllerAnimated:YES];
                NSLog(@"%@",newReview);
            }
        }];
        
    }
    
}
@end
