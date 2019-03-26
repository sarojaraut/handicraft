CREATE OR REPLACE PACKAGE s_http_code_const
IS
--
-- NAME:  s_http_code_const
-- TYPE:  PL/SQL Package specification
-- TITLE: Package for all HTTP response Codes
-- NOTES:
--
--$Revision:   1.0  $
-------------------------------------------------------------------------------
-- Version | Date      | Author             | Reason
-- 1.0     |22/11/2017 | T. Robson/S. Raut  | Initial Revision
-------------------------------------------------------------------------------

    --
    -- Success Series
    --
    C_ok                           CONSTANT NUMBER  := 200;
    C_created                      CONSTANT NUMBER  := 201;
    C_accepted                     CONSTANT NUMBER  := 202;
    C_no_content                   CONSTANT NUMBER  := 204;
    C_partial_content              CONSTANT NUMBER  := 206;
    --
    -- Client Error Series
    --
    C_bad_request                  CONSTANT NUMBER  := 400;
    C_unauthorised                 CONSTANT NUMBER  := 401;
    C_not_found                    CONSTANT NUMBER  := 404;
    C_method_not_allowed           CONSTANT NUMBER  := 405;
    C_not_acceptable               CONSTANT NUMBER  := 406;
    C_conflict                     CONSTANT NUMBER  := 409;
    C_precndition_required         CONSTANT NUMBER  := 412;
    C_expectation_failed           CONSTANT NUMBER  := 417;
    C_locked                       CONSTANT NUMBER  := 423;
    --
    -- Server Error Series
    --
    C_internal_server_error        CONSTANT NUMBER  := 500;
    C_not_implemented              CONSTANT NUMBER  := 501;
    C_insufficient_storage         CONSTANT NUMBER  := 507;

END s_http_code_const;
/

SHOW ERR;
