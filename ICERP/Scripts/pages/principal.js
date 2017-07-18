
$(function () {
    ////Date picker
    //$('#datepicker').datepicker({
    //    autoclose: true,
    //    days: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"],
    //    daysShort: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
    //    daysMin: ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"],
    //    months: ["January", "February", "March", "April", "May", "June", "July", "Agosto", "September", "October", "November", "December"],
    //    monthsShort: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
    //    today: "Today",
    //    clear: "Clear",
    //    format: "mm/dd/yyyy",
    //    titleFormat: "MM yyyy", /* Leverages same syntax as 'format' */
    //    weekStart: 0
    //});
    $('input[type="checkbox"].flat-red, input[type="radio"].flat-red').iCheck({
        checkboxClass: 'icheckbox_flat-red',
        radioClass: 'iradio_flat-red'
    });
    $("[data-mask]").inputmask();

    if (data)
        $('.sidebar-menu').append(data);

    $(".cuentaDominio").text(nombreDominio);
    $(".menuUsuario").html(nombreCompleto + "<small>" + rolUsuario + "</small>");
    $(".menuUsuarioIzq").html("<p>" + nombreCompleto + "</p>" + rolUsuario);
    //$(".sidebar .treeview").tree();
    $(".userImageLoad").attr("src", fotoUsuario);
});