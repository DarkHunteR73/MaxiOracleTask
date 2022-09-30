#pragma once

#include <iostream>
#include <string>

#include <occi.h>

using namespace oracle::occi;
using std::string;

class dataAccessLayer {
public:
    dataAccessLayer(string userName, string password, string db);

    ~dataAccessLayer();

    void testQuery();

private:
    Environment *env;
    Connection *conn;
    Statement *stmt;
};