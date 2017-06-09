using Model.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Repositories
{
    public class PsicoterapeutaRepository : GenericRepository<IcerpEntities, Psicoterapeuta>
    {
        public PsicoterapeutaRepository()
        {
            Context = new IcerpEntities();
        }
        public PsicoterapeutaRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<Psicoterapeuta> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<Psicoterapeuta> GetBy(System.Linq.Expressions.Expression<Func<Psicoterapeuta, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public Psicoterapeuta GetSingle(int Id)
        {
            var query = Context.Psicoterapeuta.FirstOrDefault(x => x.ID == Id);
            return query;
        }

        public void AddSingle(Psicoterapeuta single)
        {
            Add(single);
        }

        public void UpdateSingle(Psicoterapeuta single)
        {
            Edit(single);
        }
    }
}
