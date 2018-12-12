# ASP.NET Event Calendar

This event calendar implements JQuery [FullCalendar](http://fullcalendar.io/) in ASP.NET.

Features of this event calendar

- Create single day events
- Create multiple day events
- Create all day events
- Update existing events
- Delte events
- You can add a name and description of the event
- When you hover over an event opens a modal window with more information about the event
- Drag & Drop events
- Rezise events

### Libraries

- [FullCalendar 3.1.0](https://fullcalendar.io/)
- [jQuery 3.1.1](https://jquery.com/)
- [jQuery UI 1.12.1](http://jqueryui.com/)
- [qTip 3.0.3](http://qtip2.com/)
- [Moment.js 2.17.1](http://momentjs.com/)

## Info

`EventDAO` class is the main class which interacts with the database and SQL Server express edition has been used. The event information is stored in a table named `Event` in the database.

### DB Table Format

| Column Name | Data Type      |
| ----------- | -------------- |
| event_id    | int [identity] |
| title       | VarChar(100)   |
| description | VarChar(200)   |
| event_start | DateTime       |
| event_end   | DateTime       |
| all_day     | Bit            |

To open the project, just open Visual Studio then **File -> Open Website** and select the solution folder

**Note:** For .NET Core version, visit my other repo: [FullCalendar .NET Core with Visual Studio](https://github.com/esausilva/fullcalendar-aspnet-core)

## Giving Back

If you would like to support my work and the time I put in making tutorials, you can click the image below to get me a coffee. I would really appreciate it (but is not required).

[![Buy Me A Coffee](https://www.buymeacoffee.com/assets/img/custom_images/black_img.png)](https://www.buymeacoffee.com/esausilva)

## Preview

![Imgur](http://i.imgur.com/B0FqAp9l.png)

**Esau Silva**
