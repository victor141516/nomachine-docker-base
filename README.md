# NoMachine Docker base image

## See Firefox.Dockerfile as example
Run the Firefox example with:
```
docker build -t firefox -f Firefox.Dockerfile .
docker run -it --rm -p 4000:4000 --cap-add=SYS_PTRACE firefox
```
