using Model.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Repositories
{
    public class TrabajoActualESRepository : GenericRepository<IcerpEntities, TrabajoActualES>
    {
        public TrabajoActualESRepository()
        {
            Context = new IcerpEntities();
        }
        public TrabajoActualESRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<TrabajoActualES> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<TrabajoActualES> GetBy(System.Linq.Expressions.Expression<Func<TrabajoActualES, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public TrabajoActualES GetSingle(int Id)
        {
            var query = Context.TrabajoActualES.FirstOrDefault(x => x.ID == Id);
            return query;
        }

        public void AddSingle(TrabajoActualES single)
        {
            Add(single);
        }

        public void UpdateSingle(TrabajoActualES single)
        {
            Edit(single);
        }
    }
}
