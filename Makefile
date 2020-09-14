

include lp_geomet-data-registry.env 

BASEDIR=/data/geomet/afsslor

clean: stop
	geomet-data-registry store teardown
	geomet-data-registry tileindex teardown

clean-logs:
	rm -fr $(XDG_CACHE_HOME)/*

flake8:
	find . -type f -name "*.py" | grep -v geomet_data_registry/event.py | xargs flake8

setup:
	geomet-data-registry store setup
	geomet-data-registry tileindex setup
	
	geomet-data-registry store set -k cansips -c $(BASEDIR)/geomet-data-registry/deploy/default/cansips.yml
	geomet-data-registry store set -k geps -c $(BASEDIR)/geomet-data-registry/deploy/default/geps.yml
	geomet-data-registry store set -k model_gem_global -c $(BASEDIR)/geomet-data-registry/deploy/default/model_gem_global.yml
	geomet-data-registry store set -k model_gem_regional -c $(BASEDIR)/geomet-data-registry/deploy/default/model_gem_regional.yml
	geomet-data-registry store set -k model_giops -c $(BASEDIR)/geomet-data-registry/deploy/default/model_giops.yml
	geomet-data-registry store set -k model_hrdps_continental -c $(BASEDIR)/geomet-data-registry/deploy/default/model_hrdps_continental.yml
	geomet-data-registry store set -k reps -c $(BASEDIR)/geomet-data-registry/deploy/default/reps.yml
	geomet-data-registry store set -k radar -c $(BASEDIR)/msc-geomet-data-registry/conf/radar.yml
	
start:	
	sr_subscribe start $(BASEDIR)/geomet-data-registry/deploy/default/sarracenia/cansips.conf
	sr_subscribe start $(BASEDIR)/geomet-data-registry/deploy/default/sarracenia/geps.conf
	sr_subscribe start $(BASEDIR)/geomet-data-registry/deploy/default/sarracenia/model_gem_global.conf
	sr_subscribe start $(BASEDIR)/geomet-data-registry/deploy/default/sarracenia/model_gem_regional.conf
	sr_subscribe start $(BASEDIR)/geomet-data-registry/deploy/default/sarracenia/model_giops.conf
	sr_subscribe start $(BASEDIR)/geomet-data-registry/deploy/default/sarracenia/model_hrdps_continental.conf
	sr_subscribe start $(BASEDIR)/geomet-data-registry/deploy/default/sarracenia/reps.conf
	sr_subscribe start $(BASEDIR)/msc-geomet-data-registry/conf/sarracenia/radar.conf

stop:
	sr_subscribe stop $(BASEDIR)/geomet-data-registry/deploy/default/sarracenia/cansips.conf
	sr_subscribe stop $(BASEDIR)/geomet-data-registry/deploy/default/sarracenia/geps.conf
	sr_subscribe stop $(BASEDIR)/geomet-data-registry/deploy/default/sarracenia/model_gem_global.conf
	sr_subscribe stop $(BASEDIR)/geomet-data-registry/deploy/default/sarracenia/model_gem_regional.conf
	sr_subscribe stop $(BASEDIR)/geomet-data-registry/deploy/default/sarracenia/model_giops.conf
	sr_subscribe stop $(BASEDIR)/geomet-data-registry/deploy/default/sarracenia/model_hrdps_continental.conf
	sr_subscribe stop $(BASEDIR)/geomet-data-registry/deploy/default/sarracenia/reps.conf
	sr_subscribe stop $(BASEDIR)/msc-geomet-data-registry/conf/sarracenia/radar.conf

.PHONY: clean clean-logs setup stop start
