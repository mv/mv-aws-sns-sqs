# vim:ft=make:ts=8:sts=8:sw=8:noet:tw=80:nowrap:list

###
### tasks
###
.PHONY: help show vt cs us ds se desc test

all: help

help:
	@echo "Organization: [${ORG_NAME}]"
	@echo
	@echo " Usage: fast"
	@echo "    $$ file=filename                                      make vt - validate-template"
	@echo "    $$ file=filename [stack=stackname] [param=param.json] make cs - create-stack"
	@echo "    $$ file=filename [stack=stackname] [param=param.json] make us - update-stack"
	@echo "    $$ file=filename [stack=stackname]                    make ds - delete-stack"
	@echo "    $$ file=filename [stack=stackname]                    make se - stack-events"
	@echo
	@echo " Usage: faster"
	@echo "    $$ export file=filename"
	@echo "    $$ export stack=stackname"
	@echo "    $$ export param=param.json"
	@echo "    $$ make vt"
	@echo "    $$ make cs"
	@echo "    $$ make us"
	@echo "    $$ make ds force=y"
	@echo "    $$ make se"
	@echo
	@echo " Others:"
	@echo "    $$ make show - Show env vars: file=, stack=, param="
	@echo
	@echo "    $$ make pub  stack=stackname [count] [sleep]"
	@echo "                 - Publish into topic created in stackname"
	@echo


show:
	@echo "-- Env:"
	@echo "--     file=${file}"
	@echo "--     stack=${stack}"
	@echo "--     param=${param}"
	@[ "${force}" ] && echo "--     force=${force}" || echo

cs:
	@ file=${file} stack=${stack} param=${param} \
	util/create-stack.sh

us:
	@ file=${file} stack=${stack} param=${param} \
	util/update-stack.sh

vt:
	@ file=${file} util/validate-template.sh

ds:
	@if [ "${stack}" ] ;\
	then util/delete-stack.sh ${stack} ${force} ;\
	else util/delete-stack.sh ${file} ${force} ;\
	fi

se:
	@if [ "${stack}" ] ;\
	then util/stack-events.sh ${stack} ;\
	else util/stack-events.sh ${file} ;\
	fi


desc:
	aws cloudformation describe-stacks \
	--output text \
	--query 'Stacks[*].{Name:StackName, Created:CreationTime, Status:StackStatus}' \
	| awk '{print $$1,$$3,$$2}' \
	| column -t | sort

pub:
	test/test-publish.sh ${stack}  ${count}  ${sleep}


