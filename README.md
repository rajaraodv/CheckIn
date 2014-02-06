## Self Check-In App
This is an example iPad 'self check-in' app. The scenario is that you are hosting a conference or an event and want to check in event attendees. Instead of you having to manually check people in, you have bunch of iPads that's running this app and allows people to self check themselves in.

## Main Objectives
1. The app should use native iOS SDK and connect to Salesforce 'Campaigns' to manage checkins.
2. Event organizers should be able to search for campaigns in their Salesforce Orgs and select the one they want.
	2.1 **NOTE** - Event attendees should NOT be able to search for other campaigns/events or change the campaigns (remember this is self check in app w/o people moderating it)
3. Attendees should be able to enter their email id or event id to lookup and check in.
	3.1 Self Check-In changes CampaignMember status to **Responded** (In a real app, you should probably change it to a custom value like: **Checked In** or **Attended**)
4. Allow registering **new** attendees i.e. Create them as **Leads**, associate them to the current campaign with **Responded** status.

#The Storyboard
This app uses XCode's storyboard that like below. Storyboards provides an easy way to organize  flows, so I highly recommend using it.

<p align='center'>
  <img src="https://raw2.github.com/rajaraodv/CheckIn/master/pics/storyboard.png"/> 

#How It Works

1. The event organizer logs in to Salesforce using Native SDK's OAuth flow.
<p align='center'>
  <img src="https://raw2.github.com/rajaraodv/CheckIn/master/pics/oauthLogin.png"/ style='height:400px'> 
  
2. Organizer is presented with a list of Campaigns. Organizer can also search for Campaigns.
<p align='center'>
  <img src="https://raw2.github.com/rajaraodv/CheckIn/master/pics/campaignsList.png"/ style='height:400px'> 
  
3. The app opens up "Look Up" screen as a modal **without back-button**. i.e. Users can search using their email but can't go back to step 2. Event organizers have to logout and re-login if they have to change campaigns.

<p align='center'>
  <img src="https://raw2.github.com/rajaraodv/CheckIn/master/pics/lookUp.png"/ style='height:400px'> 
  
4. Attendees can self checkin. (Clicking **Cancel** will take them back to LookUp screen)

<p align='center'>
  <img src="https://raw2.github.com/rajaraodv/CheckIn/master/pics/checkInSuccessful.png"/ style='height:400px'> 
  
5. Registration - New attendees can click on Registrat button in **Look Up** view from step 3 and open up register and checkin screen. This creates them as **Leads**, associates them to the current event and changes their status to **Responded**

  <img src="https://raw2.github.com/rajaraodv/CheckIn/master/pics/registerAndCheckIn.png"/ style='height:400px'> 
  
  
## Log Out
Salesforce SDK **automatically adds a Log Out button** inside Settings (so we don't have to worry about it, yay!)
  <img src="https://raw2.github.com/rajaraodv/CheckIn/master/pics/logoutInSettings.png"/ style='height:400px'> 	
  