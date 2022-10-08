#include "dal.h"

dataAccessLayer::dataAccessLayer(string userName, string password, string db) {
    env = Environment::createEnvironment(Environment::DEFAULT);
    conn = env->createConnection(userName, password, db);
}

dataAccessLayer::~dataAccessLayer() {
    env->terminateConnection(conn);
    Environment::terminateEnvironment(env);
}

vector<Record> dataAccessLayer::getSortedQuery(const string arg) {
    if (arg != "-s" && arg != "-d") {
        throw std::invalid_argument("Invalid argument: " + arg);
    }
    
    string sqlStmt = "SELECT * FROM ADDRESS_VIEW";
    stmt = conn->createStatement(sqlStmt);
    ResultSet *rset = stmt->executeQuery();

    vector<Record> result;

    try
    {
        while (rset->next())
        {
            result.push_back(Record(rset->getString(1),rset->getInt(2)));
        }        
    }
    catch(SQLException e)
    {
        std::cerr << e.getErrorCode() << '\n';
        std::cerr << e.getMessage() << std::endl;
    }
    
    stmt->closeResultSet(rset);
    conn->terminateStatement(stmt);

    if (arg == "d") {
        for (size_t i = 0; i < result.size(); ++i) {
            for (size_t j = 0; j < result.size() - i - 1; ++j) {
                if (result[j].count > result[j + 1].count) {
                    std::swap(result[j].count, result[j + 1].count);
                }                
            }            
        }
    } else {
        for (size_t i = 0; i < result.size(); ++i) {
            for (size_t j = 0; j < result.size() - i - 1; ++j) {
                if (result[j].address > result[j + 1].address) {
                    std::swap(result[j].address, result[j + 1].address);
                }                
            }            
        }    
    }    

    return result;
}