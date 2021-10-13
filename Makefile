target = playground
cclibs = -lgit2
ccinclude = -L../libgit2/build -I../libgit2/include
CC = gcc
CPPFLAGS = -g -Wall
soflags =
ldflags =

cpp_source = $(shell find src -type f -name "*.c" ! -path "src/include*")
cpp_source_tmp = $(subst src, tmp, $(cpp_source))
cpp_source_without = $(subst src\/, , $(cpp_source))

cpp_headers = $(shell find src -type f -name "*.h" ! -path "src/include*")
cpp_headers_tmp = $(subst src, tmp, $(cpp_headers))

cpp_objects = $(patsubst %.c, %.o, $(cpp_source))
cpp_objects_tmp = $(patsubst %.c, %.o, $(cpp_source_tmp))
cpp_objects_without = $(patsubst src\/, , $(cpp_source))

.PHONY: default clean
default: dist/$(target)

$(cpp_objects) : %.o : %.c
	@mkdir -p $(dir $@)
	@echo -e "   CC      $<"
	@$(CC) $(CPPFLAGS) $(soflags) $(ccinclude) -c $< -o $@

dist/$(target): $(cpp_objects)
	@mkdir -p $(dir dist/$(target))
	@echo -e "   CC      $@"
	@$(CC) $(cpp_objects) -Wall $(ccinclude) $(cclibs) -o $@

clean:
	@echo -e "   RM      tmp"
	@find src -name "*.o" | xargs rm 

	@echo -e "   RM      dist/$(target)"
	@rm -f dist/$(target)