$(document).ready(function () {

    ICERP_Core.llamarAjax("Consultorios.aspx/obtenerTiposConsultorios", null, "crearControlTiposConsultorios");

    ICERP_Core.llamarAjax("Consultorios.aspx/obtenerConsultorios", null, "crearTablaConsultorios");

    $("#btnRegistrarConsultorio").click(function (ev) {
        var isValid = ICERP_Core.validarFormulario('registrarConsultorio');
        if (!isValid) {
            ICERP_Core.reiniciarValidación('registrarConsultorio');
            ev.preventDefault();
            return;
        }
        guardarConsultorio();
    });

    $("#btnEditarConsultorio").click(function (ev) {
        var isValid = ICERP_Core.validarFormulario('editarConsultorio');
        if (!isValid) {
            ICERP_Core.reiniciarValidación('editarConsultorio');
            ev.preventDefault();
            return;
        }
        actualizarConsultorio();
    });
});

//Resultado de la llamada a Consultorios.aspx/obtenerTiposConsultorios
function crearControlTiposConsultorios(resultado) {
    var contenido = JSON.parse(resultado);
    $.each(contenido, function (index, item) {
        var checkBoxAd = "<input id=\"chk" + item.Tipo + "Ad\" value=\"" + item.ID + "\" type=\"checkbox\" class=\"flat-red tiposConsultorios validate[funcCall[verificarTipoConsultorio]]\" validgroup=\"registrarConsultorio\" />" +
                            "<span style=\"margin-right: 20px\">" + item.Tipo + "</span>";
        $("#divTipoConsultorios").append(checkBoxAd);
        var checkBoxEd = "<input id=\"chk" + item.Tipo + "Ed\" value=\"" + item.ID + "\" type=\"checkbox\" class=\"flat-red tiposConsultoriosEd validate[funcCall[verificarTipoConsultorioEd]]\" validgroup=\"editarConsultorio\" />" +
                            "<span style=\"margin-right: 20px\">" + item.Tipo + "</span>";
        $("#divTipoConsultoriosEd").append(checkBoxEd);
    });
    $('#divTipoConsultorios input[type="checkbox"].flat-red').iCheck({
        checkboxClass: 'icheckbox_flat-red'
    });
}

//Resultado de la llamada a Consultorios.aspx/obtenerConsultorios
function crearTablaConsultorios(resultado) {
    var contenido = JSON.parse(resultado);
    $('#tblConsultorios tbody').html("");
    $.each(contenido, function (key, item) {
        var $tr = $('<tr>');
        $.each(item, function (index, data) {
            $tr.append($('<td>').text(data));
        });
        $tr.append($('<td style="text-align:center">').html('<a role="button" class="btn btn-default btnModalEditarConsultorio" data-toggle="modal"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></a>'));
        $tr.appendTo('#tblConsultorios tbody');
    });

    $("#tblConsultorios").DataTable({
        "language": {
            "url": "//cdn.datatables.net/plug-ins/1.10.15/i18n/Spanish.json"
        },
        "responsive": true,
        "columnDefs": [
            { "visible": false, "targets": 0 }
        ]
    });

    clickEditarConsultorio();
}

function guardarConsultorio() {
    var nombre = $("#txtNombreConsultorio").val();
    var planta = ($("#sltPlanta").val() == "1");
    var activo = $("#chkActivo").prop('checked');

    var consultorio = new Object();
    consultorio.Nombre = nombre;
    consultorio.Planta = planta;
    consultorio.Activo = activo;
    consultorio.ConsultoriosTipos = [];

    $(".tiposConsultorios").each(function () {
        var checked = $(this).prop('checked');
        if (checked) {
            var idTipo = Number($(this).val());
            var consultorioTipo = new Object();
            consultorioTipo.IdTipo = idTipo;
            consultorio.ConsultoriosTipos.push(consultorioTipo);
        }
    });

    ICERP_Core.bloquearPantalla();
    ICERP_Core.llamarAjax("Consultorios.aspx/guardarConsultorio", "{ 'consultorio': " + JSON.stringify(consultorio) + "}", "consultorioGuardado");
}

//Resultado de la llamada a Consultorios.aspx/guardarConsultorio de la función "guardarConsultorio"
function consultorioGuardado() {
    $('#tblConsultorios').DataTable().destroy();
    ICERP_Core.llamarAjax("Consultorios.aspx/obtenerConsultorios", null, "crearTablaConsultorios");
    ICERP_Core.desbloquearPantalla();
    ICERP_Core.mostrarMensaje("Se almacenó el consultorio satisfactoriamente", "type-success");
}

