﻿using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Restaurant.DataAccess.Model;
using Restaurant.Domain.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;

namespace Restaurant.DataAccess.Repositories
{
    public class Repository<TEntity> : IRepository<TEntity> where TEntity : class
    {
        protected readonly DbContext _context = new DbRestaurantContext();
/*        protected readonly ILogger<Repository> _logger;
*/
        public Repository()
        {
            _context = new DbRestaurantContext();
        }
        public void Add(TEntity entity)
        {
            _context.Set<TEntity>().Add(entity);
       }

        public void AddRange(IEnumerable<TEntity> entities)
        {
            _context.Set<TEntity>().AddRange(entities);
        }

        public IEnumerable<TEntity> Find(Expression<Func<TEntity, bool>> predicate, string includeName) // only include one navigational property
        {
            return _context.Set<TEntity>().Where(predicate).Include($"{includeName}");
        }

        public IEnumerable<TEntity> Find(Expression<Func<TEntity, bool>> predicate, string includeNameFirst, string includeNameSecond) //  include two navigational properties
        {
            return _context.Set<TEntity>().Where(predicate).Include($"{includeNameFirst}").Include($"{includeNameSecond}");
        }

        public IEnumerable<TEntity> Find(Expression<Func<TEntity, bool>> predicate, string includeNameFirst, string includeNameSecond, string includeNameThird) //  include three navigational properties
        {
            return _context.Set<TEntity>().Where(predicate).Include($"{includeNameFirst}").Include($"{includeNameSecond}").Include($"{includeNameThird}");
        }

        public IEnumerable<TEntity> Find(Expression<Func<TEntity, bool>> predicate)
        {
            return _context.Set<TEntity>().Where(predicate);
        }

        public TEntity Get(int id)
        {
            return _context.Set<TEntity>().Find(id); //return single object of class
        }

        


        public IEnumerable<TEntity> GetAll()
        {
            return _context.Set<TEntity>().ToList();
        }

        public void Remove(TEntity entity)
        {
            _context.Set<TEntity>().Remove(entity);
        }

        public void RemoveRange(IEnumerable<TEntity> entities)
        {
            _context.Set<TEntity>().RemoveRange(entities);
        }

        public void Save()
        {
            _context.SaveChanges();
        }
    }
}
