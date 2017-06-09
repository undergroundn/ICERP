using Model.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Repositories
{
    public class EstatusCitasRepository : GenericRepository<IcerpEntities, EstatusCitas>
    {
        public EstatusCitasRepository()
        {
            Context = new IcerpEntities();
        }
        public EstatusCitasRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<EstatusCitas> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<EstatusCitas> GetBy(System.Linq.Expressions.Expression<Func<EstatusCitas, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public EstatusCitas GetSingle(int Id)
        {
            var query = Context.EstatusCitas.FirstOrDefault(x => x.ID == Id);
            return query;
        }

        public void AddSingle(EstatusCitas single)
        {
            Add(single);
        }

        public void UpdateSingle(EstatusCitas single)
        {
            Edit(single);
        }
    }
}
