# JSONAssignmentTemplate

Use this as the starting point for your unit 4 summative assignment.

For your own application, add sections below like I have, to describe the purpose of your app that makes use of a JSON data source.

*– Mr. Gordon*

## Cooling Centre Finder a.k.a. "Stay Cool TO"

The purpose of this application is to tell the user where the closest cooling centre is in Toronto, relative to their current location.

The application obtains a list of cooling centres available to the public when it is very hot outside. Overall description available here:

http://www1.toronto.ca/wps/portal/contentonly?vgnextoid=e7356d1900531510VgnVCM10000071d60f89RCRD

Quoting from the page:

"Toronto Public Health monitors the Heat Health Alert System every day from May 15 to September 30 each year, to alert those people most at risk of heat-related illness that hot weather conditions presently exist and to take appropriate precautions. One such precaution is the availability of buildings that are open to the general public that offer an air-conditioned space for temporary relief from the extreme heat."

The direct JSON data source being utilized is available here:

http://app.toronto.ca/opendata//ac_locations/locations.json

## Obtaining JSON from an insecure (HTTP) source

When you run an application in a full-fledged iOS application, default security settings disallow connections to insecure web hosts (HTTP vs. HTTPS).

If your JSON data source is being provided from an address that begins with *HTTP*, you will need to edit the *Info.plist* file like so:

![Edit info.plist as source code](/edit-info-plist.png)

Then add the following XML to the file:

	<key>NSAppTransportSecurity</key>
	<dict>
		<key>NSExceptionDomains</key>
		<dict>
			<key>app.toronto.ca</key>
			<dict>
				<key>NSTemporaryExceptionAllowsInsecureHTTPLoads</key>
				<true/>
			</dict>
		</dict>
	</dict>
	
Replace **app.toronto.ca** in the XML given above with the domain of the source of your JSON data file.

So for example, my JSON data source is:

http://app.toronto.ca/opendata//ac_locations/locations.json

I added **app.toronto.ca** to the XML above. You would replace this value with the domain of your own JSON data source.
