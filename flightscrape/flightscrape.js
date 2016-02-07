var request = require('request');
var cheerio = require('cheerio');

/*
 * input: flight number in string form, e.g. "UAL450"
 * 
 * output: an associative array containing strings representing
 * the arrival and departure airports and the respective arrival and
 * departure times
 *
 * author @martha
 */
function getFlightData(flight) {

	urlTemplate = "http://flightaware.com/live/flight/";
	
	url = urlTemplate.concat(flight);
	
	request(url, function(error, response, html){
	
		if(!error){
			var $ = cheerio.load(html);
			
			var fromAirport, toAirport, departTime, arriveTime;
			
			var flightData = { fromAirport : "", toAirport : "",
			departTime : "", arriveTime : ""};
			
			$('.track-panel-departure').filter(function(){
				var data = $(this).children().first().children().first();
				
				fromAirport = data.attr("title");
				
				flightData.fromAirport = fromAirport;
			})
			
			$('.track-panel-arrival').filter(function(){
				var data = $(this).children().first().children().first();
				
				toAirport = data.attr("title");
				
				flightData.toAirport = toAirport;
			})
			
			$('.track-panel-course').filter(function(){
				var data = $(this).children().first().children().first().next().children().first().children().first();
				
				var d, x, y;
				d = data.text();
				x = d.substring(0, 7);
				y = d.substring(8, 11);
				
				departTime = x.concat(" ", y);
				
				flightData.departTime = departTime;
			})
			
			$('.track-panel-course').filter(function(){
				var data = $(this).children().first().children().first().next().children().first().next().children().first();
				
				var a, x, y;
				a = data.text();
				x = a.substring(0, 7);
				y = a.substring(8, 11);
				
				arriveTime = x.concat(" ", y);
				flightData.arriveTime = arriveTime;
			})
			
			//test: console.log(flightData);
			return flightData;
		}
	
	})
	
}

//test: getFlightData("UA450");

