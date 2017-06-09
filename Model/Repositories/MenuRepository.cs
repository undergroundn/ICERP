using Model.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Repositories
{
    public class MenuRepository : GenericRepository<IcerpEntities, Menu>
    {
        public MenuRepository()
        {
            Context = new IcerpEntities();
        }
        public MenuRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<Menu> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<Menu> GetBy(System.Linq.Expressions.Expression<Func<Menu, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public Menu GetSingle(int Id)
        {
            var query = Context.Menu.FirstOrDefault(x => x.MenuId == Id);
            return query;
        }

        public void AddSingle(Menu single)
        {
            Add(single);
        }

        public void UpdateSingle(Menu single)
        {
            Edit(single);
        }
    }
}
