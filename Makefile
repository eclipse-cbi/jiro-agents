#*******************************************************************************
# Copyright (c) 2018 Eclipse Foundation and others.
# This program and the accompanying materials are made available
# under the terms of the Eclipse Public License 2.0
# which is available at http://www.eclipse.org/legal/epl-v20.html,
# or the MIT License which is available at https://opensource.org/licenses/MIT.
# SPDX-License-Identifier: EPL-2.0 OR MIT
#*******************************************************************************

.PHONY: all clean dockertools jsonnet

.dockertools:
	./gitw sparsecheckout https://github.com/eclipse-cbi/dockertools.git $@
	
.jsonnet: 
	./gitw sparsecheckout https://github.com/google/jsonnet.git $@

.jsonnet/jsonnet: .jsonnet
	make -C .jsonnet

all: .dockertools .jsonnet/jsonnet
	./build.sh

clean: 
	rm -rf .jsonnet .dockertools 
	find . -maxdepth 2 -name target -exec rm -rf '{}' +
