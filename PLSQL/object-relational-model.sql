/*

The object-type model, in general, is similar to the class mechanism found in C++ and Java.
Objects offer other advantages over a purely relational approach, such as:

Objects Can Encapsulate Operations Along with Data
Objects Are Efficient
Objects Can Represent Part-Whole Relationships

You can fetch and manipulate a set of related objects as a single unit. A single request to fetch an object from the server can retrieve other objects that are connected to it. When you reference a column of a SQL object type, you retrieve the whole object.

An object type is a kind of data type, we can uuse this same way as any standard data ttype, For example, you can specify an object type as the data type of a column in a relational table

Object types are composed of attributes and methods
Attributes have declared data types which can, in turn, be other object types.

A variable of an object type is an instance of the type, or an object.

object types can be used in SQL statements in most of the same places you use types such as NUMBER or VARCHAR2

The general kinds of methods that can be declared in a type definition are:

Member Methods

Using member methods, you can provide access to the data of an object, and otherwise define operations that an application performs on the data. To perform an operation, the application calls the appropriate method on the appropriate object.

Static Methods

Static methods compare object instances and perform operations that do not use the data of any particular object, but, instead, are global to an object type.

Constructor Methods

A default constructor method is implicitly defined for every object type, unless it is overwritten with a user-defined constructor. A constructor method is called on a type to construct or create an object instance of the type.

There are special member methods - map or order methods - that we use to tell Oracle Database how to compare two objects of the same datatype.


*/

CREATE TYPE person_typ AS OBJECT (
  idno           NUMBER,
  first_name     VARCHAR2(20),
  last_name      VARCHAR2(25),
  email          VARCHAR2(25),
  phone          VARCHAR2(20),
  MAP
  MEMBER FUNCTION get_idno RETURN NUMBER,
  MEMBER PROCEDURE display_details ( SELF IN OUT NOCOPY person_typ ));
/

CREATE TYPE BODY person_typ AS
  MAP
  MEMBER FUNCTION get_idno RETURN NUMBER IS
  BEGIN
    RETURN idno;
  END;
  MEMBER PROCEDURE display_details ( SELF IN OUT NOCOPY person_typ ) IS
  BEGIN
    -- use the PUT_LINE procedure of the DBMS_OUTPUT package to display details
    DBMS_OUTPUT.PUT_LINE(TO_CHAR(idno) || ' ' || first_name || ' ' || last_name);
    DBMS_OUTPUT.PUT_LINE(email || ' '  || phone);
  END;
END;
/

-- requires existing person_typ fr. Ex 1-1
CREATE TABLE contacts (
  contact         person_typ,
  contact_date    DATE );

INSERT INTO contacts VALUES (
  person_typ (65, 'Verna', 'Mills', 'vmills@example.com', '1-650-555-0125'),
  to_date('24 Jun 2003', 'dd Mon YYYY'));



-------------

CREATE OR REPLACE TYPE food_ot AS OBJECT
(
   name VARCHAR2 (100),
   food_group VARCHAR2 (50),
   grown_in VARCHAR2 (100),
   CONSTRUCTOR FUNCTION food_ot
      RETURN SELF AS RESULT,
   CONSTRUCTOR FUNCTION food_ot (NAME_IN IN VARCHAR2)
      RETURN SELF AS RESULT
)
   NOT FINAL;

CREATE OR REPLACE TYPE BODY food_ot
IS
   CONSTRUCTOR FUNCTION food_ot
      RETURN SELF AS RESULT
   IS
   BEGIN
      RETURN;
   END;

   CONSTRUCTOR FUNCTION food_ot (NAME_IN IN VARCHAR2)
      RETURN SELF AS RESULT
   IS
   BEGIN
      self.name := NAME_IN;
      RETURN;
   END;
END;

DECLARE
   my_favorite_vegetable   food_ot
      := food_ot ('Brussels Sprouts');
BEGIN
   DBMS_OUTPUT.put_line (
      my_favorite_vegetable.name || ' are yummy!');
END;

