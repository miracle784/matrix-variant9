CXX = g++
CXXFLAGS = -Wall -Wextra -std=c++17
TARGET = matrix_variant9
SRC = main.cpp

all: $(TARGET)

$(TARGET): $(SRC)
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(SRC)

clean:
	rm -f $(TARGET)
