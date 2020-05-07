IMAGES =
IMAGES += devcore-ubuntu-18.04
IMAGES += devcore-ubuntu-16.04
IMAGES += devcore-ubuntu-14.04
IMAGES += devcore-ubuntu-12.04
IMAGES += devcore-centos-8
IMAGES += devcore-centos-7
IMAGES += devcore-centos-6
IMAGES += devcore-docker
IMAGES += core-ubuntu

CACHES_DIR =

all: $(patsubst %,.build-%,$(IMAGES))

push: $(patsubst %,.push-%,$(IMAGES))

.build-% : Dockerfile-%
	-@if test -n '$(CACHES_DIR)'; \
	 then \
	    mkdir -p $(CACHES_DIR); \
	    set -x; \
	    docker load -i $(CACHES_DIR)/$*.tar; \
	 fi
	@echo Building $* Image:
	docker build \
	   -t zimbra/zm-base-os:$* \
	   --cache-from=zimbra/zm-base-os:$* \
	   $(BUILD_EXTRA_ARGS) \
	   -f $< .
	-@if test -n '$(CACHES_DIR)'; \
	 then \
	    set -x; \
	    docker save -o $(CACHES_DIR)/$*.tar zimbra/zm-base-os:$*; \
	 fi

.push-%:
	docker push zimbra/zm-base-os:$*
