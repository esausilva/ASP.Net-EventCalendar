<%@ WebHandler Language="C#" Class="JsonResponse" %>

using System;
using System.Web;
using System.Collections;
using System.Collections.Generic;
using System.Web.SessionState;

public class JsonResponse : IHttpHandler, IRequiresSessionState 
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";

        //Convert from UTC timestamp to local datetime
        // FullCalendar 1.x
        //DateTime start = ConvertFromTimeStamp(long.Parse(context.Request.QueryString["start"]));
        //DateTime end = ConvertFromTimeStamp(long.Parse(context.Request.QueryString["end"]));

        // FullCalendar 2.x
        DateTime start = Convert.ToDateTime(context.Request.QueryString["start"]);
        DateTime end = Convert.ToDateTime(context.Request.QueryString["end"]);

        List<int> idList = new List<int>();
        List<ImproperCalendarEvent> tasksList = new List<ImproperCalendarEvent>();

        //Generate JSON serializable events
        foreach (CalendarEvent cevent in EventDAO.getEvents(start, end))
        {
            tasksList.Add(new ImproperCalendarEvent
            {
                id = cevent.id,
                title = cevent.title,
                
                // FullCalendar 1.x
                //start = ConvertToTimestamp(Convert.ToDateTime(cevent.start).ToUniversalTime()).ToString(),
                //end = ConvertToTimestamp(Convert.ToDateTime(cevent.end).ToUniversalTime()).ToString(),

                // FullCalendar 2.x
                start = String.Format("{0:s}", cevent.start),
                end = String.Format("{0:s}", cevent.end),
                
                description = cevent.description,
                allDay = cevent.allDay,
            }
                );
            idList.Add(cevent.id);
        }

        context.Session["idList"] = idList;

        //Serialize events to string
        System.Web.Script.Serialization.JavaScriptSerializer oSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        string sJSON = oSerializer.Serialize(tasksList);

        //Write JSON to response object
        context.Response.Write(sJSON);
    }

    public bool IsReusable {
        get { return false; }
    }

    // FullCalendar 1.x Methods *******
    
    /// <summary>
    /// Converts a UTC transformed timestamp into a local datetime
    /// </summary>
    /// <param name="timestamp"></param>
    /// <returns></returns>
    //private DateTime ConvertFromTimeStamp(long timestamp) {
    //    long ticks = (timestamp * 10000000) + 621355968000000000;
    //    return new DateTime(ticks, DateTimeKind.Utc).ToLocalTime();
    //}

    //private static readonly DateTime Epoch = new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc);

    //private static long ConvertToTimestamp(DateTime value) {
    //    TimeSpan elapsedTime = value - Epoch;
    //    return (long)elapsedTime.TotalSeconds;
    //}

    //private String convertCalendarEventIntoString(CalendarEvent cevent) {
    //    String allDay = "true";

    //    if (ConvertToTimestamp(cevent.start).ToString().Equals(ConvertToTimestamp(cevent.end).ToString())) {
    //        if (cevent.start.Hour == 0 && cevent.start.Minute == 0 && cevent.start.Second == 0) {
    //            allDay = "true";
    //        }
    //        else {
    //            allDay = "false";
    //        }
    //    }
    //    else {
    //        if (cevent.start.Hour == 0 && cevent.start.Minute == 0 && cevent.start.Second == 0
    //            && cevent.end.Hour == 0 && cevent.end.Minute == 0 && cevent.end.Second == 0) {
    //            allDay = "true";
    //        }
    //        else {
    //            allDay = "false";
    //        }
    //    }
    //    return "{" +
    //              "id: '" + cevent.id + "'," +
    //              "title: '" + HttpContext.Current.Server.HtmlEncode(cevent.title) + "'," +
    //              "start:  " + ConvertToTimestamp(cevent.start).ToString() + "," +
    //              "end: " + ConvertToTimestamp(cevent.end).ToString() + "," +
    //              "allDay:" + allDay + "," +
    //              "description: '" + HttpContext.Current.Server.HtmlEncode(cevent.description) + "'" +
    //              "},";
    //}
}