function clickEditarConsultorio() {
    $(".btnModalEditarConsultorio").click(function () {
        var row = $(this).closest('tr');
        var data = $('#tblConsultorios').dataTable().fnGetData(row);
        var idConsultorio = Number(data[0]);
        ICERP_Core.llamarAjax("Consultorios.aspx/obtenerDatosConsultorio", "{ 'IdConsultorio': " + idConsultorio + " }", "mostrarDatosConsultorio");
    });
}

//Resultado de la llamada a Consultorios.aspx/obtenerDatosConsultorio de la función "clickEditarConsultorio"
function mostrarDatosConsultorio(resultado) {
    var consultorio = JSON.parse(resultado);
    $("#hdnIdConsultorio").val(consultorio.ID);
    $("#txtNombreConsultorioEd").val(consultorio.Nombre);
    $("#sltPlantaEd").val(+consultorio.Planta);

    $('#divTipoConsultoriosEd input[type=checkbox]').each(function () {
        $(this).prop("checked", false);
    });

    $.each(consultorio.Tipos, function (index, value) {
        var checkBox = $("#divTipoConsultoriosEd input[type=checkbox][value=" + value + "]");
        $(checkBox).prop("checked", true);
        $(checkBox).removeClass("flat-red").addClass("flat-red");
    });

    $("#chkActivoEd").prop("checked", false);
    if (consultorio.Activo) {
        $("#chkActivoEd").prop("checked", true);
        $("#chkActivoEd").removeClass("flat-red").addClass("flat-red");
    }
    $('#mdlEditarConsultorio input[type="checkbox"].flat-red').iCheck({
        checkboxClass: 'icheckbox_flat-red'
    });
    $("#mdlEditarConsultorio").validationEngine("hideAll");
    $("#mdlEditarConsultorio").modal("show");
}

function actualizarConsultorio() {
    var idConsultorio = Number($("#hdnIdConsultorio").val());
    var nombre = $("#txtNombreConsultorioEd").val();
    var planta = ($("#sltPlantaEd").val() == "1");
    var activo = $("#chkActivoEd").prop('checked');

    var consultorio = new Object();
    consultorio.ID = idConsultorio;
    consultorio.Nombre = nombre;
    consultorio.Planta = planta;
    consultorio.Activo = activo;
    consultorio.ConsultoriosTipos = [];

    $(".tiposConsultoriosEd").each(function () {
        var checked = $(this).prop('checked');
        if (checked) {
            var idTipo = Number($(this).val());
            var consultorioTipo = new Object();
            consultorioTipo.IdTipo = idTipo;
            consultorio.ConsultoriosTipos.push(consultorioTipo);
        }
    });

    ICERP_Core.bloquearPantalla();
    ICERP_Core.llamarAjax("Consultorios.aspx/actualizarConsultorio", "{ 'consultorio': " + JSON.stringify(consultorio) + "}", "consultorioActualizado");
}

function consultorioActualizado() {
    $('#tblConsultorios').DataTable().destroy();
    ICERP_Core.llamarAjax("Consultorios.aspx/obtenerConsultorios", null, "crearTablaConsultorios");
    ICERP_Core.desbloquearPantalla();
    $("#mdlEditarConsultorio").modal("hide");
    ICERP_Core.mostrarMensaje("Se actualizó el consultorio satisfactoriamente", "type-success");
}

//funcion personalizada para validar alta de consultorios
function verificarTipoConsultorio(field, rules, i, options) {
    var valid = false;
    $(".tiposConsultorios").each(function () {
        var checked = $(this).prop('checked');
        if (checked) {
            valid = true;
            return false;
        }
    });
    if (!valid) {
        $("#divTipoConsultorios").validationEngine('showPrompt', '* Seleccione el tipo de consultorio', 'error', 'topRight', true);
        options.isError = true;
    } else {
        $('#divTipoConsultorios').validationEngine('hide');
    }
}

//funcion personalizada para validar edición de consultorios
function verificarTipoConsultorioEd(field, rules, i, options) {
    var valid = false;
    $(".tiposConsultoriosEd").each(function () {
        var checked = $(this).prop('checked');
        if (checked) {
            valid = true;
            return false;
        }
    });
    if (!valid) {
        $("#divTipoConsultorios").validationEngine('showPrompt', '* Seleccione el tipo de consultorio', 'error', 'topRight', true);
        options.isError = true;
    } else {
        $('#divTipoConsultorios').validationEngine('hide');
    }
}