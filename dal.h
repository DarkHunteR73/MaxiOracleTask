#pragma once

#include <iostream>
#include <string>
#include <vector>
#include <exception>

#include <occi.h>

using namespace oracle::occi;
using std::string;
using std::vector;

struct Record {
    string address;
    int count;

    Record(string _addr, int _count)
        :address(_addr), count(_count) {}
};

class dataAccessLayer {
public:
    dataAccessLayer(string userName, string password, string db);

    ~dataAccessLayer();

    vector<Record> getSortedQuery(const string arg);

private:
    Environment *env;
    Connection *conn;
    Statement *stmt;
};