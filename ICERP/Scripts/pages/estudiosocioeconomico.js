$(document).ready(function () {

    ICERP_Core.llamarAjax("EstudioSocioeconomico.aspx/obtenerUsuarioEncuestador", null, "crearControlEncuestador");

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

//Resultado de la llamada a Pacientes.aspx/obtenerUsuarioEncuestador
function crearControlEncuestador(resultado) {
    var contenido = JSON.parse(resultado);
    contenido.Nombres
    var nombre = contenido.Nombres + " " + contenido.ApPaterno + " " + contenido.ApMaterno;
    $("#nombreusuario").val(nombre);
    var fechaactual = Date.Now;
    $("#fecha").val(fechaactual);
    //$.each(contenido, function (index, item) {
    //    //llenar lista de turnos disponibles en BD
    //    var nombre = item.Nombres +" "+item.apPaterno + " "+item.apMaterno;
    //    $("#nombreusuario").val(nombre);
    //    //var checkBoxAd = "<input id=\"chk" + item.Tipo + "Ad\" value=\"" + item.ID + "\" type=\"checkbox\" class=\"flat-red tiposConsultorios validate[funcCall[verificarTipoConsultorio]]\" validgroup=\"registrarConsultorio\" />" +
    //    //                    "<span style=\"margin-right: 20px\">" + item.Tipo + "</span>";
    //    //$("#divTipoConsultorios").append(checkBoxAd);
    //    //var checkBoxEd = "<input id=\"chk" + item.Tipo + "Ed\" value=\"" + item.ID + "\" type=\"checkbox\" class=\"flat-red tiposConsultoriosEd validate[funcCall[verificarTipoConsultorioEd]]\" validgroup=\"editarConsultorio\" />" +
    //    //                    "<span style=\"margin-right: 20px\">" + item.Tipo + "</span>";
    //    //$("#divTipoConsultoriosEd").append(checkBoxEd);
    //});
    //$('#divTipoConsultorios input[type="checkbox"].flat-red').iCheck({
    //    checkboxClass: 'icheckbox_flat-red'
    //});
}

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

    //egresos
    //falta agregar los check box que esten seleccionados , no se almacena
    var egresoTotal = $("#egresoTotal").val();


    //var planta = ($("#sltPlanta").val() == "1");
    var activo = $("#chkActivo").prop('checked');

    var estudiosocioeconomico = new Object();
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