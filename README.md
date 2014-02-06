## Self CheckIn App
This is an example iPad 'self-checkin' app. The scenario is that you are hosting a conference or an event and want to check in event attendees. Instead of you having to manually check people in, you have bunch of iPads that's running this app and allows people to self check themselves in.

## Main Objectives
1. The app should use native iOS SDK and connect to Salesforce 'Campaigns' to manage checkins.
2. Event organizers should be able to search for campaigns in their Salesforce Orgs and select the one they want.
	2.1 **NOTE** - Event attendees should NOT be able to search for other campaigns/events or change the campaigns (remember this is self-checkin app w/o people moderating it)
3. Attendees should be able to enter their email id or event id to lookup and check in.
4. Allow registering **new** attendees i.e. Create them as **Leads** and associate them to the current campaign.

#The Storyboard
This app uses XCode's storyboard that like below. Storyboards provides an easy way to organize  flows, so I highly recommend using it.

<p align='center'>
  <img src="https://raw2.github.com/rajaraodv/CheckIn/master/pics/storyboard.png"/> 

#How It Works

1. The event organizer logs in.
<p align='center'>
  <img src="https://raw2.github.com/rajaraodv/CheckIn/master/pics/oauthLogin.png"/ style='height:400px'> 