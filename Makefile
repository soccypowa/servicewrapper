VERSION ?= dev
BUILD_TIME := $(shell date -u '+%Y-%m-%d_%H:%M:%S')
GIT_COMMIT := $(shell git rev-parse --short HEAD 2>/dev/null || echo "unknown")
TARGETS := windows/amd64 windows/arm64

tidy:
	go mod tidy

build: $(TARGETS)
	
$(TARGETS):
	$(eval GOOS := $(word 1,$(subst /, ,$@)))
	$(eval GOARCH := $(word 2,$(subst /, ,$@)))
	@GOOS=$(GOOS) GOARCH=$(GOARCH) go build -ldflags "-X main.Version=$(VERSION) -X main.BuildTime=$(BUILD_TIME) -X main.GitCommit=$(GIT_COMMIT)" -o ./build/$(GOOS).$(GOARCH)/servicewrapper.exe servicewrapper.go

clean:
	@rm -rf build

.PHONY: tidy build $(TARGETS) clean