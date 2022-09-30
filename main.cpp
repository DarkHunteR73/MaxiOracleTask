#include "dal.h"

int main(int argc, char* argv[]) {
    const string userName;
    const string password;
    const string db;

    auto dal = new dataAccessLayer(userName,password,db);
    dal->testQuery();
}
