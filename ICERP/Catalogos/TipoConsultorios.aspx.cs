using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ICERP.Catalogos
{
    public partial class TipoConsultorios : System.Web.UI.Page
    {
        Model.UnitOfWork.UnitOfWork worker = new Model.UnitOfWork.UnitOfWork();
        protected void Page_Load(object sender, EventArgs e)
        {
            rptPerfiles.DataSource = worker.TipoConsultorioRepository.Get();
            rptPerfiles.DataBind();
        }
    }
}