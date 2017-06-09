using Model.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Repositories
{
    public class DomicilioESRepository : GenericRepository<IcerpEntities, DomicilioES>
    {
        public DomicilioESRepository()
        {
            Context = new IcerpEntities();
        }
        public DomicilioESRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<DomicilioES> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<DomicilioES> GetBy(System.Linq.Expressions.Expression<Func<DomicilioES, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public DomicilioES GetSingle(int Id)
        {
            var query = Context.DomicilioES.FirstOrDefault(x => x.ID == Id);
            return query;
        }

        public void AddSingle(DomicilioES single)
        {
            Add(single);
        }

        public void UpdateSingle(DomicilioES single)
        {
            Edit(single);
        }
    }
}
