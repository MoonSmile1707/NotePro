# Index Types

<hr/>

PostgreSQL provides several index types: B-tree, Hash, GiST, SP-GiST, GIN and BRIN. Each index type use a different algorithms tha is best suited to different types of queries. By default, the CREATE INDEX command create B-tree indexes, which fit the most common situations.

B-trees can handle equality and range queries on data that can be sorted into some ordering. In particular, the PostgreSQL query planner will consider using a B-tree index whenever an indexed column is involved in a comparison using on of these operators:


    <
    <=
    =
    >=
    >



Constructs equivalent to combinations of these operators.

<hr/>

Get more information at [here](https://www.postgresql.org/docs/current/indexes-types.html).
