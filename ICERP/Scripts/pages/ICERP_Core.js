//Requiere incluir los scripts de los plugins utilizados e inicializar las variables globales

var ICERP_Core = {

    bloquearPantalla: function () {
        $.blockUI({
            message: '<img src=' + window._urlEspere + ' />',
            css: {
                border: 'none',
                padding: '15px',
                backgroundColor: '#000',
                '-webkit-border-radius': '10px',
                '-moz-border-radius': '10px',
                opacity: .5,
                color: '#fff'
            }
        });
    },

    desbloquearPantalla: function () {
        $.unblockUI();
    },

    llamarAjax: function (url, parametros, funcion) {
        if (parametros == null) {
            $.ajax({
                type: "POST",
                url: url,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data, textStatus, jqXHR) {
                    window[funcion](data.d);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    
                }
            });
        } else {
            $.ajax({
                type: "POST",
                url: url,
                data: parametros,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data, textStatus, jqXHR) {
                    window[funcion](data.d);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    
                }
            });
        }
    },

    validarFormulario: function (validGroup) {
        var isValid = true;
        $("input[validGroup = " + validGroup + "],textarea[validGroup = " + validGroup + "],select[validGroup =" + validGroup + "]").each(function () {
            var isInvaldField = $(this).validationEngine('validate');
            if (isValid)
                isValid = !isInvaldField;
        });
        return isValid;
    },

    reiniciarValidación: function (validGroup) {
        $("input[validGroup = " + validGroup + "],textarea[validGroup = " + validGroup + "],select[validGroup =" + validGroup + "]").each(function () {
            var handler = function () {
                $(this).validationEngine('validate');
            };
            $(this).unbind("change", handler);
            $(this).change(handler);
        });
    }
}