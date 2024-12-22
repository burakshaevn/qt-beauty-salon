#ifndef DOMAIN_H
#define DOMAIN_H

#include <QString>

enum class Role {
    User,
    Admin
};

enum class Tables {
    unknown,
    clients,
    services,
    masters,
    appointments
};

inline Tables StringToTables(const QString& table){
    if (table == "clients"){
        return Tables::clients;
    }
    else if (table == "services"){
        return Tables::services;
    }
    else if (table == "masters"){
        return Tables::masters;
    }
    else if (table == "appointments"){
        return Tables::appointments;
    }
    else{
        return Tables::unknown;
    }
}

inline QString TablesToString(const Tables& table){
    switch(table){
        case Tables::clients:
            return "clients";
        case Tables::services:
            return "services";
        case Tables::masters:
            return "masters";
        case Tables::appointments:
            return "appointments";
        default:
            return "unknown";
    }
}

inline Role StringToRole(const QString& role) {
    if (role == "admin"){
        return Role::Admin;
    }
    else {
        return Role::User;
    }
}

#endif // DOMAIN_H
