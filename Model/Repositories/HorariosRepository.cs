using Model.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Repositories
{
     public class HorariosRepository : GenericRepository<IcerpEntities, Horarios>
    {
        public HorariosRepository()
        {
            Context = new IcerpEntities();
        }
        public HorariosRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<Horarios> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<Horarios> GetBy(System.Linq.Expressions.Expression<Func<Horarios, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public Horarios GetSingle(int Id)
        {
            var query = Context.Horarios.FirstOrDefault(x => x.ID == Id);
            return query;
        }

        public void AddSingle(Horarios single)
        {
            Add(single);
        }

        public void UpdateSingle(Horarios single)
        {
            Edit(single);
        }
    }
}
