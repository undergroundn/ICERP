using Model.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Repositories
{
    public class PacientesRepository : GenericRepository<IcerpEntities, Pacientes>
    {
        public PacientesRepository()
        {
            Context = new IcerpEntities();
        }
        public PacientesRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<Pacientes> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<Pacientes> GetBy(System.Linq.Expressions.Expression<Func<Pacientes, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public Pacientes GetSingle(int Id)
        {
            var query = Context.Pacientes.FirstOrDefault(x => x.ID == Id);
            return query;
        }

        public void AddSingle(Pacientes single)
        {
            Add(single);
        }

        public void UpdateSingle(Pacientes single)
        {
            Edit(single);
        }
    }
}
