add_subdirectory(hal)
add_subdirectory(app)

target_link_libraries(${EXECUTABLE_NAME}
    PUBLIC hal
)