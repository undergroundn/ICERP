using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;

namespace ICERP
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }
        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {
            // Si se envía alguna información acerca del usuario
            if (HttpContext.Current.User != null)
            {
                // se comprueba que el usuario esté autenticado
                if (HttpContext.Current.User.Identity.IsAuthenticated)
                {
                    // Se comprueba si el usuario está autenticado por formulario
                    if (HttpContext.Current.User.Identity is FormsIdentity)
                    {
                        // Se recupera la identidad del usuario para recuperar sus roles
                        FormsIdentity identity = (FormsIdentity)HttpContext.Current.User.Identity;
                        // Se recupera el ticket del usuario
                        FormsAuthenticationTicket ticket = identity.Ticket;
                        // Se recupera la información acerca del usuario, donde metimos la información de los roles
                        string[] roles = ticket.UserData.Split(';');
                        // Se crea un usuario con dichos roles
                        HttpContext.Current.User = new System.Security.Principal.GenericPrincipal(identity, roles);

                    }
                }
            }
        }
    }
}