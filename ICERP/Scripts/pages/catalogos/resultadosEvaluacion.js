$(document).ready(function () {

    ICERP_Core.llamarAjax("ResultadosEvaluacion.aspx/obtenerResultados", null, "crearTablaResultados");

    $("#btnRegistrarResultados").click(function (ev) {
        var isValid = ICERP_Core.validarFormulario('registrarResultados');
        if (!isValid) {
            ICERP_Core.reiniciarValidación('registrarResultados');
            ev.preventDefault();
            return;
        }
        guardarResultado();
    });

    $("#btnEditarResultado").click(function (ev) {
        var isValid = ICERP_Core.validarFormulario('editarResultados');
        if (!isValid) {
            ICERP_Core.reiniciarValidación('editarResultados');
            ev.preventDefault();
            return;
        }
        actualizarResultado();
    });
});

//Resultado de la llamada a Consultorios.aspx/obtenerConsultorios
function crearTablaResultados(resultado) {
    var contenido = JSON.parse(resultado);
    $('#tblResultados tbody').html("");
    $.each(contenido, function (key, item) {
        var $tr = $('<tr>');
        $.each(item, function (index, data) {
            $tr.append($('<td>').text(data));
        });
        $tr.append($('<td style="text-align:center">').html('<a role="button" class="btn btn-default btnModalEditarResultado" data-toggle="modal"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></a>'));
        $tr.appendTo('#tblResultados tbody');
    });

    $("#tblResultados").DataTable({
        "language": {
            "url": "//cdn.datatables.net/plug-ins/1.10.15/i18n/Spanish.json"
        },
        "responsive": true,
        "columnDefs": [
            { "visible": false, "targets": 0 }
        ]
    });

    clickEditarResultado();
}

function guardarResultado() {
    var nombreTarifa = $("#txtNombreTarifa").val();
    var rangoInferior = $("#txtRangoInferior").val();
    var rangoSuperior = $("#txtRangoSuperior").val();
    var precioTarifa = $("#txtPrecioTarifa").val();
    var descuentoPersona = $("#txtDescuentoPorPersona").val();

    var resultado = new Object();
    resultado.NombreTarifa = nombreTarifa;
    resultado.RangoInferior = Number(rangoInferior);
    resultado.RangoSuperior = Number(rangoSuperior);
    resultado.PrecioTarifa = Number(precioTarifa);
    resultado.DescuentoPorPerExtra = descuentoPersona;

    ICERP_Core.bloquearPantalla();
    ICERP_Core.llamarAjax("ResultadosEvaluacion.aspx/guardarResultado", "{ 'resultado': " + JSON.stringify(resultado) + "}", "resultadoGuardado");
}

//Resultado de la llamada a Consultorios.aspx/guardarConsultorio de la función "guardarConsultorio"
function resultadoGuardado() {
    $('#tblResultados').DataTable().destroy();
    ICERP_Core.llamarAjax("ResultadosEvaluacion.aspx/obtenerResultados", null, "crearTablaResultados");
    ICERP_Core.desbloquearPantalla();
    ICERP_Core.mostrarMensaje("Se almacenó el resulado satisfactoriamente", "type-success");
}

function clickEditarResultado() {
    $(".btnModalEditarResultado").click(function () {
        var row = $(this).closest('tr');
        var data = $('#tblResultados').dataTable().fnGetData(row);
        var idResultado = Number(data[0]);
        ICERP_Core.llamarAjax("ResultadosEvaluacion.aspx/obtenerDatosResultados", "{ 'IdResultado': " + idResultado + " }", "mostrarDatosResultados");
    });
}

//Resultado de la llamada a Consultorios.aspx/obtenerDatosConsultorio de la función "clickEditarConsultorio"
function mostrarDatosResultados(resultado) {
    var resultadosEv = JSON.parse(resultado);
    $("#hdnIdResultado").val(resultadosEv.ID);
    $("#txtNombreResultadoEd").val(resultadosEv.NombreTarifa);
    $("#txtRangoInferiorEd").val(resultadosEv.RangoInferior);
    $("#txtRangoSuperiorEd").val(resultadosEv.RangoSuperior);
    $("#txtPrecioTarifaEd").val(resultadosEv.PrecioTarifa);
    $("#txtDescuentoPorPersonaEd").val(resultadosEv.DescuentoPorPerExtra);

   
   
    $("#mdlEditarResultados").validationEngine("hideAll");
    $("#mdlEditarResultados").modal("show");
}

function actualizarResultado() {
    var idresultado= Number($("#hdnIdResultado").val());
    var nombreTarifa = $("#txtNombreResultadoEd").val();
    var rangoInferior = $("#txtRangoInferiorEd").val();
    var rangoSuperior = $("#txtRangoSuperiorEd").val();
    var precioTarifa = $("#txtPrecioTarifaEd").val();
    var descuentoPersona = $("#txtDescuentoPorPersonaEd").val();

    var resultado = new Object();
    resultado.ID = idresultado;
    resultado.NombreTarifa = nombreTarifa;
    resultado.RangoInferior = Number(rangoInferior);
    resultado.RangoSuperior = Number(rangoSuperior);
    resultado.PrecioTarifa = Number(precioTarifa);
    resultado.DescuentoPorPerExtra = descuentoPersona;

    ICERP_Core.bloquearPantalla();    

    ICERP_Core.llamarAjax("ResultadosEvaluacion.aspx/actualizarResultados", "{ 'resultado': " + JSON.stringify(resultado) + "}", "resultadoActualizado");
}

function resultadoActualizado() {
    $('#tblResultados').DataTable().destroy();
    ICERP_Core.llamarAjax("ResultadosEvaluacion.aspx/obtenerResultados", null, "crearTablaResultados");
    ICERP_Core.desbloquearPantalla();
    $("#mdlEditarResultados").modal("hide");
    ICERP_Core.mostrarMensaje("Se actualizó el resultado satisfactoriamente", "type-success");
}

