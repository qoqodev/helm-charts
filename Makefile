repo := https://helm.qoqo.dev

ifndef chart
$(error chart is not set)
endif

name := $(shell grep name $(chart)/Chart.yaml | cut -d: -f2 | tr -d ' ')
version := $(shell grep version $(chart)/Chart.yaml | cut -d: -f2 | tr -d ' ')

default: index

index:
	mkdir -p docs/charts
	helm package $(chart) -d docs/charts
	helm repo index docs/charts/ --url $(repo)/charts
	mv docs/charts/index.yaml docs/index.yaml
	ruby index.rb docs/index.yaml > docs/index.html

commit:
	if [ "${CI}" != "true" ]; then echo CI env var must be true for $@; exit 1; fi
	git add docs/
	git commit -m "[ci] Add $(name)-$(version) to index"
