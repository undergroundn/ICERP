using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model.Infrastructure;

namespace Model.Repositories
{
    public class MenuUsuarioRepository : GenericRepository<IcerpEntities, MenuUsuario>
    {
        public MenuUsuarioRepository()
        {
            Context = new IcerpEntities();
        }
        public MenuUsuarioRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<MenuUsuario> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<MenuUsuario> GetBy(System.Linq.Expressions.Expression<Func<MenuUsuario, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public MenuUsuario GetSingle(int Id)
        {
            var query = Context.MenuUsuario.FirstOrDefault(x => x.Id_MenuUsuario == Id);
            return query;
        }

        public void AddSingle(MenuUsuario single)
        {
            Add(single);
        }

        public void UpdateSingle(MenuUsuario single)
        {
            Edit(single);
        }
    }
}
