using Model.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Repositories
{
    public class TurnosRepository : GenericRepository<IcerpEntities, Turnos>
    {
        public TurnosRepository()
        {
            Context = new IcerpEntities();
        }
        public TurnosRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<Turnos> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<Turnos> GetBy(System.Linq.Expressions.Expression<Func<Turnos, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public Turnos GetSingle(int Id)
        {
            var query = Context.Turnos.FirstOrDefault(x => x.ID == Id);
            return query;
        }

        public void AddSingle(Turnos single)
        {
            Add(single);
        }

        public void UpdateSingle(Turnos single)
        {
            Edit(single);
        }
    }
}