DECLARE
   my_favorite_vegetable   food_ot
      := food_ot ();
BEGIN
   my_favorite_vegetable.name := 'Brussels Sprouts';
   DBMS_OUTPUT.put_line (
      my_favorite_vegetable.name || ' are yummy!');
END;

-------------

CREATE OR REPLACE TYPE food_ot
   AS OBJECT
(
   name VARCHAR2 (100),
   food_group VARCHAR2 (50),
   grown_in VARCHAR2 (100),
   CONSTRUCTOR FUNCTION food_ot (name_in         IN VARCHAR2,
                                 food_group_in   IN VARCHAR2,
                                 grown_in_in     IN VARCHAR2)
      RETURN SELF AS RESULT
)
   NOT FINAL;

CREATE OR REPLACE TYPE BODY food_ot
IS
   CONSTRUCTOR FUNCTION food_ot (name_in         IN VARCHAR2,
                                 food_group_in   IN VARCHAR2,
                                 grown_in_in     IN VARCHAR2)
      RETURN SELF AS RESULT
   IS
   BEGIN
      self.name := name_in;
      self.food_group := grown_in_in;
      self.grown_in := food_group_in;
      RETURN;
   END;
END;

DECLARE
   my_favorite_vegetable   food_ot
      := food_ot ('Brussels Sprouts', 'Vegetables', 'Dirt');
BEGIN
   DBMS_OUTPUT.put_line (
         my_favorite_vegetable.name
      || ' are grown in '
      || my_favorite_vegetable.grown_in);
END;
-- ORA-06550: line 3, column 10:
-- PLS-00307: too many declarations of 'FOOD_OT' match this call

DECLARE
   my_favorite_vegetable   food_ot
      := food_ot (name_in         => 'Brussels Sprouts',
                  food_group_in   => 'Vegetables',
                  grown_in_in     => 'Dirt');
BEGIN
   DBMS_OUTPUT.put_line (
         my_favorite_vegetable.name
      || ' are grown in '
      || my_favorite_vegetable.grown_in);
END;
-- Statement processed.
-- Brussels Sprouts are grown in Vegetables
-- But if I use named notation, since my parameter names are different from the attribute names, then it works. Notice the "wrong" grown-in value.

-- Which begs the question: what if I define my own constructor and use attribute names for parameter names?
CREATE OR REPLACE TYPE food_ot
   AS OBJECT
(
   name VARCHAR2 (100),
   food_group VARCHAR2 (50),
   grown_in VARCHAR2 (100),
   CONSTRUCTOR FUNCTION food_ot (name         IN VARCHAR2,
                                 food_group   IN VARCHAR2,
                                 grown_in     IN VARCHAR2)
      RETURN SELF AS RESULT
)
   NOT FINAL;


CREATE OR REPLACE TYPE BODY food_ot
IS
   CONSTRUCTOR FUNCTION food_ot (name         IN VARCHAR2,
                                 food_group   IN VARCHAR2,
                                 grown_in     IN VARCHAR2)
      RETURN SELF AS RESULT
   IS
   BEGIN
      self.name := name;
      self.food_group := grown_in;
      self.grown_in := food_group;
      RETURN;
   END;
END;

-- And now for the culmination of my exploration: even without named notation, my user-defined constructor completely overrides the default! Which is really helpful if you need to run some special logic any and every time an instance of a type is initialized.

CREATE TYPE food_ot AS OBJECT
(
   name VARCHAR2 (100),
   food_group VARCHAR2 (50),
   grown_in VARCHAR2 (100)
)
   NOT FINAL
/

CREATE TABLE meals
(
   served_on     DATE,
   main_course   food_ot
);
/

BEGIN
   INSERT INTO meals (served_on, main_course)
        VALUES (SYSDATE, food_ot ('Shrimp cocktail', 'PROTEIN', 'Ocean'));

   INSERT INTO meals (served_on, main_course)
        VALUES (SYSDATE + 1, food_ot ('House Salad', 'VEGETABLE', 'Farm'));

   COMMIT;
