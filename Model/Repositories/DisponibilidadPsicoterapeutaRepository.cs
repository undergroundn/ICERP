using Model.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Repositories
{
    public class DisponibilidadPsicoterapeutaRepository : GenericRepository<IcerpEntities, DisponibilidadPsicoterapeuta>
    {
        public DisponibilidadPsicoterapeutaRepository()
        {
            Context = new IcerpEntities();
        }
        public DisponibilidadPsicoterapeutaRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<DisponibilidadPsicoterapeuta> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<DisponibilidadPsicoterapeuta> GetBy(System.Linq.Expressions.Expression<Func<DisponibilidadPsicoterapeuta, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public DisponibilidadPsicoterapeuta GetSingle(int Id)
        {
            var query = Context.DisponibilidadPsicoterapeuta.FirstOrDefault(x => x.ID == Id);
            return query;
        }

        public void AddSingle(DisponibilidadPsicoterapeuta single)
        {
            Add(single);
        }

        public void UpdateSingle(DisponibilidadPsicoterapeuta single)
        {
            Edit(single);
        }
    }
}
