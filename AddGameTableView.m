//
//  AddGameTableView.m
//  Sharps 1
//
//  Created by Eric Lundmark on 2012-02-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddGameTableView.h"


@implementation AddGameTableView
@synthesize textCellTitles;
@synthesize detailCellTitles;
@synthesize spreadsheet;
@synthesize currentCellIndexPath;
@synthesize networkMediator;
@synthesize dataValues;
@synthesize mode;
@synthesize game;
@synthesize content;
@synthesize resultCellIndexPath;
@synthesize resultCellExpanded;
@synthesize timeCellIndexPath;
@synthesize dateCellIndexPath;
@synthesize keys;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    keys = [[NSArray alloc] initWithObjects:@"team1", @"team2", @"league", @"country",@"period",@"sport",
            @"bolag",@"sign",@"sign2", @"date", @"time",@"info",@"rekare", @"odds", @"amount", @"result",nil];
    textCellTitles=[[NSArray alloc] initWithObjects:@"Hemmalag",@"Bortalag",@"Tecken",@"Datum",@"Tid",@"Info",@"Rekare",@"Odds",@"Insats",@"Resultat", nil];
    detailCellTitles=[[NSArray alloc] initWithObjects:@"Liga",@"Land",@"Period",@"Sport",@"Bolag",@"Tecken", nil];
    
    NSArray *periodValues=[[NSArray alloc] initWithObjects:@"Fulltid",@"Moneyline",@"Fulltid inkl OT",@"Halvtid",@"Halvtid/Fulltid",@"Första halvlek",@"Andra halvlek",@"Tredje halvlek",@"Första quartern",@"Andra quartern",@"Tredje quartern",@"Fjärde quartern",@"Första perioden",@"Andra perioden",@"Tredje perioden", nil];
    
    NSArray *signValues =[[NSArray alloc] initWithObjects:@"Hemmalag",@"Oavgjort",@"Bortalag",@"Över",@"Under", @"1X",@"X2",@"Resultat",@"Målskytt",nil];
    
    NSArray *leagueValues=[[NSArray alloc] initWithObjects:@"A-league",@"Allsvenskan",@"Bandy",@"Basket",@"Bundesliga", @"Champions League",@"Championship",@"Europa League",@"Elitserien",@"Eredivisie",@"Fotboll",@"Handboll",@"Hockey Allsvenskan",@"Innebandy",@"Ishockey",@"KHL",@"Landskamp",@"NHL",nil];
    
    NSArray *countryValues=[[NSArray alloc] initWithObjects:@"Afghanistan",
                            @"Aland",
                            @"Albania",
                            @"Algeria",
                            @"American Samoa",
                            @"Andorra",
                            @"Angola",
                            @"Anguilla",
                            @"Antigua and Barbuda",
                            @"Argentina",
                            @"Armenia",
                            @"Aruba",
                            @"Ascension Island",
                            @"Australia",
                            @"Austria",
                            @"Azerbaijan",
                            @"Bahamas, The",
                            @"Bahrain",
                            @"Bangladesh",
                            @"Barbados",
                            @"Belarus",
                            @"Belgium",
                            @"Belize",
                            @"Benin",
                            @"Bermuda",
                            @"Bhutan",
                            @"Bolivia",
                            @"Bosnia and Herzegovina",
                            @"Botswana",
                            @"Brazil",
                            @"Brunei",
                            @"Bulgaria",
                            @"Burkina Faso",
                            @"Burundi",
                            @"Cambodia",
                            @"Cameroon",
                            @"Canada",
                            @"Cape Verde",
                            @"Cayman Islands",
                            @"Central Africa Republic",
                            @"Chad",
                            @"Chile",
                            @"China",
                            @"Christmas Island",
                            @"Cocos (Keeling) Islands",
                            @"Colombia",
                            @"Comoros",
                            @"Congo",
                            @"Cook Islands",
                            @"Costa Rica",
                            @"Cote d'lvoire",
                            @"Croatia",
                            @"Cuba",
                            @"Cyprus",
                            @"Czech Republic",
                            @"Denmark",
                            @"Djibouti",
                            @"Dominica",
                            @"Dominican Republic",
                            @"East Timor Ecuador",
                            @"Egypt",
                            @"El Salvador",
                            @"Equatorial Guinea",
                            @"Eritrea",
                            @"Estonia",
                            @"Ethiopia",
                            @"Falkland Islands",
                            @"Faroe Islands",
                            @"Fiji",
                            @"Finland",
                            @"France",
                            @"French Polynesia",
                            @"Gabon",
                            @"Cambia, The",
                            @"Georgia",
                            @"Germany",
                            @"Ghana",
                            @"Gibraltar",
                            @"Greece",
                            @"Greenland",
                            @"Grenada",
                            @"Guam",
                            @"Guatemala",
                            @"Guemsey",
                            @"Guinea",
                            @"Guinea-Bissau",
                            @"Guyana",
                            @"Haiti",
                            @"Honduras",
                            @"Hong Kong",
                            @"Hungary",
                            @"Iceland",
                            @"India",
                            @"Indonesia",
                            @"Iran",
                            @"Iraq",
                            @"Ireland",
                            @"Isle of Man",
                            @"Israel",
                            @"Italy",
                            @"Jamaica",
                            @"Japan",
                            @"Jersey",
                            @"Jordan",
                            @"Kazakhstan",
                            @"Kenya",
                            @"Kiribati",
                            @"Korea, N",
                            @"Korea, S",
                            @"Kosovo",
                            @"Kuwait",
                            @"Kyrgyzstan",
                            @"Laos",
                            @"Latvia",
                            @"Lebanon",
                            @"Lesotho",
                            @"Liberia",
                            @"Libya",
                            @"Liechtenstein",
                            @"Lithuania",
                            @"Luxembourg",
                            @"Macao",
                            @"Macedonia",
                            @"Madagascar",
                            @"Malawi",
                            @"Malaysia",
                            @"Maldives",
                            @"Mali",
                            @"Malta",
                            @"Marshall Islands",
                            @"Mauritania",
                            @"Mauritius",
                            @"Mayotte",
                            @"Mexico",
                            @"Micronesia",
                            @"Moldova",
                            @"Monaco",
                            @"Mongolia",
                            @"Montenegro",
                            @"Montserrat",
                            @"Morocco",
                            @"Mozambique",
                            @"Myanmar",
                            @"Nagorno-Karabakh",
                            @"Namibia",
                            @"Nauru",
                            @"Nepal",
                            @"Netherlands",
                            @"Netherlands Antilles",
                            @"New Caledonia",
                            @"New Zealand",
                            @"Nicaragua",
                            @"Niger",
                            @"Nigeria",
                            @"Niue",
                            @"Norfolk Island",
                            @"Northern Cyprus",
                            @"Northern Mariana Islands",
                            @"Norway",
                            @"Oman",
                            @"Pakistan",
                            @"Palau",
                            @"Palestine",
                            @"Panama",
                            @"Papua New Guinea",
                            @"Paraguay",
                            @"Peru",
                            @"Philippines",
                            @"Pitcaim Islands",
                            @"Poland",
                            @"Portugal",
                            @"Puerto Rico",
                            @"Qatar",
                            @"Romania",
                            @"Russia",
                            @"Rwanda",
                            @"Sahrawi Arab Democratic Republic",
                            @"Saint-Barthelemy",
                            @"Saint Helena",
                            @"Saint Kitts and Nevis",
                            @"Saint Lucia",
                            @"Saint Martin",
                            @"Saint Pierre and Miquelon",
                            @"Saint Vincent and Grenadines",
                            @"Samos",
                            @"San Marino",
                            @"Sao Tome and Principe",
                            @"Saudi Arabia",
                            @"Senegal",
                            @"Serbia",
                            @"Seychelles",
                            @"Sierra Leone",
                            @"Singapore",
                            @"Slovakia",
                            @"Slovenia",
                            @"Solomon Islands",
                            @"Somalia",
                            @"Somaliland",
                            @"South Africa",
                            @"South Ossetia",
                            @"Spain",
                            @"Sri Lanka",
                            @"Sudan",
                            @"Suriname",
                            @"Svalbard",
                            @"Swaziland",
                            @"Sweden",
                            @"Switzerland",
                            @"Syria",
                            @"Tajikistan",
                            @"Tanzania",
                            @"Thailand",
                            @"Togo",
                            @"Tokelau",
                            @"Tonga",
                            @"Transnistria",
                            @"Trinidad and Tobago",
                            @"Tristan da Cunha",
                            @"Tunisia",
                            @"Turkey",
                            @"Turkmenistan",
                            @"Turks and Caicos Islands",
                            @"Tuvalu",
                            @"Uganda",
                            @"Ukraine",
                            @"United Arab Emirates",
                            @"United Kingdom",
                            @"United States",
                            @"Uruguay",
                            @"Uzbekistan",
                            @"Vanuatu",
                            @"Vatican City",
                            @"Venezuela",
                            @"Vietnam",
                            @"Virgin Islands, British",
                            @"Virgin Islands, U.S.",
                            @"Wallis and Futuna",
                            @"Yemen",
                            @"Zambia",
                            @"Zimbabwe",nil];
    
    NSArray *sportValues=[[NSArray alloc] initWithObjects:@"Am Fotboll",@"Bandy",@"Basket",nil];
    NSArray *companyValues=[[NSArray alloc] initWithObjects:@"Betfair",@"Unibet",@"Betsafe",nil];    
    dataValues=[[NSArray alloc] initWithObjects:leagueValues,countryValues,periodValues,sportValues,companyValues,signValues,nil];
    
    networkMediator=[NetworkMediator sharedInstance];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if (mode==View) {
        return 4;
    } 
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 1;
        case 2:
            return [detailCellTitles count];
        case 3:
            return [textCellTitles count]-2;
        case 4:
            return 2;
        case 5:
            return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((indexPath.section==3&&indexPath.row==[self.tableView numberOfRowsInSection:indexPath.section]-1)||mode==View) {
        static NSString *cellIdentifier = @"CellIdentifier";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        }
        cell.textLabel.textColor=[UIColor darkTextColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if (mode==Add) {
            cell.textLabel.text=@"0";
        }else if(indexPath.section==0||indexPath.section==1||indexPath.section==2){
            cell.textLabel.text=[game objectForKey:[keys objectAtIndex:indexPath.row+indexPath.section]];
        }else if(indexPath.section==3){
            cell.textLabel.text=[game objectForKey:[keys objectAtIndex:indexPath.row+indexPath.section+5]];
        }
        if (indexPath.section==0||indexPath.section==1||indexPath.section==3) {
            NSString *key;
            if (indexPath.section==3) {
                key=[[NSString alloc]initWithFormat:@"%i",indexPath.row+indexPath.section-1];
            }else{
                key=[[NSString alloc]initWithFormat:@"%i",indexPath.row+indexPath.section];
            }
            
            cell.detailTextLabel.text=[textCellTitles objectAtIndex:[key integerValue]];
        }else{
            NSString *key=[[NSString alloc]initWithFormat:@"%i",indexPath.row];
            cell.detailTextLabel.text=[detailCellTitles objectAtIndex:[key integerValue]];
        }
        //Om det är result cellen, sätts färgen på texten
        if (indexPath.section==3&&indexPath.row==[self.tableView numberOfRowsInSection:indexPath.section]-1) {
            if ([cell.textLabel.text characterAtIndex:0]=='-'){
                cell.textLabel.textColor=[UIColor colorWithRed:1 green:0 blue:0 alpha:1];
            }else if ([cell.textLabel.text doubleValue]!=0) {
                cell.textLabel.textColor=[UIColor colorWithRed:0 green:1 blue:0 alpha:1];
            }
        }
        
        return cell;
    }else if (indexPath.section==0||indexPath.section==1||(indexPath.section==3&&indexPath.row!=[self.tableView numberOfRowsInSection:indexPath.section]-1)) {
        
        static NSString *CellIdentifier = @"TextFieldCell";
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        // Configure the cell...
        cell.content=content;
        cell.tag=indexPath.row+indexPath.section;
        NSString *key=[[NSString alloc]initWithFormat:@"%i",indexPath.row+indexPath.section];
        if(indexPath.section==3) {
            key=[[NSString alloc]initWithFormat:@"%i",indexPath.row+indexPath.section-1];
            cell.tag=indexPath.row+indexPath.section+5;
        }
        cell.subTitle.text=[textCellTitles objectAtIndex:[key integerValue]];
        NSString *temp=[content objectForKey:[[NSString alloc]initWithFormat:@"%i",cell.tag]];
        if (mode==Add) {
            if (!temp) {
                cell.cellTextField.text=Nil;
                cell.cellTextField.placeholder=[textCellTitles objectAtIndex:[key integerValue]];
            } else {
                key=[[NSString alloc]initWithFormat:@"%i",cell.tag];
                cell.cellTextField.text=temp;
            }
        }else{
            if (indexPath.section==3) {
                cell.cellTextField.text=[game objectForKey:[keys objectAtIndex:indexPath.row+indexPath.section+5]];
            } else {
                cell.cellTextField.text=[game objectForKey:[keys objectAtIndex:indexPath.row+indexPath.section]];
            }
        }
        //Om datum eller tid läggs en pickerView som inputView
        if (indexPath.section==3&&indexPath.row==1) {
            //Datum
            dateCellIndexPath=indexPath;
            UIDatePicker *datePicker = [[UIDatePicker alloc] init];
            datePicker.datePickerMode = UIDatePickerModeDate;
            datePicker.tag = indexPath.row;
            UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
            toolbar.barStyle = UIBarStyleBlackTranslucent;
            UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                           style:UIBarButtonItemStyleBordered target:self
                                                                          action:@selector(pickerDoneClicked:)];
            doneButton.tag=1;
            [toolbar setItems:[NSArray arrayWithObjects:doneButton, nil]];
            cell.cellTextField.inputAccessoryView = toolbar;
            cell.cellTextField.inputView = datePicker;
        }else if (indexPath.section==3&&indexPath.row==2) {
            //Tid
            timeCellIndexPath=indexPath;
            UIDatePicker *datePicker = [[UIDatePicker alloc] init];
            datePicker.datePickerMode = UIDatePickerModeTime;
            datePicker.tag = indexPath.row;
            UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
            toolbar.barStyle = UIBarStyleBlackTranslucent;
            UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                           style:UIBarButtonItemStyleBordered target:self
                                                                          action:@selector(pickerDoneClicked:)];
            doneButton.tag=2;
            [toolbar setItems:[NSArray arrayWithObjects:doneButton, nil]];
            cell.cellTextField.inputAccessoryView = toolbar;
            cell.cellTextField.inputView = datePicker;
        }
        return cell;
    }else if(indexPath.section==2){
        static NSString *CellIdentifier = @"DetailCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        cell.detailTextLabel.text=[detailCellTitles objectAtIndex:indexPath.row];
        if (mode==Add) {
            cell.textLabel.text=[[NSString alloc] initWithFormat:@"Tryck för att välja %@",[detailCellTitles objectAtIndex:indexPath.row]];
        }else{
            cell.textLabel.text=[game objectForKey:[keys objectAtIndex:indexPath.row+indexPath.section]];
        }
        
        return cell;
    }
    else if(indexPath.section==4&&indexPath.row==0){
        static NSString *CellIdentifier = @"LiveAndLockCell";
        LiveAndLockCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[LiveAndLockCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        if(mode==Edit){
            ///cell.live.on=([[game.live copy]integerValue]==1?YES:NO);
            //cell.lock.on=([[game.lock copy]integerValue]==1?YES:NO);
        }
        return cell;
    }else if(indexPath.section==4&&indexPath.row==1){
        static NSString *CellIdentifier = @"ResultCell";
        ResultCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[ResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.game=game;
        cell.spreadsheet=spreadsheet;
        self.resultCellIndexPath=indexPath;
        if (mode==Edit) {
            if ([[game objectForKey:@"result"] characterAtIndex:0]=='-'&&[[game objectForKey:@"isalive"] integerValue]==0) {
                [cell.loss toggle:cell.loss];
            }else if([[game objectForKey:@"result"] integerValue]==0&&[[game objectForKey:@"isalive"] integerValue]==0){
                [cell.push toggle:cell.push];
            }else if([[game objectForKey:@"result"] characterAtIndex:0]!='-'&&[[game objectForKey:@"isalive"] integerValue]==0){
                [cell.win toggle:cell.win];
            }
        }
        UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] 
                                              initWithTarget:self action:@selector(handleLongPress:)];
        lpgr.minimumPressDuration = 0.5; //seconds
        lpgr.delegate=self;
        [cell addGestureRecognizer:lpgr];
        return cell;
    }else{
        static NSString *CellIdentifier = @"LayGameCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        if(mode==Edit){
            cell.textLabel.text=@"Utför ändring";
            cell.textLabel.textAlignment=UITextAlignmentCenter;
        }
        return cell;
    }
}
-(IBAction)pickerDoneClicked:(id)sender{
    UIBarButtonItem *btn=(UIBarButtonItem*)sender;
    if (btn.tag==1) {
        TextFieldCell *tmp=(TextFieldCell*)[self.tableView cellForRowAtIndexPath:dateCellIndexPath];
        UIDatePicker *picker= (UIDatePicker*)tmp.cellTextField.inputView;
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        [outputFormatter setDateFormat:@"yyyy-MM-dd"];
        tmp.cellTextField.text=[outputFormatter stringFromDate:picker.date];
        [tmp textFieldReturn:tmp.cellTextField];
    }else if(btn.tag==2){
        TextFieldCell *tmp=(TextFieldCell*)[self.tableView cellForRowAtIndexPath:timeCellIndexPath];
        UIDatePicker *picker= (UIDatePicker*)tmp.cellTextField.inputView;
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        [outputFormatter setDateFormat:@"HH:mm"];
        tmp.cellTextField.text=[outputFormatter stringFromDate:picker.date];
        [tmp textFieldReturn:tmp.cellTextField];
    }
}
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag==1&&indexPath.row==[tableView numberOfRowsInSection:0]-1){
        [self.tableView cellForRowAtIndexPath:currentCellIndexPath].textLabel.text=((TextFieldCell*)[tableView cellForRowAtIndexPath:indexPath]).cellTextField.text;
        [self.navigationController popViewControllerAnimated:YES];
    }else if(tableView.tag==1){
        [self.tableView cellForRowAtIndexPath:currentCellIndexPath].textLabel.text=[tableView cellForRowAtIndexPath:indexPath].textLabel.text;
        [self.content setValue:[tableView cellForRowAtIndexPath:indexPath].textLabel.text forKey:[[NSString alloc]initWithFormat:@"%i",currentCellIndexPath.row+currentCellIndexPath.section]];
        [self.navigationController popViewControllerAnimated:YES];
    }else if(mode!=View&&indexPath.section==self.tableView.numberOfSections-1){
        [self layGame];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"pushDetail"]){
        ArrayTableViewController *detailViewController=segue.destinationViewController;
        detailViewController.tableView.delegate=self;
        NSIndexPath *indexPath=[self.tableView indexPathForCell:sender];
        detailViewController.title=[detailCellTitles objectAtIndex:indexPath.row];
        detailViewController.tableView.tag=1;
        currentCellIndexPath=indexPath;
        detailViewController.dataArray=[dataValues objectAtIndex:indexPath.row];
    }
}
-(void)layGame{
    /*
    if (mode==Add) {
        game=[[Game alloc]init];
    }
    game.home=[self stringFromTextfieldCellAtRow:0 InSection:0];
    
    game.away=[self stringFromTextfieldCellAtRow:0 InSection:1];
    
    game.league=[self stringFromTextfieldCellAtRow:0 InSection:2];
    game.country=[self stringFromTextfieldCellAtRow:1 InSection:2];
    game.period=[self stringFromTextfieldCellAtRow:2 InSection:2];
    game.sport=[self stringFromTextfieldCellAtRow:3 InSection:2];
    game.company=[self stringFromTextfieldCellAtRow:4 InSection:2];
    game.sign=[self stringFromTextfieldCellAtRow:5 InSection:2];
    int i=5;
    game.sign2=[self stringFromTextfieldCellAtRow:0+i InSection:3];
    game.date=[self stringFromTextfieldCellAtRow:1+i InSection:3];
    game.time=[self stringFromTextfieldCellAtRow:2+i InSection:3];
    game.info=[self stringFromTextfieldCellAtRow:3+i InSection:3];
    game.rekare=[self stringFromTextfieldCellAtRow:4+i InSection:3];
    game.odds=[self stringFromTextfieldCellAtRow:5+i InSection:3];
    game.stake=[self stringFromTextfieldCellAtRow:6+i InSection:3];
    game.result=[self stringFromTextfieldCellAtRow:7+i InSection:3];

    
    LiveAndLockCell *temp=(LiveAndLockCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:4]];
    game.live=[[NSMutableString alloc] initWithFormat:@"%i",temp.live.on];
    game.lock=[[NSMutableString alloc] initWithFormat:@"%i",temp.lock.on];
    
    game.isAlive=@"1";
    if (mode==Add) {
        [networkMediator addOrEdit:Add Game:game toSheet:spreadsheet];
    }else{
        [networkMediator addOrEdit:Edit Game:game toSheet:spreadsheet];
    }
    */
    NSLog(@"laygame %@",spreadsheet);
}

-(NSMutableString*)stringFromTextfieldCellAtRow:(NSInteger)row InSection:(NSInteger) section{
    NSString *temp=[content valueForKey:[[NSString alloc]initWithFormat:@"%i",row+section]];
    if (!temp) {
        temp=@""; 
    }
    return [NSMutableString stringWithString:temp];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //check if the index actually exists
    if(resultCellIndexPath&&[indexPath isEqual:resultCellIndexPath]) {
        if (resultCellExpanded) {
            return 80;
        }
    }
    return 44;
}
-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    ResultCell *cell=(ResultCell*)[self.tableView cellForRowAtIndexPath:resultCellIndexPath];
    if (resultCellExpanded) {
        [self.tableView beginUpdates];
        [cell loadContentView];
        [self.tableView endUpdates];
    }else{
        [self.tableView beginUpdates];
        [cell removeContentView];
        [self.tableView endUpdates];
    }
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    resultCellExpanded=!resultCellExpanded;
    return YES;
}
@end
