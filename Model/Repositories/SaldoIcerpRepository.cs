using Model.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Repositories
{
    public class SaldoIcerpRepository : GenericRepository<IcerpEntities, SaldoIcerp>
    {
        public SaldoIcerpRepository()
        {
            Context = new IcerpEntities();
        }
        public SaldoIcerpRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<SaldoIcerp> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<SaldoIcerp> GetBy(System.Linq.Expressions.Expression<Func<SaldoIcerp, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public SaldoIcerp GetSingle(int Id)
        {
            var query = Context.SaldoIcerp.FirstOrDefault(x => x.ID == Id);
            return query;
        }

        public void AddSingle(SaldoIcerp single)
        {
            Add(single);
        }

        public void UpdateSingle(SaldoIcerp single)
        {
            Edit(single);
        }
    }
}
