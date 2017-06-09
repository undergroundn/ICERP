using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(ICERP.Startup))]
namespace ICERP
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
