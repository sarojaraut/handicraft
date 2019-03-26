SELECT property_value
FROM   database_properties
WHERE  property_name = 'DEFAULT_EDITION';

CREATE EDITION edition-name;
CREATE EDITION edition-name AS CHILD OF parent-edition;

The default database edition can be switched using the ALTER DATABASE command.

ALTER DATABASE DEFAULT EDITION = edition-name;

SELECT SYS_CONTEXT('USERENV', 'SESSION_EDITION_NAME') AS edition FROM dual;

ALTER SESSION SET EDITION = ora$base;

Editionable Objects

The following objects are editionable:

FUNCTION
LIBRARY
PACKAGE and PACKAGE BODY
PROCEDURE
TRIGGER
TYPE and TYPE BODY
SYNONYM
VIEW
All other objects are noneditionable. Notice, that means tables can not be editioned!

Dictionary Views

The following views contain information relating to editions or editioning components:

*_EDITIONS
*_EDITION_COMMENTS
*_OBJECTS
*_OBJECTS_AE
*_ERRORS
*_ERRORS_AE
*_USERS
*_VIEWS
*_EDITIONING_VIEWS
*_EDITIONING_VIEWS_AE
*_EDITIONING_VIEW_COLS
*_EDITIONING_VIEW_COLS_AE

(
22680150
,22680171
,22680233
,22680234
,22680326
,22680381
)

'BEGIN ITTR1.API_VALID_WEB_ORDER(p_num  => :apinum, p_text => :apitext); END;

http://localhost/ords/cmsdev/ittr1/testmodule2/test2/

http://ords-alb.dev.transit.ri-tech.io/ords/cmsdev/ittr1/testmodule2/test2/

 users.4021463404: "" => "sarojraut"
 
sarojraut = 

-----BEGIN PGP MESSAGE-----

wcFMA757QQRDyWe7ARAAG5rMVvmNHcxoxwdQbtj269iNTZTSOObT5wIww++uNpHLLYUJm1CRpsr6Xtv82fpsDDT0VCvqz2SzfdRFa2tjSgB9Xu67YMEASfEMx/rqZdLNv4fSi90YnjQOqxcI0bsL/NwZK48lGrcNbRzbie5Wbt2nswDMnCKYtPZD8I+QMYM7dl0qFjUacPn/R2SgTSuUAxMJbrEYiWMdgImHV2g+JSrkfO6PKcgmm15IS78rOny45KRgCl0vW13sm4beeJDaJzCRzC37k7NZdSPfX5LtUf+/jAFP6gdl6nXHSxaUzEwmSgF+ONb/jHEXbvKG0kTOQtjKLtE8VkROBnAmM5dEwnx3qxwVOSAESLm8sYBaAELDv49INFl9zThB3zFz8IuSsyjzL0YM5tfo1Eh0+LtLbFFfOz8aeYQ/hTJLmHnEAlXI7hjT/t/R4bDTZFiVQREdJptH7ZTlJGzRmyFXGfVgjiRt6nFPk/vLhc6M/L67AmxUNwlu+SB25aaRl7+aW2/JmHVz5VB0Sn5uAkKRf8o15Sv0uitUUvZUxBA4oMBM4uoYTRqIHF6VI0fw1yM+smOg61AW/7ePo+9h1wGWm5t4bsmXkqEEvIDcet53Jm6v0nvH69p9cnU0Q3hIeHjf9KytZDMlNMGhCElTm3MhJAMVX8dPZTwUimxO+SIYw7eLOJ/S4AHkS8vVYbWCR9TJsXUPT16b0eH0NeC54HbhD4LgGuKGer8e4Ibk7U7U8921EQ42zv6JnWk48OCw4uHgBengM+SrtVMl1ciPLhpKO+DzApLM4jwr81LhDfwA

-----END PGP MESSAGE-----

echo "wcFMA757QQRDyWe7ARAAG5rMVvmNHcxoxwdQbtj269iNTZTSOObT5wIww++uNpHLLYUJm1CRpsr6Xtv82fpsDDT0VCvqz2SzfdRFa2tjSgB9Xu67YMEASfEMx/rqZdLNv4fSi90YnjQOqxcI0bsL/NwZK48lGrcNbRzbie5Wbt2nswDMnCKYtPZD8I+QMYM7dl0qFjUacPn/R2SgTSuUAxMJbrEYiWMdgImHV2g+JSrkfO6PKcgmm15IS78rOny45KRgCl0vW13sm4beeJDaJzCRzC37k7NZdSPfX5LtUf+/jAFP6gdl6nXHSxaUzEwmSgF+ONb/jHEXbvKG0kTOQtjKLtE8VkROBnAmM5dEwnx3qxwVOSAESLm8sYBaAELDv49INFl9zThB3zFz8IuSsyjzL0YM5tfo1Eh0+LtLbFFfOz8aeYQ/hTJLmHnEAlXI7hjT/t/R4bDTZFiVQREdJptH7ZTlJGzRmyFXGfVgjiRt6nFPk/vLhc6M/L67AmxUNwlu+SB25aaRl7+aW2/JmHVz5VB0Sn5uAkKRf8o15Sv0uitUUvZUxBA4oMBM4uoYTRqIHF6VI0fw1yM+smOg61AW/7ePo+9h1wGWm5t4bsmXkqEEvIDcet53Jm6v0nvH69p9cnU0Q3hIeHjf9KytZDMlNMGhCElTm3MhJAMVX8dPZTwUimxO+SIYw7eLOJ/S4AHkS8vVYbWCR9TJsXUPT16b0eH0NeC54HbhD4LgGuKGer8e4Ibk7U7U8921EQ42zv6JnWk48OCw4uHgBengM+SrtVMl1ciPLhpKO+DzApLM4jwr81LhDfwA" | base64 -D | keybase pgp decrypt; echo
                          
           '               


My Thoughts:

If prty_code(contains SGs) can not be used as convinient way of identifying NDD service groups(multiple ORs??) during wave processes then

We can ppack_grp_code conditional, will only be populated if order is of NDD type.

Introducing a new column altogether will be much bigger task that making it conditional.

p_ii_hso_pick

We can change pkm_export not to write data to w_io_dc_hso_pick

PPACK_GRP_CODE 



