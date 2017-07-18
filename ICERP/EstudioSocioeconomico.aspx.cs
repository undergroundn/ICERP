using Model.UnitOfWork;
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
    public partial class EstudioSocioeconomico : System.Web.UI.Page
    {
        private static readonly LoggerUtility.ILogger Log = LoggerUtility.Logger.GetInstance();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        //Obtener el listado de usuarios encuestadores para cargar la lista
        [WebMethod]
        public static string obtenerUsuarioEncuestador()
        {
            try
            {
                var uow = new UnitOfWork();
                var userId = Int32.Parse(HttpContext.Current.Session["userID"].ToString());
                var usuario = uow.UsuariosRepository.Get().Where(x => x.Activo == true && x.ID == userId).Select(tc => new { tc.ID, tc.Nombres,tc.ApPaterno, tc.ApMaterno }).FirstOrDefault();
                return new JavaScriptSerializer().Serialize(usuario);
            }
            catch (Exception ex)
            {
                Log.Error("[ System ] " + " [ Page ] " + "[ " + System.Reflection.MethodBase.GetCurrentMethod().DeclaringType.Name.ToString() + " ] [ " + System.Reflection.MethodBase.GetCurrentMethod().Name.ToString() + " ] [ Fin ]", ex);
                throw;
            }
        }
    }
}