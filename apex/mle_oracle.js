// Language attribute to PL/SQL.
DECLARE
ctx DBMS_MLE.context_handle_t;
user_code clob := q'~
    const oracledb = require("mle-js-oracledb");
    function extendProjectTasks( status ) {
        if (status !== "Closed") {
            return true;
        }
        else {
            return false;
        }
    }
    const conn = oracledb.defaultConnection();
    for (var row of conn.execute("select id, status from project_tasks where project = 'Email Integration'").rows) {
    if ( extendProjectTasks( row[1] )) {
        oracledb.defaultConnection().execute( "update project_tasks set end_date = end_date + 1 where id = :id", { id: row[0] } );
        console.log("The task with the ID: " + row[0] + " and the status " + row[1] + " has been extended successfully!")
        }
    };
~';
BEGIN
    ctx := DBMS_MLE.create_context();
    DBMS_MLE.eval(ctx, 'JAVASCRIPT', user_code);
    DBMS_MLE.drop_context(ctx);
END;

// can be tested in sql workshop using Language attribute to JavaScript (MLE).
// create new process Language => JavaScript (MLE)
function extendProjectTasks( status ) {
    if (status !== "Closed") {
        return true;
    }
    else {
        return false;
    }
}

for ( var row of apex.conn.execute( "select id, status from project_tasks where project = :project", { project: "Email Integration" } ).rows ) {
    if ( extendProjectTasks( row.STATUS )) {
        apex.conn.execute( "update project_tasks set end_date = end_date + 1 where id = :id", { id: row.ID } );
        console.log("The task with the ID: " + row.ID + " and the status " + row.STATUS + " has been extended successfully!")
    }
}

