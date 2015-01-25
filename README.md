ASP.NET Event Calendar
======================

This event calendar implements JQuery [FullCalendar](http://fullcalendar.io/) in ASP.NET.

Features of this event calendar
* Create single day events
* Create multiple day events
* Create all day events
* Update existing events
* Delte events
* You can add a name and description of the event
* When you hover over an event opens a modal window with more information about the event
* Drag & Drop events

### Libraries

* FullCalendar 2.0.3
* jQuery 2.1.1
* jQuery UI 1.11.1
* qTip 2.2.0

### Info

EventDAO class is the main class which interacts with the database and SQL Server express edition has been used. The event information is stored in a table named ‘event’ in the database.

### DB Table Format

	event_id			int [identity]
	description		VarChar(200)
	title					VarChar(100)
	event_start		DateTime
	event_end			DateTime
	all_day				Bit


**jgezau**
