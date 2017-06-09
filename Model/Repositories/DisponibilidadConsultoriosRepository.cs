using Model.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Repositories
{
    public class DisponibilidadConsultoriosRepository : GenericRepository<IcerpEntities, DisponibilidadConsultorios>
    {
        public DisponibilidadConsultoriosRepository()
        {
            Context = new IcerpEntities();
        }
        public DisponibilidadConsultoriosRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<DisponibilidadConsultorios> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<DisponibilidadConsultorios> GetBy(System.Linq.Expressions.Expression<Func<DisponibilidadConsultorios, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public DisponibilidadConsultorios GetSingle(int Id)
        {
            var query = Context.DisponibilidadConsultorios.FirstOrDefault(x => x.ID == Id);
            return query;
        }

        public void AddSingle(DisponibilidadConsultorios single)
        {
            Add(single);
        }

        public void UpdateSingle(DisponibilidadConsultorios single)
        {
            Edit(single);
        }
    }
}