END;
/

  SELECT m.main_course.name name
    FROM meals m
ORDER BY m.main_course.name
/

NAME
---------------
House salad
Shrimp Cocktail

SELECT m.main_course.name name
  FROM meals m, meals m2
 WHERE m.main_course = m2.main_course
 ORDER BY m.main_course.name
/

NAME
---------------
House salad
Shrimp Cocktail

That default equality comparison does an attribute-by-attribute comparison - and that only works if you do not have LOB or user-defined type columns. In those cases, you will see an error:

CREATE TYPE food_with_clob_ot AS OBJECT
(
   name VARCHAR2 (100),
   grown_in CLOB
)
   NOT FINAL
/

CREATE TABLE meals_with_clobs
(
   served_on     DATE,
   main_course   food_with_clob_ot
);
/

SELECT m.main_course.name name
  FROM meals_with_clobs m, meals_with_clobs m2
 WHERE m.main_course = m2.main_course
 ORDER BY m.main_course.name
/

ORA-22901: cannot compare VARRAY or LOB attributes of an object type

  SELECT m.main_course.name name
    FROM meals m
ORDER BY m.main_course
/

ORA-22950: cannot ORDER objects without MAP or ORDER method

  SELECT m.main_course.name name
    FROM meals m, meals m2
   WHERE m.main_course > m2.main_course
/

ORA-22950: cannot ORDER objects without MAP or ORDER method

-- A MAP method performs calculations on the attributes of the object to produce a return value of ny Oracle built-in data types (except LOBs and BFILEs) and ANSI SQL types such as CHARACTER or REAL.

-- This method is called automatically by Oracle Database to evaluate such comparisons as obj_1 > obj_2 and comparisons that are implied by the DISTINCT, GROUP BY, UNION, and ORDER BY clauses - since these all require sorting by rows in the table.

CREATE TYPE food_t AS OBJECT
    (name VARCHAR2 (100)
  , food_group VARCHAR2 (100)
  , grown_in VARCHAR2 (100)
  , MAP MEMBER FUNCTION food_mapping
         RETURN NUMBER
    )
    NOT FINAL;
/

CREATE OR REPLACE TYPE BODY food_t
IS
    MAP MEMBER FUNCTION food_mapping
        RETURN NUMBER
    IS
    BEGIN
        RETURN (CASE self.food_group
                      WHEN 'PROTEIN' THEN 30000
                      WHEN 'LIQUID' THEN 20000
                      WHEN 'CARBOHYDRATE' THEN 15000
                      WHEN 'VEGETABLE' THEN 10000
                  END
                  + LENGTH (self.name));
    END;
END;
/

BEGIN
   -- Populate the meal table
   INSERT INTO meals
        VALUES (SYSDATE, food_ot ('Shrimp cocktail', 'PROTEIN', 'Ocean'));

   INSERT INTO meals
        VALUES (SYSDATE + 1, food_ot ('Stir fry tofu', 'PROTEIN', 'Wok'));

   INSERT INTO meals
           VALUES (SYSDATE + 1,
                   food_ot ('Peanut Butter Sandwich',
                              'CARBOHYDRATE',
                              'Kitchen'));

   INSERT INTO meals
           VALUES (SYSDATE + 1,
                   food_ot ('Brussels Sprouts', 'VEGETABLE', 'Backyard'));

   COMMIT;
END;
/

-- https://docs.oracle.com/en/database/oracle/oracle-database/21/adobj/Sql-object-types-and-references.html#GUID-821233F6-ABA9-4100-B5E4-937F7DC57102

-- An object whose value is NULL is called atomically null.

-- An atomically null object is different from an object that has null values for all its attributes.

CREATE TABLE department_mgrs (
  dept_no     NUMBER PRIMARY KEY,
  dept_name   CHAR(20),
  dept_mgr    person_typ,
  dept_loc    location_typ,
  CONSTRAINT  dept_loc_cons1
      UNIQUE (dept_loc.building_no, dept_loc.city),
  CONSTRAINT  dept_loc_cons2
       CHECK (dept_loc.city IS NOT NULL) );

