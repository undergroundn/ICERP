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
    //usuario encuestador
    var nombreusuario = $("#nombreusuario").val();//poner autocomplete de usuarios registrados
    var fecha = $("#fecha").val();//poner datepicker con fecha actual
    //datos generales
    var nombre = $("#nombre").val();
    var apPaterno = $("#apPaterno").val();
    var apMaterno = $("#apMaterno").val();
    var idDomicilio = 1;
    var estadocivil = $("#estadocivil").val();
    var Telefonocasa = $("#Telefonocasa").val();
    var Telefonocelular = $("#Telefonocelular").val();

    //domicilio
    //var idColonia
    var calle = $("#calle").val();
    var numExt = $("#numExt").val();
    var numInt = $("#numInt").val();
    var entrecalle = $("#entrecalle").val();
    var ycalle = $("#ycalle").val();

    var colonia = $("#colonia").val();//opcional para poner lista desplegable
    var municipio = $("#municipio").val();//opcional para poner lista desplegable

    //si tiene trabajo llenar datos
    var empresa = $("#empresa").val();
    var area = $("#area").val();
    var telyhora = $("#telyhora").val();//opcion para separarlo en dos campos
    var idEstudioSocioeconomico

    //ingresos
    var Ingresopaciente = $("#Ingresopaciente").val();
    var IngresoPareja = $("#IngresoPareja").val();
    var IngresoPadres = $("#IngresoPadres").val();
    var IngresoHijos = $("#IngresoHijos").val();
    var IngresoOtros = $("#IngresoOtros").val();
    var sumtotalingreso = parseFloat(Ingresopaciente) +  parseFloat(IngresoPareja) +  parseFloat(IngresoPadres) +  parseFloat(IngresoHijos) +  parseFloat(IngresoOtros);
    var IngresoTotal = $("#IngresoTotal").val();

    var planta = ($("#sltPlanta").val() == "1");
    var activo = $("#chkActivo").prop('checked');

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