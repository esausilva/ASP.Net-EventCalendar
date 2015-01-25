using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

//Do not use this object, it is used just as a go between between javascript and asp.net
public class ImproperCalendarEvent
{
    public int id { get; set; }
    public string title { get; set; }
    public string description { get; set; }
    public string start { get; set; }
    public string end { get; set; }
    public bool allDay { get; set; }
}
