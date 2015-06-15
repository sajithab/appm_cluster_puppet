# ----------------------------------------------------------------------------
#  Copyright 2005-2015 WSO2, Inc. http://www.wso2.org
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
# ----------------------------------------------------------------------------
#
# Class: idp
#
# This class installs WSO2 AppManager as a store
# Actions:
#   - Install WSO2 AppManager as a store
#
# Requires:
#
# Sample Usage:
#

class store (

  $version            = undef,
  $sub_cluster_domain = undef,
  $members            = undef,
  $local_member_host  = undef,
  $offset             = 0,
  $hazelcast_port     = 4100,
  $thrift_receive_port= undef,
  $config_db          = 'governance',
  $config_target_path = 'config/as',  
  $maintenance_mode   = true,
  $depsync            = false,
  $clustering         = true,
  $cloud              = false,
  $owner              = 'root',
  $group              = 'root',
  $target             = "/mnt/${server_ip}",

) inherits params {

  $deployment_code = 'store'
  $carbon_version  = $version
  $service_code    = 'appm'
  $carbon_home     = "${target}/wso2${service_code}-${carbon_version}"
  $service_templates = [
    'conf/app-manager.xml',
    'conf/carbon.xml',
    'conf/registry.xml',
    'conf/user-mgt.xml',
    'conf/sso-idp-config.xml',
    'conf/datasources/master-datasources.xml',
    'conf/axis2/axis2.xml',
    #'deployment/server/jaggeryapps/store/controllers/login.jag',
  ]

  tag($service_code)

  store::clean { $deployment_code:
    mode   => $maintenance_mode,
    target => $carbon_home,
  }

  store::initialize { $deployment_code:
    repo      => $package_repo,
    version   => $carbon_version,
    service   => $service_code,
    local_dir => $local_package_dir,
    target    => $target,
    mode      => $maintenance_mode,
    owner     => $owner,
    require   => Store::Clean[$deployment_code],
  }

  store::deploy { $deployment_code:
    security => true,
    owner    => $owner,
    group    => $group,
    target   => $carbon_home,
    require  => Store::Initialize[$deployment_code],
  }

  store::push_templates {
    $service_templates:
      target    => $carbon_home,
      directory => $deployment_code,
      require   => Store::Deploy[$deployment_code];
  }

  store::start { $deployment_code:
    owner   => $owner,
    target  => $carbon_home,
    require => [
      Store::Initialize[$deployment_code],
      Store::Deploy[$deployment_code],
      Store::Push_templates[$service_templates],
      ],
  }
}
