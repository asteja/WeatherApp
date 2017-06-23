//
//  ViewController.m
//  WeatherApp
//
//  Created by Sai Teja on 6/10/17.
//  Copyright © 2017 Sai Teja. All rights reserved.
//

#import "ViewController.h"
#import <GooglePlaces/GooglePlaces.h>
#import "Forecast.h"
#import "DailyForecast.h"

@interface ViewController ()

@property NSArray *address;
@property NSMutableArray *daysForecast;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *maxTempLBL;
@property (weak, nonatomic) IBOutlet UILabel *minTempLBL;
@property (weak, nonatomic) IBOutlet UILabel *todayDescriptionLBL;
@property DailyForecast *dailyForecast;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    _client = [APIWebService new];
    _daysForecast = [[NSMutableArray alloc]init];
    _dailyForecast = [[DailyForecast alloc]init];
    
    _resultsViewController = [[GMSAutocompleteResultsViewController alloc] init];
    _resultsViewController.delegate = self;
    
    _searchController = [[UISearchController alloc]
                         initWithSearchResultsController:_resultsViewController];
    _searchController.searchResultsUpdater = _resultsViewController;
    
    [_searchController.searchBar sizeToFit];
    self.navigationItem.titleView = _searchController.searchBar;
    
    self.definesPresentationContext = YES;
    
    _searchController.hidesNavigationBarDuringPresentation = NO;
    
    
}


// Handle the user's selection.
- (void)resultsController:(GMSAutocompleteResultsViewController *)resultsController
 didAutocompleteWithPlace:(GMSPlace *)place {
    _searchController.active = NO;
    self.searchController.searchBar.text = place.formattedAddress;
    
    // Do something with the selected place.
    _address = (NSArray*)[place.formattedAddress componentsSeparatedByString:@","];
    
    [self.daysForecast  removeAllObjects];
    
    if ([_address count] > 1) {
        [_client getTemparatures:_address[0] respectiveState:_address[1] onSuccess:^(NSDictionary *dictionary) {
            
            NSArray *objects = dictionary[@"forecast"][@"simpleforecast"][@"forecastday"];
            
            if ([objects count] != 0) {
                for (NSDictionary *dictionary in objects) {
                    [self.daysForecast addObject:[[Forecast alloc]initWithDictionary: dictionary]];
                }
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [self getForecastForDay];
                });
                
            }else {
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Unable to fetch from API" preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
                    [alert addAction:actionOk];
                    
                    [self presentViewController:alert animated:true completion:nil];
                });
            }
            
            
        } onError:^(NSError *error) {
            NSLog(@"%@", error);
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:error.description preferredStyle:UIAlertControllerStyleAlert];
            
            [self presentViewController:alert animated:true completion:nil];
            
        }];

    } else {
        
       
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Unable to fetch from API" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:actionOk];
            
            [self presentViewController:alert animated:true completion:nil];
               
    }
    
    
}

- (void)resultsController:(GMSAutocompleteResultsViewController *)resultsController
didFailAutocompleteWithError:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    // TODO: handle the error.
    NSLog(@"Error: %@", [error description]);
}

// Turn the network activity indicator on and off again.
- (void)didRequestAutocompletePredictionsForResultsController:
(GMSAutocompleteResultsViewController *)resultsController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didUpdateAutocompletePredictionsForResultsController:
(GMSAutocompleteResultsViewController *)resultsController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

-(void)getForecastForDay {
    
    if ([self.daysForecast count] != 0) {
        Forecast *currentDay = [self.daysForecast objectAtIndex:0];
        _maxTempLBL.text = [NSString stringWithFormat:@"%@°F", currentDay.highTemp];
        _minTempLBL.text = [NSString stringWithFormat:@"%@°F", currentDay.lowTemp];
        _todayDescriptionLBL.text = currentDay.textDescription;
        
        [self.tableView reloadData];


    }
    
}


#pragma mark - Table view Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.daysForecast count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SimpleTableItem" forIndexPath:indexPath];
    
    Forecast *day = self.daysForecast[indexPath.row];
    
    UILabel *dayLBL = (UILabel*)[cell viewWithTag:4];
    dayLBL.text = [day day];
    
    UIImageView *dayIMG = (UIImageView*)[cell viewWithTag:5];

    UILabel *conditionLBL = (UILabel*)[cell viewWithTag:1];
    conditionLBL.text = [day textDescription];
    
    if ([conditionLBL.text  isEqual: @"Clear"]) {
        dayIMG.image = [UIImage imageNamed:@"Sunny"];
    } else if([conditionLBL.text  isEqual: @"Partly Cloudy"]) {
        dayIMG.image = [UIImage imageNamed:@"Partially Cloudy"];
    }
    
    UILabel *maxTempLBL = (UILabel*)[cell viewWithTag:2];
    maxTempLBL.text = [day highTemp];
    
    UILabel *minTempLBL = (UILabel*)[cell viewWithTag:3];
    minTempLBL.text = [day lowTemp];
    
    return cell;
    
    
}


@end
