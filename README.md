# Calling Golang Functions from Java using C Shared Libraries

## Requirements
- [Go](https://go.dev/)
- [Maven](https://maven.apache.org/index.html)

## How to build
There is a provided `Makefile` with all the build targets.

### Build JAR
```bash
make build
```
This creates a `java-call-go-1.0-SNAPSHOT-jar-with-dependencies.jar` in the `target/` directory.

### Test
```bash
make test
```

## References
- [call-go-function-from-java-demo](https://github.com/freewind-demos/call-go-function-from-java-demo)
- [go-cshared-examples](https://github.com/vladimirvivien/go-cshared-examples)
