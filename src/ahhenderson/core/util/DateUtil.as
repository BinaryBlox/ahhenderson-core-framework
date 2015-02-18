package ahhenderson.core.util
{
	

	//
	// This class is deprecated, move to DateUtil.
	//
	public class DateUtil
	{
		// GOTCHA: The Date object in Flash returns a 0 based month value. So, December is 11, not 12.
		
		public static const MILLISECOND:Number = 1;
		public static const SECOND:Number = MILLISECOND * 1000;
		public static const MINUTE:Number = SECOND * 60;
		public static const HOUR:Number = MINUTE * 60;
		public static const DAY:Number = HOUR * 24;
		public static const WEEK:Number = DAY * 7;
		
		
		public static const ADD_YEARS:String = "fullYear";
		public static const ADD_MONTHS:String = "month";
		public static const ADD_DATE:String = "date";
		public static const ADD_HOURS:String = "hours";
		public static const ADD_MINUTES:String = "minutes";
		public static const ADD_SECONDS:String = "seconds";
		public static const ADD_MILLISECONDS:String = "milliseconds";
		
	 
		public static function getDateFromTime(time:Number):Date
		{
			const dateFromTime:Date = new Date();
			
			dateFromTime.time = time;
			
			return dateFromTime;
		}
		
		public static function getDateFromFormat1(s:String):Date
		{
			var a:Array = s.split(" ");
			var theDate:String = a[0];
			var theTime:String = a[1];
			
			var dateArray:Array = theDate.split("-");
			var year:Number = parseInt(dateArray[0]);
			var month:Number = parseInt(dateArray[1])-1;
			var day:Number = parseInt(dateArray[2]);
			
			var timeArray:Array = theTime.split(":");
			var hour:Number = parseInt(timeArray[0]);
			var minutes:Number = parseInt(timeArray[1]);
			var seconds:Number = parseInt(timeArray[2]);
			
			var d:Date = new Date(year, month, day, hour, minutes, seconds);
			return d;
		}
		
		public static function getDateRangeFormat( start:Date, end:Date, showYear:Boolean=true, useSummaryMonth:Boolean=false, phrase:String=""):String
		{ 
			
			var startMonth:String = (useSummaryMonth) ?  DateUtil.getSummarizeMonthName(start.month) : DateUtil.getMonthName(start.month);
			var startDay:String = start.date.toString() 
			var endDay:String = end.date.toString() 
			var dayOfWeek:String = DateUtil.getDayOfWeek(start.day);
			var year:String = ", " + start.fullYear.toString();
			
			var dateLabel:String = phrase + startMonth + " " + startDay + "-" + endDay;
			
			return  (showYear) ? dateLabel + year : dateLabel; 
		}
		
		public static function getWeekRangeFormat(start:Date, showYear:Boolean=true, phrase:String=""):String
		{ 
			
			var startMonth:String = DateUtil.getMonthName(start.month);
			var startDay:String = start.date.toString() 
			var dayOfWeek:String = DateUtil.getDayOfWeek(start.day);
			var year:String = start.fullYear.toString();
			var dateLabel:String = phrase   + startMonth + " " + startDay + " " + year + " - " + startMonth + " " + startDay;
			
			return  (showYear) ? dateLabel + ", " + year : dateLabel; 
		}
		
		public static function getMonthRangeFormat( start:Date=null, showYear:Boolean=true, phrase:String=""):String
		{ 
			
			var startMonth:String = DateUtil.getMonthName(start.month);
			var startDay:String = start.date.toString() 
			var dayOfWeek:String = DateUtil.getDayOfWeek(start.day);
			var year:String = start.fullYear.toString();
			var dateLabel:String = phrase + startMonth;
			
			return  (showYear) ? dateLabel + " " + year : dateLabel; 
		}
		
		public static function getFullDateFormat(date:Date, showYear:Boolean=false):String
		{ 
			var month:String = DateUtil.getMonthName(date.month);
			var day:String = date.date.toString()
			var dayOfWeek:String = DateUtil.getDayOfWeek(date.day);
			var year:String = date.fullYear.toString();
			 
			return  (showYear) ? dayOfWeek +", " + month + " " + day + "  " + year : dayOfWeek +", " + month + " " + day 
		}
		
		public static function getSummaryDateFormat(date:Date, showMonth:Boolean=true, showYear:Boolean=true):String
		{ 
			var month:String = DateUtil.getSummarizeMonthName(date.month);
			var day:String = date.date.toString()
			var dayOfWeek:String = DateUtil.getSummarizedDayOfWeek(date.day);
			var year:String = date.fullYear.toString(); 
			
			var formattedDate:String = (showMonth) ?  dayOfWeek + ", " + month + " " + day :  dayOfWeek + "  " + day;
			
			return  (showYear) ? formattedDate + "  " + year :  formattedDate; 
		}
		
		public static function getSummaryDateFormat2(date:Date, showMonth:Boolean=true, showYear:Boolean=true):String
		{ 
			var month:String = DateUtil.getSummarizeMonthName(date.month);
			var day:String = date.date.toString()
			var dayOfWeek:String = DateUtil.getSummarizedDayOfWeek(date.day);
			var year:String = date.fullYear.toString(); 
			
			var formattedDate:String = (showMonth) ?  month + " " + day :  day;
			
			return  (showYear) ? formattedDate + "  " + year :  formattedDate; 
		}
		
		public static function getDateFromSlashFormat(s:String):Date
		{
			var dateArray:Array = s.split("/");
			var year:Number = parseInt(dateArray[2]);
			var month:Number = parseInt(dateArray[0])-1;
			var day:Number = parseInt(dateArray[1]);
			
			var d:Date = new Date(year, month, day);
			return d;
		}
		
		public static function addTo(dOriginal:Date, nYears:Number = 0, nMonths:Number = 0, nDays:Number = 0, nHours:Number = 0, nMinutes:Number = 0, nSeconds:Number = 0, nMilliseconds:Number = 0):Date {
			var dNew:Date = new Date(dOriginal.getTime());
			dNew.setFullYear(dNew.getFullYear() + nYears);
			dNew.setMonth(dNew.getMonth() + nMonths);
			dNew.setDate(dNew.getDate() + nDays);
			dNew.setHours(dNew.getHours() + nHours);
			dNew.setMinutes(dNew.getMinutes() + nMinutes);
			dNew.setSeconds(dNew.getSeconds() + nSeconds);
			dNew.setMilliseconds(dNew.getMilliseconds() + nMilliseconds);
			return dNew;
		}		
		
		public static function offsetTimezone(dOne:Date):Date {
			// compensates for timezone offset math: 
			// timezoneOffset = the difference, in minutes, between universal time (UTC) and the computer's local time. 
			// Specifically, this value is the number of minutes you need to add to the computer's local time to equal UTC
			return addTo(dOne, 0, 0, 0, 0, dOne.getTimezoneOffset());
		}
		
		private static function elapsedDate(dOne:Date, dTwo:Date = null):Date {
			if(dTwo == null) {
				dTwo = new Date();
			}
			return new Date(dOne.getTime() - dTwo.getTime());
		}
		
		public static function elapsedMilliseconds(dOne:Date, dTwo:Date = null, bDisregard:Boolean = false):Number {
			if(bDisregard) {
				return elapsedDate(dOne, dTwo).millisecondsUTC;
			}
			else {
				return (dOne.getTime() - dTwo.getTime());
			}
		}
		
		public static function elapsedSeconds(dOne:Date, dTwo:Date = null, bDisregard:Boolean = false):Number {
			if(bDisregard) {
				return (elapsedDate(dOne, dTwo).secondsUTC);
			}
			else {
				return Math.floor(elapsedMilliseconds(dOne, dTwo) / SECOND);
			}
		}
		
		public static function elapsedMinutes(dOne:Date, dTwo:Date = null, bDisregard:Boolean = false):Number {
			if(bDisregard) {
				return (elapsedDate(dOne, dTwo).minutesUTC);
			}
			else {
				return Math.floor(elapsedMilliseconds(dOne, dTwo) / MINUTE);
			}
		}
		
		public static function elapsedHours(dOne:Date, dTwo:Date = null, bDisregard:Boolean = false):Number {
			if(bDisregard) {
				return (elapsedDate(dOne, dTwo).hoursUTC);
			}
			else {
				return Math.floor(elapsedMilliseconds(dOne, dTwo) / HOUR);
			}
		}
		
		public static function elapsedDays(dOne:Date, dTwo:Date = null, bDisregard:Boolean = false):Number {
			if(bDisregard) {
				return (elapsedDate(dOne, dTwo).dateUTC);
			}
			else {
				return Math.floor(elapsedMilliseconds(dOne, dTwo) / DAY);
			}
		}
		
		public static function elapsedMonths(dOne:Date, dTwo:Date = null, bDisregard:Boolean = false):Number {
			if(bDisregard) {
				return (elapsedDate(dOne, dTwo).monthUTC);
			}
			else {
				return (elapsedDate(dOne, dTwo).monthUTC + elapsedYears(dOne, dTwo) * 12);
			}
		}
		
		public static function elapsedYears(dOne:Date, dTwo:Date = null):Number {
			return (elapsedDate(dOne, dTwo).fullYearUTC - 1970);
		}
		
		public static function elapsed(dOne:Date, dTwo:Date = null):Object {
			var oElapsed:Object = new Object();
			oElapsed.years = elapsedYears(dOne, dTwo);
			oElapsed.months = elapsedMonths(dOne, dTwo, true);
			oElapsed.days = elapsedDays(dOne, dTwo, true);
			oElapsed.hours = elapsedHours(dOne, dTwo, true);
			oElapsed.minutes = elapsedMinutes(dOne, dTwo, true);
			oElapsed.seconds = elapsedSeconds(dOne, dTwo, true);
			oElapsed.milliseconds = elapsedMilliseconds(dOne, dTwo, true);
			return oElapsed;
		}
		
		
		public static function getDaysInMonth(month:int, year:int):int {
			
			var inputDate:Date = new Date(year, month);
			var daysOfMonths:Array = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
			var numOfDays:uint = (inputDate.getFullYear()%4 == 0 && inputDate.getMonth() == 1 ? 29 : daysOfMonths[inputDate.getMonth()]);
			
			return numOfDays;
		}
		
		 
		
		public static function getSummaryMonthInNumber(month:String):Number {
			
			switch (month.toUpperCase()){
				
				case "JAN":
					return 1;
				case "FEB":
					return 2;
				case "MAR":
					return 3;
				case "APR":
					return 4;
				case "MAY":
					return 5;
				case "JUN":
					return 6;
				case "JUL":
					return 7;
				case "AUG":
					return 8;
				case "SEP":
					return 9;
				case "OCT":
					return 10;
				case "NOV":
					return 11;
				case "DEC":
					return 12;
				default:
					return 1;
			}
			
		}
		
		public static function getDayOfWeek(dayOfWeek:Number):String {
			
			switch (dayOfWeek){
				case 0:
					return "Sunday";
				case 1:
					return "Monday";
				case 2:
					return "Tuesday";
				case 3:
					return "Wednesday";
				case 4:
					return "Thursday";
				case 5:
					return "Friday";
				case 6:
					return "Saturday";
					
			}
			
			return null;
			
		}
		
		public static function getSummarizedDayOfWeek(dayOfWeek:Number):String {
			
			switch (dayOfWeek){
				case 0:
					return "Sun";
				case 1:
					return "Mon";
				case 2:
					return "Tues";
				case 3:
					return "Wed";
				case 4:
					return "Thu";
				case 5:
					return "Fri";
				case 6:
					return "Sat";
					
			}
			
			return null;
			
		}
		
		public static const monthLabelsList:Array = new Array(
			[ 
				{ label: "January"},
				{ label: "February"},
				{ label: "March"},
				{ label: "April"},
				{ label: "May"},
				{ label: "June"},
				{ label: "July"},
				{ label: "August"},
				{ label: "September"},
				{ label: "October"},
				{ label: "November"},
				{ label: "December"}
			]);
		
		
		public static const monthLabels:Array = new Array("January",
			"February",
			"March",
			"April",
			"May",
			"June",
			"July",
			"August",
			"September",
			"October",
			"November",
			"December");
		
		public static const monthLabelsSummary:Array = new Array("Jan",
			"Feb",
			"Mar",
			"Apr",
			"May",
			"Jun",
			"Jul",
			"Aug",
			"Sep",
			"Oct",
			"Nov",
			"Dec");
		
		
		
		public static const timeZoneLabelsList:Array = new Array(
			[ 
				{ label: "PT", value:0},
				{ label: "MT", value:1},
				{ label: "CT", value:2},
				{ label: "ET", value:3},
			]);
		
		
		
		public static function getTimezone():Number
		{
			// Create two dates: one summer and one winter
			var d1:Date = new Date( 0, 0, 1 )
			var d2:Date = new Date( 0, 6, 1 )
			
			// largest value has no DST modifier
			var tzd:Number = Math.max( d1.timezoneOffset, d2.timezoneOffset )
			
			// convert to milliseconds
			return tzd * 60000
		}
		
		public static function getDST( d:Date ):Number
		{
			var tzd:Number = getTimezone()
			var dst:Number = (d.timezoneOffset * 60000) - tzd
			return dst
		}
		
		
		public static function getYears(startYear:int=1900):Array
		{
			var curYear:Date = new Date();
			var yearsArray:Array = new Array();
			
			for(var i:int=startYear;i<curYear.getFullYear()+1;i++){
				
				yearsArray.push(i);
			}
			
			// Start with current year
			yearsArray.reverse();
			
			return yearsArray;
		}
		
		public static function getSummarizeMonthName(monthNumber:int):String
		{
			if(monthNumber >= 0 && monthNumber <= 11)
				return monthLabelsSummary[monthNumber];
			else 
				return null;
		}
		public static function getMonthName(monthNumber:int):String
		{
			if(monthNumber >= 0 && monthNumber <= 11)
				return monthLabels[monthNumber];
			else
				return null;
		}
		
		public static function dateAdd(datepart:String = "", number:Number = 0, date:Date = null):Date 
		{
			if (date == null) {
				/* Default to current date. */
				date = new Date();
			}
			
			var returnDate:Date = new Date(date.time);
			
			switch (datepart) 
			{
				case ADD_YEARS:
					break;
				case ADD_MONTHS:
					break;
				case ADD_DATE:
					break;
				case ADD_HOURS:
					break;
				case ADD_MINUTES:
					break;
				case ADD_SECONDS:
					break;
				case ADD_MILLISECONDS:
					returnDate[datepart] += number;
					break;
				
			}
			return returnDate;
		}
		
		
		
		public static function getFormattedTime(date:Date, is24Hr:Boolean=false, seconds:Boolean=false, useSingleCaps:Boolean=true):String
		{
			
			var hour:Number;
			var paddedMinutes:String=date.getMinutes().toString();
			var ampm:String;
			var formattedTime:String; 
			
			hour=date.getHours();
			
			if (date.getHours() > 11)
			{
				if(hour>12)
					hour=hour - 12;
				
				ampm = (useSingleCaps) ? "P" : "pm";
			}
			else
			{
				if (hour == 0)
					hour=12;
				
				ampm = (useSingleCaps) ? "A" : "am";				
			}
			
			if (date.getMinutes() < 10)
				paddedMinutes="0" + date.getMinutes();
			
			
			formattedTime=hour + ":" + paddedMinutes;
			
			if(seconds)
				formattedTime+= ":" +  date.getSeconds().toString();
			
			formattedTime+= ampm;
			
			return formattedTime;
			
		}
		
		public static function getFormattedTimeWithTimeZone(date:Date):String{
			
			var formattedTime:String;
			var offset:Number;
			var dispMin:String=date.getMinutes().toString();
			var dispHour:Number;
			var dispAmPm:String;
			var dispOffset:String;
			var plusMinus:String="-";
			
			// Hour format
			dispHour=date.getHours();
			
			if (date.getHours() > 11)
			{
				dispHour=dispHour - 12;
				dispAmPm = "P";
			}
			else
			{
				if (dispHour == 0)
					dispHour=12;
				
				dispAmPm = "A";				
			}
			
			// Minutes format
			if (date.getMinutes() < 10)
				dispMin="0" + date.getMinutes();
			
			// Timezone offset format			
			offset=new Date().timezoneOffset;
			
			if(offset<0)
				plusMinus ="+";
			
			dispOffset=" (GMT" + plusMinus + Number(offset / 60).toString() + ")";
			
			// Formatted result
			formattedTime=dispHour + ":" + dispMin + dispAmPm + dispOffset;
			
			return formattedTime;
			
		}
		
		 
		public static function getFormattedTimeZone(date:Date):String{
			
			var formattedTimeZone:String;
			var offset:Number; 
			var dispOffset:String;
			var plusMinus:String="-";
			var factor:Number; 
			// Timezone offset format			
			offset=new Date().timezoneOffset;
			
			if(date.month > 1){
				
				//TODO: forgot what to do here
				 
			}
				
			if(offset<0)
				plusMinus ="+";
			
			factor = Math.ceil(Number(offset / 60));
			
			switch(factor){
				
				case 7:
					formattedTimeZone =  " (Pacific)";
					break;
				
				case 8:
					formattedTimeZone =  " (Mountain)";
					break;
				
				case 9:
					formattedTimeZone =  " (Central)";
					break;
				
				case 10:
					formattedTimeZone =  " (Eastern)";
					break;
				
				default:
					formattedTimeZone = " (GMT" + plusMinus + factor.toString() + ")";
					break;
			}
			 
			
			return formattedTimeZone;
			
		}
		
		public static  function convertTimezoneOffset(date:Date, offsetSrcTzone:Number):Date
		{
			
			date=DateUtil.addTo(date, 0, 0, 0, 0, offsetSrcTzone);
			date=DateUtil.addTo(date, 0, 0, 0, 0, new Date().timezoneOffset);
			
			return date;
			
		}
		
		//*************************************************************************
		// NEW
		//*************************************************************************
		/**
		 * Converts an RFC string to a Date object.
		 */
		public static function fromRFC802(date:String):Date {
			// Passing in an RFC802 date to the Date constructor causes flash
			// to conveniently ignore the "GMT" timezone at the end, and assumes
			// that it's in the Local timezone.
			// If we additionally convert it back to GMT, then we're sweet.
			
			var outputDate:Date = new Date(date);
			outputDate = new Date(outputDate.time - outputDate.getTimezoneOffset()*1000*60);
			return outputDate;
		}
		
		/** 
		 * Converts a Date object to an RFC802-formatted string (GMT/UTC).
		 */
		public static function toRFC802 (date:Date):String {
			// example: Thu, 09 Oct 2008 01:09:43 GMT
			
			// Convert to GMT
			
			var output:String = "";
			
			// Day
			switch (date.dayUTC) {
				case 0: output += "Sun"; break;
				case 1: output += "Mon"; break;
				case 2: output += "Tue"; break;
				case 3: output += "Wed"; break;
				case 4: output += "Thu"; break;
				case 5: output += "Fri"; break;
				case 6: output += "Sat"; break;
			}
			
			output += ", ";
			
			// Date
			if (date.dateUTC < 10) {
				output += "0"; // leading zero
			}
			output += date.dateUTC + " ";
			
			// Month
			switch(date.month) {
				case 0: output += "Jan"; break;
				case 1: output += "Feb"; break;
				case 2: output += "Mar"; break;
				case 3: output += "Apr"; break;
				case 4: output += "May"; break;
				case 5: output += "Jun"; break;
				case 6: output += "Jul"; break;
				case 7: output += "Aug"; break;
				case 8: output += "Sep"; break;
				case 9: output += "Oct"; break;
				case 10: output += "Nov"; break;
				case 11: output += "Dec"; break;
			}
			
			output += " ";
			
			// Year
			output += date.fullYearUTC + " ";
			
			// Hours
			if (date.hoursUTC < 10) {
				output += "0"; // leading zero
			}
			output += date.hoursUTC + ":";
			
			// Minutes
			if (date.minutesUTC < 10) {
				output += "0"; // leading zero
			}
			output += date.minutesUTC + ":";
			
			// Seconds
			if (date.seconds < 10) {
				output += "0"; // leading zero
			}
			output += date.secondsUTC + " GMT";
			
			return output;
		}
		
		
		/**
		 * Compares two AS3 dates
		 *
		 * @returns areturning -1 if the first date is before the second, 
		 * 0 if the dates are equal, or 1 if the first date is after the second.
		 *
		 * @langversion 3.0
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @productversion Flex 4
		 */
		public static function compareDates (  date1 : Date,   date2 : Date) : Number
		{
			var date1Timestamp : Number = date1.getTime ();
			var date2Timestamp : Number = date2.getTime ();			
			var result : Number = -1;
			
			if (date1Timestamp == date2Timestamp)
			{
				result = 0;
			}
			else if (date1Timestamp > date2Timestamp)
			{
				result = 1;
			}
			
			return result;
		}

		/**
		 * Get age
		 * @param dateOfBirth
		 * @returns areturning -1 if the dateOfBirth is not valid, otherwise returns the correct age..
		 *
		 * @langversion 3.0
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @productversion Flex 4
		 */
		public static function getAge(dateOfBirth:Date):int
		{
			if(!dateOfBirth)
				return -1;
			
			const age:int = (new Date().fullYear - dateOfBirth.fullYear);  
			
			if(DateUtil.compareDates(DateUtil.addTo(new Date(), -age), dateOfBirth)<1)
				return age-1;
			
			return age;
		} 
		 
		
	}
}