Define indexes on leaf-level scalar attributes of column objects. You can only define indexes on REF attributes or columns if the REF is scoped.

CREATE TABLE department_loc (
  dept_no     NUMBER PRIMARY KEY,
  dept_name   CHAR(20),
  dept_addr   location_typ );

CREATE INDEX  i_dept_addr1
          ON  department_loc (dept_addr.city);

CREATE TABLE movement (
     idno           NUMBER,
     old_office     location_typ,
     new_office     location_typ );

CREATE TRIGGER trigger1
  BEFORE UPDATE
             OF  office_loc
             ON  office_tab
   FOR EACH ROW
           WHEN  (new.office_loc.city = 'Redwood Shores')
   BEGIN
     IF :new.office_loc.building_no = 600 THEN
      INSERT INTO movement (idno, old_office, new_office)
       VALUES (:old.occupant.idno, :old.office_loc, :new.office_loc);
     END IF;
   END;/
INSERT INTO office_tab VALUES
    ('BE32', location_typ(300, 'Palo Alto' ),person_typ(280, 'John Chan',
       '415-555-0101'));

UPDATE office_tab set office_loc =location_typ(600, 'Redwood Shores')
  where office_id = 'BE32';

#2 SELECT contact.idno FROM contacts; --Illegal
#3 SELECT contacts.contact.idno FROM contacts; --Illegal
#4 SELECT p.contact.idno FROM contacts p; --Correct


-- https://docs.oracle.com/en/database/oracle/oracle-database/21/adobj/object-methods.html#GUID-0CC16EAF-E96B-443F-8F97-599A3EA8DA1D

