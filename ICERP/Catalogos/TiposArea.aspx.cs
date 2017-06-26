using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Model.UnitOfWork;

namespace ICERP.Catalogos
{
    public partial class TiposArea : System.Web.UI.Page
    {
        private static readonly LoggerUtility.ILogger Log = LoggerUtility.Logger.GetInstance();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        //[WebMethod]
        //public static string obtenerTiposAreas()
        //{
        //    try
        //    {
        //        var uow = new UnitOfWork();
        //        var tiposAreas = uow.TipoAreasRepository.Get();
        //        var usuarios = uow.UsuariosRepository.Get();
        //        var consulta = from ta in tiposAreas
        //                       join u in usuarios on ta.IdUsuario equals u.ID
        //                       select new { ta.ID, ta.Tipo, NombreUsuario = u.Nombres + " " + u.ApPaterno + " " + u.ApMaterno, FechaAlta = tp.FechaAlta.ToString("dd/MM/yyyy"), Activo = tp.Activo ? "Si" : "No" };
        //        return new JavaScriptSerializer().Serialize(consulta);
        //    }
        //    catch (Exception ex)
        //    {
        //        Log.Error("[ System ] " + " [ Page ] " + "[ " + System.Reflection.MethodBase.GetCurrentMethod().DeclaringType.Name.ToString() + " ] [ " + System.Reflection.MethodBase.GetCurrentMethod().Name.ToString() + " ] [ Fin ]", ex);
        //        throw;
        //    }
        //}
    }
}