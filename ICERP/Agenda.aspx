<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Agenda.aspx.cs" Inherits="ICERP.Agenda" %>

<asp:Content ID="AgendaHeadContent" ContentPlaceHolderID="headContent" runat="server">


    <script type="text/javascript">

        $(function () {

            /* initialize the external events
             -----------------------------------------------------------------*/
            function ini_events(ele) {
                ele.each(function () {

                    // create an Event Object (http://arshaw.com/fullcalendar/docs/event_data/Event_Object/)
                    // it doesn't need to have a start or end
                    var eventObject = {
                        title: $.trim($(this).text()) // use the element's text as the event title
                    };

                    // store the Event Object in the DOM element so we can get to it later
                    $(this).data('eventObject', eventObject);

                    // make the event draggable using jQuery UI
                    $(this).draggable({
                        zIndex: 1070,
                        revert: true, // will cause the event to go back to its
                        revertDuration: 0  //  original position after the drag
                    });

                });
            }

            ini_events($('#external-events div.external-event'));

            /* initialize the calendar
             -----------------------------------------------------------------*/
            //Date for the calendar events (dummy data)
            var date = new Date();
            var d = date.getDate(),
                m = date.getMonth(),
                y = date.getFullYear();

            //$('#calendar').fullCalendar({
            //    defaultView: 'agendaDay',
            //    defaultDate: '2016-05-07',
            //    editable: true,
            //    selectable: true,
            //    eventLimit: true, // allow "more" link when too many events
            //    header: {
            //        left: 'prev,next today',
            //        center: 'title',
            //        right: 'agendaDay,agendaTwoDay,agendaWeek,month'
            //    },
            //    views: {
            //        agendaTwoDay: {
            //            type: 'agenda',
            //            duration: { days: 2 },

            //             views that are more than a day will NOT do this behavior by default
            //             so, we need to explicitly enable it
            //            groupByResource: true

            //            // uncomment this line to group by day FIRST with resources underneath
            //            groupByDateAndResource: true
            //        }
            //    },

            //    // uncomment this line to hide the all-day slot
            //    allDaySlot: false,

            //    resources: [
            //        { id: 'a', title: 'Room A' },
            //        { id: 'b', title: 'Room B', eventColor: 'green' },
            //        { id: 'c', title: 'Room C', eventColor: 'orange' },
            //        { id: 'd', title: 'Room D', eventColor: 'red' }
            //    ],
            //    events: [
            //        { id: '1', resourceId: 'a', start: '2016-05-06', end: '2016-05-08', title: 'event 1' },
            //        { id: '2', resourceId: 'a', start: '2016-05-07T09:00:00', end: '2016-05-07T14:00:00', title: 'event 2' },
            //        { id: '3', resourceId: 'b', start: '2016-05-07T12:00:00', end: '2016-05-08T06:00:00', title: 'event 3' },
            //        { id: '4', resourceId: 'c', start: '2016-05-07T07:30:00', end: '2016-05-07T09:30:00', title: 'event 4' },
            //        { id: '5', resourceId: 'd', start: '2016-05-07T10:00:00', end: '2016-05-07T15:00:00', title: 'event 5' }
            //    ],

            //    select: function (start, end, jsEvent, view, resource) {
            //        console.log(
            //            'select',
            //            start.format(),
            //            end.format(),
            //            resource ? resource.id : '(no resource)'
            //        );
            //    },
            //    dayClick: function (date, jsEvent, view, resource) {
            //        console.log(
            //            'dayClick',
            //            date.format(),
            //            resource ? resource.id : '(no resource)'
            //        );
            //    }
            //});

            $('#calendar').fullCalendar({
                firstDay: 1,
                monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
                monthNamesShort: ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'],
                dayNames: ['Domingo', 'Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sábado'],
                dayNamesShort: ['Dom', 'Lun', 'Mar', 'Mie', 'Jue', 'Vie', 'Sab'],
                header: {

                    left: 'prev,next today',
                    center: 'title',
                    right: 'month,agendaWeek,agendaDay'
                },
                buttonText: {
                    prev: ' ◄ ',
                    next: ' ► ',
                    prevYear: ' &lt;&lt; ',
                    nextYear: ' &gt;&gt; ',
                    today: 'Hoy',
                    month: 'Mes',
                    week: 'Semana',
                    day: 'Día'
                },
                resources: [{ id: '1', title: 'Consultorio 1' },
                { id: '2', title: 'Consultorio 2' },
                { id: '3', title: 'Consultorio 3' },
                { id: '4', title: 'Consultorio 4' },
                { id: '5', title: 'Consultorio 5' }
                ],
                //Random default events
                events: [
                  {
                      resourceId: '1',
                      title: 'Paciente 1',
                      start: new Date(y, m, 1),
                      backgroundColor: "#f56954", //red
                      borderColor: "#f56954" //red
                  },
                  {
                      resourceId: '1',
                      title: 'Paciente 2',
                      start: new Date(y, m, d - 5),
                      end: new Date(y, m, d - 5),
                      backgroundColor: "#f39c12", //yellow
                      borderColor: "#f39c12" //yellow
                  },
                  {
                      resourceId: '2',
                      title: 'Paciente 3',
                      start: new Date(y, m, d, 10, 30),
                      allDay: false,
                      backgroundColor: "#0073b7", //Blue
                      borderColor: "#0073b7" //Blue
                  },
                  {
                      resourceId: '3',
                      title: 'Paciente 4',
                      start: new Date(y, m, d, 12, 0),
                      end: new Date(y, m, d, 14, 0),
                      allDay: false,
                      backgroundColor: "#00c0ef", //Info (aqua)
                      borderColor: "#00c0ef" //Info (aqua)
                  },
                  {
                      resourceId: '3',
                      title: 'Paciente 5',
                      start: new Date(y, m, d + 1, 19, 0),
                      end: new Date(y, m, d + 1, 22, 30),
                      allDay: false,
                      backgroundColor: "#00a65a", //Success (green)
                      borderColor: "#00a65a" //Success (green)
                  },
                  {
                      resourceId: '4',
                      title: 'Paciente 6',
                      start: new Date(y, m, 28),
                      end: new Date(y, m, 29),
                      //url: 'http://google.com/',
                      backgroundColor: "#3c8dbc", //Primary (light-blue)
                      borderColor: "#3c8dbc" //Primary (light-blue)
                  }
                ],
                editable: true,
                droppable: true, // this allows things to be dropped onto the calendar !!!
                drop: function (date, allDay) { // this function is called when something is dropped

                    // retrieve the dropped element's stored Event Object
                    var originalEventObject = $(this).data('eventObject');

                    // we need to copy it, so that multiple events don't have a reference to the same object
                    var copiedEventObject = $.extend({}, originalEventObject);

                    // assign it the date that was reported
                    copiedEventObject.start = date;
                    copiedEventObject.allDay = allDay;
                    copiedEventObject.backgroundColor = $(this).css("background-color");
                    copiedEventObject.borderColor = $(this).css("border-color");

                    // render the event on the calendar
                    // the last `true` argument determines if the event "sticks" (http://arshaw.com/fullcalendar/docs/event_rendering/renderEvent/)
                    $('#calendar').fullCalendar('renderEvent', copiedEventObject, true);

                    // is the "remove after drop" checkbox checked?
                    if ($('#drop-remove').is(':checked')) {
                        // if so, remove the element from the "Draggable Events" list
                        $(this).remove();
                    }

                }
            });







            /* ADDING EVENTS */
            var currColor = "#3c8dbc"; //Red by default
            //Color chooser button
            var colorChooser = $("#color-chooser-btn");
            $("#color-chooser > li > a").click(function (e) {
                e.preventDefault();
                //Save color
                currColor = $(this).css("color");
                //Add color effect to button
                $('#add-new-event').css({ "background-color": currColor, "border-color": currColor });
            });
            $("#add-new-event").click(function (e) {
                e.preventDefault();
                //Get value and make sure it is not null
                var val = $("#new-event").val();
                if (val.length == 0) {
                    return;
                }

                //Create events
                var event = $("<div />");
                event.css({ "background-color": currColor, "border-color": currColor, "color": "#fff" }).addClass("external-event");
                event.html(val);
                $('#external-events').prepend(event);

                //Add draggable funtionality
                ini_events(event);

                //Remove event from text input
                $("#new-event").val("");
            });
        });


    </script>
</asp:Content>
<asp:Content ID="AgendaBodyContent" ContentPlaceHolderID="bodyContent" runat="server">
    <section class="content">
        <div class="row">

            <div class="box box-danger">
                <div class="box-body no-padding">
                    <!-- THE CALENDAR -->
                    <div id="calendar"></div>
                </div>
            </div>

        </div>
    </section>
</asp:Content>
