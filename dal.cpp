#include "dal.h"

dataAccessLayer::dataAccessLayer(string userName, string password, string db) {
    env = Environment::createEnvironment(Environment::DEFAULT);
    conn = env->createConnection(userName, password, db);
}

dataAccessLayer::~dataAccessLayer() {
    env->terminateConnection(conn);
    Environment::terminateEnvironment(env);
}

void dataAccessLayer::testQuery() {
    string sqlStmt = "SELECT * FROM DUAL";
    stmt = conn->createStatement(sqlStmt);
    ResultSet *rset = stmt->executeQuery();

    try
    {
        while (rset->next())
        {
            string col = rset->getString(1);

            std::cout << col << std::endl;
        }        
    }
    catch(SQLException e)
    {
        std::cerr << e.getErrorCode() << '\n';
        std::cerr << e.getMessage() << std::endl;
    }
    
    stmt->closeResultSet(rset);
    conn->terminateStatement(stmt);
}