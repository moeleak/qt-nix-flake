cmake_minimum_required(VERSION 3.16)
project(MyQtApp LANGUAGES CXX)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
find_package(Qt6 REQUIRED COMPONENTS
    Core
    Gui
    Qml
)
qt_policy(SET QTP0001 NEW)
qt_policy(SET QTP0004 NEW)
qt_standard_project_setup()
qt_add_executable(my-qt-app
    src/main.cpp
)
qt_add_qml_module(my-qt-app
    URI "MyQtApp"
    VERSION 1.0
    QML_FILES src/Main.qml
)
target_link_libraries(my-qt-app PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml)

install(TARGETS my-qt-app DESTINATION bin)
