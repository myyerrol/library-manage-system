# Library Managememt System
## Develop Environment:
- GNU/Linux Ubuntu-14.04.3-LTS
- GNU/Linux kernel: 3.19.0-25-generic
- GNU/GCC: 4.8.2
- GNU/G++: 4.8.4
- GNU/GDB: 7.7.1
- Qt Creator: 3.0.1
- Qt: 5.2.1
- MySQL: 5.5.46

## Develop Description:
The **Library Management System** is a simple **Database** project. Qt is used for building the GUI of user and implement SQL's insert, search, update and delete operations by invoking QSql libraries. MySQL is used for storaging original data. For more detail informations about project, you can find documents in **doc** directory.

- **bin**: This file directory include executable binary file.
- **doc**: This file directory include created and backup MySQL files, project documentations and project flowcharts.
- **src**: This file directory include project's all source codes.

## Develop Configure:
Ensure that your operating system has been installed the MySQL software and open service. Under Linux MySQL installation is very simple, just run the below command
``` bash
sudo apt-get install mysql-server
```

In the process of installing MySQL softwares, you need to set up a database administrator account and the administrator password. After installing you can perform command to log into the MySQL database.
``` bash
mysql -u username -p password
```

In the project doc directory, there is a library management_system_backup.sql, you can use the terminal switch to the doc directory and execute command to restore good database has been created.
``` bash
mysql -u username -p password [database name] < library_management_system_backup.sql
```

Because we are using the MySQL InnoDB storage engine, so there is no way to directly copy the entire data directory to be backed up.Open a Linux terminal, switch to the bin directory of the file, execute follow command to run the program.
``` bash
./library_management_system
```
