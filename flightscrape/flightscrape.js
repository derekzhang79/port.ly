var request = require('request');
var cheerio = require('cheerio');


/*
 * input: inStr, date string scraped from html
 * input: day, date object representing the date of the flight
 *
 * output: inStr's date represented as a date object
 * 
 */
function strToDate(inStr, day) {
	var hours = parseInt(inStr.substring(0, 2));
	var minutes = parseInt(inStr.substring(3, 5));
	var timezone = inStr.substring(8, 11);
	
	if (inStr.charAt(5) == "P") {
		hours += 12;
	}
	
	var outStr = new Date(day);
	outStr.setHours(hours);
	outStr.setMinutes(minutes);
	
	var tmp = outStr.toString();
	tmp = tmp.substring(0,25);
	tmp = tmp.concat(timezone);
	outStr = new Date(tmp);
	return outStr;
}

/*
 * input: flight number in string form, e.g. "UAL450"
 * 
 * output: an associative array containing the following:
 * 		airlineName (string)
 *		status (string)
 *		fromAirportName (string)
 *		fromAirportCode (string)
 * 		toAirportName (string)
 *		toAirportCode (string)
 *		scheduledDeparture (JS date object)
 *		estimatedDeparture (JS date object)
 *		scheduledArrival (JS date object)
 *		estimatedArrival (JS date object)
 */
function getFlightData(flight) {

	urlTemplate = "http://flightaware.com/live/flight/";
	
	url = urlTemplate.concat(flight);
	
	request(url, function(error, response, html){
	
		if(!error){
			var $ = cheerio.load(html);
			
			var airlineName, flightDate, status,
			fromAirportName, fromAirportCode,
			toAirportName, toAirportCode,
			scheduledDeparture, estimatedDeparture,
			scheduledArrival, estimatedArrival;
			
			var flightData = { airlineName: "", status : "",
			fromAirportName : "", fromAirportCode: "",
			toAirportName : "", toAirportCode: "",
			scheduledDeparture : new Date(0), estimatedDeparture : new Date(0),
			scheduledArrival : new Date(0), estimatedArrival : new Date(0)};
			
			// airline name
			$('.track-panel-header-title').filter(function(){
				var data = $(this).children().first();
				
				var a = data.text();
				airlineName = a.split(" ")[1];//?
				
				flightData.airlineName = airlineName;
			})
			
			// status
			var i = 0
			$('.smallrow1').filter(function(){
				if (i == 0) {
					var data = $(this).children().first();
				
					var a = data.text();
					status = a;
				
					flightData.status = status;
					i+=1;
				}
			})
			
			// departing airport name and code
			$('.track-panel-departure').filter(function(){
				var data = $(this).children().first().children().first();
				
				var a = data.attr("title");
				fromAirportName = data.text();
				fromAirportCode = a.substring(a.length - 4);
				
				flightData.fromAirportName = fromAirportName;
				flightData.fromAirportCode = fromAirportCode;
			})
			
			// arriving airport name and code
			$('.track-panel-arrival').filter(function(){
				var data = $(this).children().first().children().first();
				
				var a = data.attr("title");
				toAirportName = data.text();
				toAirportCode = a.substring(a.length - 4);
				
				flightData.toAirportName = toAirportName;
				flightData.toAirportCode = toAirportCode;
			})
			
			// date of flight
			$('.track-panel-date').filter(function(){
				var data = $(this);
				flightDate = data.text().trim();
			})
			
			// estimated departure time, accounting for delays
			$('.track-panel-course').filter(function(){
				var data = $(this).children().first().children().first().next().children().first().children().first();	
				estimatedDeparture = strToDate(data.text(), flightDate);
				flightData.estimatedDeparture = estimatedDeparture;
			})
			
			// scheduled departure and arrival
			var i = 0;
			$('.track-panel-scheduledtime').filter(function(){
				var data = $(this).children().first().next();
				
				if (i == 0) {
					scheduledDeparture = strToDate(data.text().trim(), flightDate);
					flightData.scheduledDeparture = scheduledDeparture;
					i += 1;
				} else if (i == 1) {
					scheduledArrival = strToDate(data.text().trim(), flightDate);
					flightData.scheduledArrival = scheduledArrival;
				}
				
				
			})
			
			// estimated arrival time, accounting for delays
			$('.track-panel-course').filter(function(){
				var data = $(this).children().first().children().first().next().children().first().next().children().first();
				estimatedArrival = strToDate(data.text(), flightDate);
				flightData.estimatedArrival = estimatedArrival;
				
			})
			
			console.log(flightData);
			return flightData;
		}
	
	})
	
}

getFlightData("UA450");

/*new function that just returns estimated times & to airport code

latlong.net
takes address
gives lat and long

*/
