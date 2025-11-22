cmake_minimum_required(VERSION 3.16)
project(MyQtApp LANGUAGES CXX)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
find_package(Qt6 REQUIRED COMPONENTS
    Core
    Gui
    Qml
    Quick
    QuickControls2
)
qt_policy(SET QTP0001 NEW)
qt_policy(SET QTP0004 NEW)
qt_standard_project_setup()

file(GLOB_RECURSE CPP_SOURCES CONFIGURE_DEPENDS "src/*.cpp")
file(GLOB_RECURSE HEADERS     CONFIGURE_DEPENDS "include/*.h")
file(GLOB_RECURSE QML_SOURCES CONFIGURE_DEPENDS 
    RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} 
    "src/*.qml"
)

qt_add_executable(my-qt-app
    ${CPP_SOURCES}
    ${HEADERS}
)
qt_add_qml_module(my-qt-app
    URI "MyQtApp"
    VERSION 1.0
    QML_FILES ${QML_SOURCES} 
)
target_include_directories(my-qt-app PRIVATE include)
target_link_libraries(my-qt-app PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
    Qt6::QuickControls2)

install(TARGETS my-qt-app DESTINATION bin)
