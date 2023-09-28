# Sources
target_sources(${EXECUTABLE_NAME} PRIVATE
    main.c
)

# Header directories
target_include_directories(${EXECUTABLE_NAME} PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
)