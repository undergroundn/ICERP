using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ICERP
{
    public partial class Ejemplo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var spr = new Model.CustomModel.StoredProcedureRepository();
            var consultorios = spr.ObtenerDetallesConsultorios();
            var r = new JavaScriptSerializer().Serialize(consultorios);
        }

        [WebMethod]
        public static string obtenerConsultorios(int idGrupoEvidencia)
        {
            var spr = new Model.CustomModel.StoredProcedureRepository();
            var consultorios = spr.ObtenerDetallesConsultorios();
            return new JavaScriptSerializer().Serialize(consultorios);
        }
    }
}