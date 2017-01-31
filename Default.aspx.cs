using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;

public partial class _Default : System.Web.UI.Page
{
    //this method only updates title and description
    //this is called when a event is clicked on the calendar
    [System.Web.Services.WebMethod(true)]
    public static string UpdateEvent(CalendarEvent cevent)
    {
        List<int> idList = (List<int>)System.Web.HttpContext.Current.Session["idList"];
        if (idList != null && idList.Contains(cevent.id))
        {
            if (CheckAlphaNumeric(cevent.title) && CheckAlphaNumeric(cevent.description))
            {
                EventDAO.updateEvent(cevent.id, cevent.title, cevent.description);

                return "updated event with id:" + cevent.id + " update title to: " + cevent.title +
                " update description to: " + cevent.description;
            }

        }

        return "unable to update event with id:" + cevent.id + " title : " + cevent.title +
            " description : " + cevent.description;
    }

    //this method only updates start and end time
    //this is called when a event is dragged or resized in the calendar
    [System.Web.Services.WebMethod(true)]
    public static string UpdateEventTime(ImproperCalendarEvent improperEvent)
    {
        List<int> idList = (List<int>)System.Web.HttpContext.Current.Session["idList"];
        if (idList != null && idList.Contains(improperEvent.id))
        {
            EventDAO.updateEventTime(improperEvent.id,
                                     Convert.ToDateTime(improperEvent.start),
                                     Convert.ToDateTime(improperEvent.end),
                                     improperEvent.allDay);  //allDay parameter added for FullCalendar 2.x

            return "updated event with id:" + improperEvent.id + " update start to: " + improperEvent.start +
                " update end to: " + improperEvent.end;
        }

        return "unable to update event with id: " + improperEvent.id;
    }

    //called when delete button is pressed
    [System.Web.Services.WebMethod(true)]
    public static String deleteEvent(int id)
    {
        //idList is stored in Session by JsonResponse.ashx for security reasons
        //whenever any event is update or deleted, the event id is checked
        //whether it is present in the idList, if it is not present in the idList
        //then it may be a malicious user trying to delete someone elses events
        //thus this checking prevents misuse
        List<int> idList = (List<int>)System.Web.HttpContext.Current.Session["idList"];
        if (idList != null && idList.Contains(id))
        {
            EventDAO.deleteEvent(id);
            return "deleted event with id:" + id;
        }

        return "unable to delete event with id: " + id;
    }

    //called when Add button is clicked
    //this is called when a mouse is clicked on open space of any day or dragged 
    //over mutliple days
    [System.Web.Services.WebMethod]
    public static int addEvent(ImproperCalendarEvent improperEvent)
    {
        CalendarEvent cevent = new CalendarEvent() {
            title = improperEvent.title,
            description = improperEvent.description,
            start = Convert.ToDateTime(improperEvent.start),
            end = Convert.ToDateTime(improperEvent.end),
            allDay = improperEvent.allDay
        };

        if (CheckAlphaNumeric(cevent.title) && CheckAlphaNumeric(cevent.description))
        {
            int key = EventDAO.addEvent(cevent);

            List<int> idList = (List<int>)System.Web.HttpContext.Current.Session["idList"];

            if (idList != null)
            {
                idList.Add(key);
            }

            return key; //return the primary key of the added cevent object
        }

        return -1; //return a negative number just to signify nothing has been added
    }

    private static bool CheckAlphaNumeric(string str)
    {
        return Regex.IsMatch(str, @"^[a-zA-Z0-9 ]*$");
    }
}
