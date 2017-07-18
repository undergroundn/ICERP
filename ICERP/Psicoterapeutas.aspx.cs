using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Permissions;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Owin.Security.OAuth;
using Model.UnitOfWork;

namespace ICERP
{
    public partial class Psicoterapeutas : System.Web.UI.Page
    {
        private static readonly LoggerUtility.ILogger Log = LoggerUtility.Logger.GetInstance();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string obtenerDatosControles()
        {
            try
            {
                var uow = new UnitOfWork();
                var tiposTurnos = uow.TurnosRepository.Get().Where(t => t.Activo).Select(t => new { t.ID, Tipo = t.Turno });
                var tiposCuotas = uow.TipoCoutaRepository.Get().Where(tc => tc.Activo).Select(tc => new { tc.ID, tc.Tipo });
                var tiposPacientes = uow.TipoPacienteRepository.Get().Where(tp => tp.Activo).Select(tp => new { tp.ID, tp.Tipo });
                var tiposAreas = uow.TipoAreasRepository.Get().Where(ta => ta.Activo).Select(ta => new { ta.ID, ta.Tipo });
                var tiposTrastornos = uow.TipoTrastornoRepository.Get().Where(tt => tt.Activo).Select(tt => new { tt.ID, tt.Tipo });

                var js = new JavaScriptSerializer();
                var datosControles = "{\"TiposTurnos\":" + js.Serialize(tiposTurnos) + "," +
                    "\"TiposCuotas\":" + js.Serialize(tiposCuotas) + "," +
                    "\"TiposPacientes\":" + js.Serialize(tiposPacientes) + "," +
                    "\"TiposAreas\":" + js.Serialize(tiposAreas) + "," +
                    "\"TiposTrastornos\":" + js.Serialize(tiposTrastornos) + "," +
                    "}";

                return datosControles;
            }
            catch (Exception ex)
            {
                Log.Error("[ System ] " + " [ Page ] " + "[ " + System.Reflection.MethodBase.GetCurrentMethod().DeclaringType.Name.ToString() + " ] [ " + System.Reflection.MethodBase.GetCurrentMethod().Name.ToString() + " ] [ Fin ]", ex);
                throw;
            }
        }
    }
}