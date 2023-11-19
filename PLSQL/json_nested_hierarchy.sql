-- EMP table

with empHier (empno, mgr, ename, lvl) as (
    select
    	empno, mgr, ename, 1 lvl
    from scott.emp
    where mgr is null
    union all
    select
    	e.empno, e.mgr, e.ename, h.lvl + 1
    from scott.emp e
    join empHier h
    on h.empno = e.mgr
) search depth first by empno set rn,
empHierWithLeadLag as (
	select
    	json_object(empno, mgr) node,
    	lead(lvl,1,1) over (order by rn) lead_lvl,
    	lag(lvl) over (order by rn) lag_lvl,
    	lvl,
    	rn
    from empHier
)
select
  json_query(
    xmlcast(
      xmlagg(
        xmlelement(e,
          case
            when lvl - lag_lvl = 1 then ',"children":['
            when lvl > 1 then ','
          end ||
          substr(node, 1, length(node) - 1) ||
          case
            when lvl >= lead_lvl then '}' ||
                 rpad(' ', (lvl - lead_lvl) * 2 + 1, ']}')
          end
        )
        order by rn
      )
      as clob
    )
    , '$' returning clob pretty) res
from empHierWithLeadLag;




create table relationship (
  id         integer primary key,
  parent_id  integer,
  name       varchar2(20) not null,
  constraint fk_parent foreign key (parent_id) references relationship (id)
)
/

insert into relationship (id, parent_id, name)
select 1, null, 'Joe' from dual union all
select 2, 1, 'Steve'  from dual union all
select 3, 1, 'Mandy'  from dual union all
select 4, 2, 'Jeff'   from dual union all
select 5, 3, 'Paul'   from dual union all
select 6, 5, 'Sue'    from dual union all
select 7, 5, 'Marc'   from dual
/

commit;

      --     1
      --   2   3
      -- 4       5
      --       6   7

with rel_hier(id, parent_id, name, lvl) as (
  select id, parent_id, name, 1             -- anchor
  from relationship
  where parent_id is null
  union all
  select n.id, n.parent_id, n.name, h.lvl + 1 -- recursion
  from rel_hier h
  join relationship n on n.parent_id = h.id
)
search depth first by id set rn         -- depth first traversal order given by rn, siblings ordered by name
, rel_hier_with_leadlag as (
  select r.*
       , lag(lvl) over (order by rn) as lag_lvl         -- The previous level in recursive traversal
       , lead(lvl, 1, 1) over (order by rn) as lead_lvl -- The next level in recursive traversal, defaulted to 1 rather than null, as makes resolving closing tags easier
       , json_object(
           'id'   value id
         , 'name' value name
         ) jso
  from rel_hier r
)
select
  json_query(   -- This line not required
    xmlcast(    -- Concatenate lines together, working around listagg 4000 byte limit
      xmlagg(
        xmlelement(e,
          case
            when lvl - lag_lvl = 1 then ',"children":['    -- Level incremented by one, so child level, start array
            when lvl > 1 then ','                          -- appending when not first level
          end ||
          substr(jso, 1, length(jso) - 1) ||               -- remove last brace, as we are controlling children
          case
            when lvl >= lead_lvl then '}' ||               -- Level same or greater than next level, so close json_object
                 rpad(' ', (lvl - lead_lvl) * 2 + 1, ']}') -- and add as many closing array / object blocks as required
          end
        )
        order by rn
      )
      as clob
    )
    , '$' returning clob pretty) json_res
from rel_hier_with_leadlag
/

https://paulzipblog.wordpress.com/2020/04/29/hierarchical-json-structures/

