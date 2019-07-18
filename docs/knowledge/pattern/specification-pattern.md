# Specification Pattern

<hr/>

One Domain-Deriven-Design solution to the problem of where to place querying, sorting, and paging logic is to use a *Specification*. The Specification design pattern describes a query in an object. So to encapsulate a paged query that searches for some products, one might create a PagedProduct specification which would take in any necessary parameters (PageSize, pageNumber, filter). Then one of your repository methods (usually a List() overload) would accept an ISpecification and would be able to produce the expected result given the specification. There are several benefits to this approach. The spcification has a name (as opposed to just a bunch of LINQ expressions) that you can reason about and discuss. It can be unit tested in isolution to ensure correctness. And it can easily be resued if you need the same behavior (say on a MVC View action and a Web API action, as well as in varyous services). Further, a specificaition can also be used to describe the shape of the data to be returned, so that queries can return just the data they required. This eliminates the need for lazy loading in web applicaiton and help keep repository implementations from becoming clutteredwith these details.

## Generic Specification Interface

```csharp
// https://github.com/dotnet-architecture/eShopOnWeb
public interface ISpecification<T>
{
    Expression<Func<T, bool>> Criteria { get; }
    List<Expression<Func<T, object>>> Includes { get; }
    List<string> IncludeStrings { get; }
}
```

## Generic Specification Implementation (Base Class)

```csharp
// https://github.com/dotnet-architecture/eShopOnWeb
public abstract class BaseSpecification<T> : ISpecification<T>
{
    public BaseSpecification(Expression<Func<T, bool>> criteria)
    {
        Criteria = criteria;
    }
    public Expression<Func<T, bool>> Criteria { get; }
    public List<Expression<Func<T, object>>> Includes { get; } = new List<Expression<Func<T, object>>>();
    public List<string> IncludeStrings { get; } = new List<string>();

    protected virtual void AddInclude(Expression<Func<T, object>> includeExpression)
    {
        Includes.Add(includeExpression);
    }
    // string-based includes allow for including children of children, e.g. Basket.Items.Product
    protected virtual void AddInclude(string includeString)
    {
        IncludeStrings.Add(includeString);
    }
}
```
## A Simple Specification

The following specification will load a signle basket entity given either the basket's ID or the ID of the buyer to whom the basket belogs. It will eager load the basket's Items collection.

```csharp
public class BasketWithItemsSpecification : BaseSpecification<Basket>
{
    public BasketWithItemsSpecification(int basketId)
        : base(b => b.Id == basketId)
    {
        AddInclude(b => b.Items);
    }
    public BasketWithItemsSpecification(string buyerId)
        : base(b => b.BuyerId == buyerId)
    {
        AddInclude(b => b.Items);
    }
}
```

## Generic EF Repository with Specification

```csharp
// https://github.com/dotnet-architecture/eShopOnWeb
public IEnumerable<T> List(ISpecification<T> spec)
{
    // fetch a Queryable that includes all expression-based includes
    var queryableResultWithIncludes = spec.Includes
        .Aggregate(_dbContext.Set<T>().AsQueryable(),
            (current, include) => current.Include(include));

    // modify the IQueryable to include any string-based include statements
    var secondaryResult = spec.IncludeStrings
        .Aggregate(queryableResultWithIncludes,
            (current, include) => current.Include(include));

    // return the result of the query using the specification's criteria expression
    return secondaryResult
                    .Where(spec.Criteria)
                    .AsEnumerable();
}
```

Although it's not recommended to return IQueryable from a repository, it's perfectly fine to use them within the repository to build up a set of results. You can see this approach used in the List method above, which uses intermediate IQueryable expressions to build up the query's list of includes before executing the query with the specification's criteria on the last line.

<hr/>

Get more information at [here](https://deviq.com/specification-pattern/).
