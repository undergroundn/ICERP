using Model.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Repositories
{
    public class ConsultoriosRepository : GenericRepository<IcerpEntities, Consultorios>
    {
        public ConsultoriosRepository()
        {
            Context = new IcerpEntities();
        }
        public ConsultoriosRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<Consultorios> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<Consultorios> GetBy(System.Linq.Expressions.Expression<Func<Consultorios, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public Consultorios GetSingle(int Id)
        {
            var query = Context.Consultorios.FirstOrDefault(x => x.ID == Id);
            return query;
        }

        public void AddSingle(Consultorios single)
        {
            Add(single);
        }

        public void UpdateSingle(Consultorios single)
        {
            Edit(single);
        }
    }
}