/*

You define a member method in the object type for each operation that you want an object of that type to be able to perform. Non-comparison member methods are declared as either MEMBER FUNCTION or MEMBER PROCEDURE. Comparison methods use MAP MEMBER FUNCTION or ORDER MEMBER FUNCTION

Member methods have a built-in parameter named SELF that denotes the object instance currently invoking the method.

SELF must be the first parameter passed to the method.
In member functions, if SELF is not declared, its parameter mode defaults to IN.

In member procedures, if SELF is not declared, its parameter mode defaults to IN OUT. The default behavior does not include the NOCOPY compiler hint.

The values of a scalar data type such as CHAR or REAL have a predefined order, which allows them to be compared. But an object type, such as a person_typ, which can have multiple attributes of various data types, has no predefined axis of comparison. You have the option to define a map method or an order method for comparing objects, but not both.

A map method maps object return values to scalar values and can order multiple values by their position on the scalar axis. An order method directly compares values for two particular objects.

Order methods make direct one-to-one object comparisons.
As with map methods, an order method, if one is defined, is called automatically whenever two objects of that type need to be compared.

In a type hierarchy, if the root type (supertype) does not specify a map or an order method, neither can the subtypes.

The type hierarchy consists of a parent object type, called a supertype, and one or more levels of child object types, called subtypes, which are derived from the parent.

Subtypes are created using the keyword UNDER as follows:

CREATE TYPE student_typ UNDER person_typ

You can specialize the attributes or methods of a subtype in these ways:

Add new attributes that its parent supertype does not have.
Add entirely new methods that the parent does not have.
Change the implementation of some of the methods that a subtype inherits


Object type: NOT FINAL means subtypes can be derived. FINAL, (default) means that no subtypes can be derived from it.
Method:  NOT FINAL (default) means the method can be overridden. FINAL means that subtypes cannot override it by providing their own implementation.

DROP TYPE person_typ FORCE;
-- above necessary if you have previously created object

DROP TYPE person_typ FORCE;
-- if created
CREATE OR REPLACE TYPE person_typ AS OBJECT (
 idno           NUMBER,
 name           VARCHAR2(30),
 phone          VARCHAR2(20),
 MAP MEMBER FUNCTION get_idno RETURN NUMBER,
 MEMBER FUNCTION show RETURN VARCHAR2)
 NOT FINAL;
/

CREATE OR REPLACE TYPE BODY person_typ AS
 MAP MEMBER FUNCTION get_idno RETURN NUMBER IS
 BEGIN
   RETURN idno;
 END;
-- function that can be overriden by subtypes
 MEMBER FUNCTION show RETURN VARCHAR2 IS
 BEGIN
   RETURN 'Id: ' || TO_CHAR(idno) || ', Name: ' || name;
 END;

END;
/


CREATE TYPE student_typ UNDER person_typ (
   dept_id NUMBER,
   major VARCHAR2(30),
   OVERRIDING MEMBER FUNCTION show RETURN VARCHAR2)
   NOT FINAL;
/

CREATE TYPE BODY student_typ AS
 OVERRIDING MEMBER FUNCTION show RETURN VARCHAR2 IS
 BEGIN
    RETURN (self AS person_typ).show || ' -- Major: ' || major ;
   -- first calls the person_typ show method to do the common actions and then does its own specific action
 END;

END;
/

-- ALTER TYPE person_typ FINAL;

Generalized invocation provides a mechanism to invoke a method of a supertype or a parent type, rather than the specific subtype member method. : (SELF AS person_typ).show

Generalized expression, like member method invocation, is also supported when a method is invoked with an explicit self argument.

person_typ.show((myvar2 AS person_typ)); -- Generalized expression, note aouble parentheses are used

You can create tables that contain supertype and subtype instances.

CREATE TABLE person_obj_table OF person_typ;

INSERT INTO person_obj_table
  VALUES (person_typ(12, 'Bob Jones', '650-555-0130'));

INSERT INTO person_obj_table
  VALUES (student_typ(51, 'Joe Lane', '1-650-555-0140', 12, 'HISTORY'));

INSERT INTO person_obj_table
  VALUES (employee_typ(55, 'Jane Smith', '1-650-555-0144',
                       100, 'Jennifer Nelson'));

INSERT INTO person_obj_table
  VALUES (part_time_student_typ(52, 'Kim Patel', '1-650-555-0135', 14,
         'PHYSICS', 20));

If a type is not instantiable, you cannot instantiate instances of that type. You might use this with types intended to serve solely as supertypes

A non-instantiable method serves as a placeholder. It is declared but not implemented in the type.

If a subtype does not provide an implementation for every inherited non-instantiable method, the subtype itself, like the supertype, must be declared not instantiable.

2.3.9.1 Overloading Methods

Substitutability

*/

CREATE OR REPLACE TYPE rectangle_typ AS OBJECT (
  len NUMBER,
  wid NUMBER,
  MAP MEMBER FUNCTION area RETURN NUMBER);
/

CREATE OR REPLACE TYPE BODY rectangle_typ AS
  MAP MEMBER FUNCTION area RETURN NUMBER IS
  BEGIN
     RETURN len * wid;
  END area;
END;
/

DROP TYPE location_typ FORCE;
-- above necessary if you have previously created object
CREATE OR REPLACE TYPE location_typ AS OBJECT (
  building_no  NUMBER,
  city         VARCHAR2(40),
  ORDER MEMBER FUNCTION match (l location_typ) RETURN INTEGER );/
CREATE OR REPLACE TYPE BODY location_typ AS
  ORDER MEMBER FUNCTION match (l location_typ) RETURN INTEGER IS
  BEGIN
    IF building_no < l.building_no THEN
      RETURN -1;               -- any negative number will do
    ELSIF building_no > l.building_no THEN
      RETURN 1;                -- any positive number will do
    ELSE
      RETURN 0;
    END IF;
  END;
END;/

-- invoking match method
DECLARE
loc location_typ;
secloc location_typ;
a number;

BEGIN
 loc :=NEW location_typ(300, 'San Francisco');
 secloc :=NEW location_typ(200, 'Redwood Shores');
 a := loc.match(secloc);

DBMS_OUTPUT.PUT_LINE('order (1 is greater, -1 is lesser):' ||a); -- prints order:1
 END;
/