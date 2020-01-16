#*******************************************************************************
# Copyright (c) 2018 Eclipse Foundation and others.
# This program and the accompanying materials are made available
# under the terms of the Eclipse Public License 2.0
# which is available at http://www.eclipse.org/legal/epl-v20.html,
# or the MIT License which is available at https://opensource.org/licenses/MIT.
# SPDX-License-Identifier: EPL-2.0 OR MIT
#*******************************************************************************

DOCKERTOOLS_PATH=.dockertools
JSONNET_PATH=.jsonnet

.PHONY: all clean dockertools jsonnet

dockertools:
	./gitw sparsecheckout https://github.com/eclipse-cbi/dockertools.git ${DOCKERTOOLS_PATH}
	
jsonnet: 
	./gitw sparsecheckout https://github.com/google/jsonnet.git ${JSONNET_PATH}

.jsonnet/jsonnet: .jsonnet
	make -C .jsonnet

all:  dockertools .jsonnet/jsonnet
	./build.sh

clean: clean_all_instances
	.dockertools/dockerw clean
