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
    public partial class TipoConsultorios : System.Web.UI.Page
    {
        private static readonly LoggerUtility.ILogger Log = LoggerUtility.Logger.GetInstance();
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        [WebMethod]
        public static string obtenerTiposConsultorios()
        {
            try
            {
                var uow = new UnitOfWork();
                var tiposConsultorios = uow.TipoConsultorioRepository.Get();
                var usuarios = uow.UsuariosRepository.Get();
                var consulta = from tc in tiposConsultorios
                    join u in usuarios on tc.IdUsuario equals u.ID
                    select new {tc.ID, tc.Tipo, tc.Activo, tc.FechaAlta, NombreUsuario = string.Format("{0} {1} {2}" + u.Nombres, u.ApPaterno, u.ApMaterno)};

                var resultado = uow.TipoConsultorioRepository.Get().Where(tc => tc.Activo).Select(tc => new { tc.ID, tc.Tipo });
                //return new JavaScriptSerializer().Serialize(tiposConsultorios);
            }
            catch (Exception ex)
            {
                Log.Error("[ System ] " + " [ Page ] " + "[ " + System.Reflection.MethodBase.GetCurrentMethod().DeclaringType.Name.ToString() + " ] [ " + System.Reflection.MethodBase.GetCurrentMethod().Name.ToString() + " ] [ Fin ]", ex);
                throw;
            }
        }
    }
}