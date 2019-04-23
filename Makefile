export STACKNAME = $(STACK_NAME)
export COREHOST = $(CORE_HOST)
export TESTCONFIG = $(TEST_CONFIG)
export GRIDURL = $(GRID_URL)
export PPHOST = $(PP_HOST)
export DSHOST = $(DS_HOST)
export ADCOSTHOST = $(ADCOST_HOST)
export AMQHOST = $(AMQ_HOST)
export MAILSERVICEHOST = $(MAILSERVICE_HOST)
export MONGOHOST = $(MONGO_HOST)
export GAHOST = $(GA_HOST)
export GDNHOST = $(GDN_HOST)
export STORAGE_ID = $(STORAGEID)
export ADCOSTENABLED = $(ADCOST_ENABLED)



update:
	sed -i "s!STACK_NAME!$(STACKNAME)!g" ./Tests/resources/properties/$(TESTCONFIG)
	sed -i "s!CORE_HOST!$(COREHOST)!g" ./Tests/resources/properties/$(TESTCONFIG)
	sed -i "s!PP_HOST!$(PPHOST)!g" ./Tests/resources/properties/$(TESTCONFIG)
	sed -i "s!DS_HOST!$(DSHOST)!g" ./Tests/resources/properties/$(TESTCONFIG)
	sed -i "s!ADCOST_HOST!$(ADCOSTHOST)!g" ./Tests/resources/properties/$(TESTCONFIG)
	sed -i "s!AMQ_HOST!$(AMQHOST)!g" ./Tests/resources/properties/$(TESTCONFIG)
	sed -i "s!MAILSERVICE_HOST!$(MAILSERVICEHOST)!g" ./Tests/resources/properties/$(TESTCONFIG)
	sed -i "s!MONGO_HOST!$(MONGOHOST)!g" ./Tests/resources/properties/$(TESTCONFIG)
	sed -i "s!GA_HOST!$(GAHOST)!g" ./Tests/resources/properties/$(TESTCONFIG)
	sed -i "s!GDN_HOST!$(GDNHOST)!g" ./Tests/resources/properties/$(TESTCONFIG)
	sed -i "s!STORAGEID!$(STORAGE_ID)!g" ./Tests/resources/properties/$(TESTCONFIG)
	sed -i "s!ADCOST_ENABLED!$(ADCOSTENABLED)!g" ./Tests/resources/properties/$(TESTCONFIG)

run: update
	mvn clean test -P regression-suite -Dfile.encoding=utf-8 -DtestConfig=Tests/resources/properties/${TESTCONFIG} -DwebDriverGridRemoteUrl=$(GRIDURL)/wd/hub -Duser.timezone="Europe/London"

updateuat:
	sed -i "s!STACK_NAME!$(STACKNAME)!g" ./Tests/resources/properties/$(TESTCONFIG)
	sed -i "s!CORE_HOST!$(COREHOST)!g" ./Tests/resources/properties/$(TESTCONFIG)
	sed -i "s!PP_HOST!$(PPHOST)!g" ./Tests/resources/properties/$(TESTCONFIG)
	sed -i "s!DS_HOST!$(DSHOST)!g" ./Tests/resources/properties/$(TESTCONFIG)
	sed -i "s!GA_HOST!$(GAHOST)!g" ./Tests/resources/properties/$(TESTCONFIG)

runuat: updateuat
	mvn clean test -P regression-suite -Dfile.encoding=utf-8 -DtestConfig=Tests/resources/properties/${TESTCONFIG} -DwebDriverGridRemoteUrl=$(GRIDURL)/wd/hub -Duser.timezone="Europe/London"


.PHONY: run update runuat updateuat
