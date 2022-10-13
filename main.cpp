#include "dal.h"

#include <memory>

int main(int argc, char* argv[]) {
    SortingType sortingType;

    if (argc > 1) {
        for (int i = 0; i < argc; ++i) {
            if (static_cast<string>(argv[i]) == "-d") {
                sortingType = sortByCount;
            } else if (static_cast<string>(argv[i]) == "-s") {
                sortingType = sortByAddress;
            }
        }
    }


    const string userName { "maxi_task_db" };
    const string password { "73501505" };
    const string db { "oracle21xe" };

    std::unique_ptr<dataAccessLayer> dal { new dataAccessLayer(userName,password,db) };
    vector<Record> res;

    try
    {
        res = dal->getSortedQuery(sortingType);
    }
    catch(const std::exception& e)
    {
        std::cerr << e.what() << '\n';
        return EXIT_FAILURE;
    }

    for (auto &&i : res)
    {
        std::cout << i.address << '\t' << i.count << std::endl;
    }

    return EXIT_SUCCESS;
}
