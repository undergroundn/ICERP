using Model.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Repositories
{
    public class CatMunicipioRepository: GenericRepository<IcerpEntities, CatMunicipio>
    {
        public CatMunicipioRepository()
        {
            Context = new IcerpEntities();
        }
        public CatMunicipioRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<CatMunicipio> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<CatMunicipio> GetBy(System.Linq.Expressions.Expression<Func<CatMunicipio, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public CatMunicipio GetSingle(int Id)
        {
            var query = Context.CatMunicipio.FirstOrDefault(x => x.ID == Id);
            return query;
        }

        public void AddSingle(CatMunicipio single)
        {
            Add(single);
        }

        public void UpdateSingle(CatMunicipio single)
        {
            Edit(single);
        }
    }
}
