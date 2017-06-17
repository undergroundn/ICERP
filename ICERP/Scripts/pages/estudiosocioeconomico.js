$(document).ready(function () {

    //ICERP_Core.llamarAjax("EstudioSocioeconomico.aspx/obtenerTiposConsultorios", null, "crearControlTiposConsultorios");

    //ICERP_Core.llamarAjax("EstudioSocioeconomico.aspx/obtenerConsultorios", null, "crearTablaConsultorios");

    $("#btnGuardarEstudioSE").click(function (ev) {
        var isValid = ICERP_Core.validarFormulario('registrarEstudioSE');
        if (!isValid) {
            ICERP_Core.reiniciarValidación('registrarEstudioSE');
            ev.preventDefault();
            return;
        }
        guardarEstudioSE();
    });

    
});
function guardarEstudioSE() {
    //var nombre = $("#txtNombreConsultorio").val();
    //var planta = ($("#sltPlanta").val() == "1");
    //var activo = $("#chkActivo").prop('checked');

    //var consultorio = new Object();
    //consultorio.Nombre = nombre;
    //consultorio.Planta = planta;
    //consultorio.Activo = activo;
    //consultorio.ConsultoriosTipos = [];

    //$(".tiposConsultorios").each(function () {
    //    var checked = $(this).prop('checked');
    //    if (checked) {
    //        var idTipo = Number($(this).val());
    //        var consultorioTipo = new Object();
    //        consultorioTipo.IdTipo = idTipo;
    //        consultorio.ConsultoriosTipos.push(consultorioTipo);
    //    }
    //});

    //ICERP_Core.bloquearPantalla();
    //ICERP_Core.llamarAjax("Consultorios.aspx/guardarConsultorio", "{ 'consultorio': " + JSON.stringify(consultorio) + "}", "consultorioGuardado");
}