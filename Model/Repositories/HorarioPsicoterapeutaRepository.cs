using Model.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Repositories
{
    public class HorarioPsicoterapeutaRepository : GenericRepository<IcerpEntities, HorarioPsicoterapeuta>
    {
        public HorarioPsicoterapeutaRepository()
        {
            Context = new IcerpEntities();
        }
        public HorarioPsicoterapeutaRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<HorarioPsicoterapeuta> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<HorarioPsicoterapeuta> GetBy(System.Linq.Expressions.Expression<Func<HorarioPsicoterapeuta, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public HorarioPsicoterapeuta GetSingle(int Id)
        {
            var query = Context.HorarioPsicoterapeuta.FirstOrDefault(x => x.ID == Id);
            return query;
        }

        public void AddSingle(HorarioPsicoterapeuta single)
        {
            Add(single);
        }

        public void UpdateSingle(HorarioPsicoterapeuta single)
        {
            Edit(single);
        }
    }
}
